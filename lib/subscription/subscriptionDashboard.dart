// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:creconobe_transformation/authentication/login.dart';
import 'package:creconobe_transformation/dashboard/dashboardBottom.dart';
import 'package:creconobe_transformation/models/subscriptionModel.dart';
import 'package:creconobe_transformation/prefManager.dart';
import 'package:creconobe_transformation/subscription/freeSubscription.dart';
import 'package:creconobe_transformation/subscription/goldSubscription.dart';
import 'package:creconobe_transformation/subscription/silverSubscription.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:logger/logger.dart';

import '../../core/in_app_puchase/example_payment_queue_delegate.dart';
import '../apiservices/api_interface.dart';
import '../music/preview_music.dart';
import 'package:http/http.dart' as http;

class SubscriptionDashboard extends StatefulWidget {
  const SubscriptionDashboard({super.key});

  @override
  State<SubscriptionDashboard> createState() => _SubscriptionDashboardState();
}

class _SubscriptionDashboardState extends State<SubscriptionDashboard> with SingleTickerProviderStateMixin {
  late SubscriptionModel dataModel;
  String subscriptionId = "";
  String restoreSubscriptionId = "";
  bool loading = false;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final List<String> _productID = ["GOLDPLANS", "SILVERPLANS"];

  List<ProductDetails> _products = [];
  List<PurchaseDetails> _purchases = [];

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  bool _available = true;

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      getPurchaseProduct();
      getSubscriptionId();
    }
  }

  getSubscriptionId() async {
    restoreSubscriptionId = (await PrefManager.getString("subscriptionId"))!;
    setState(() {});
  }

  getPurchaseProduct() {
    final Stream<List<PurchaseDetails>> purchaseUpdated = _inAppPurchase.purchaseStream;

    try {
      _subscription = purchaseUpdated.listen(
        (List<PurchaseDetails> purchaseDetailsList) async {
          log('purchaseDetailsList-->>$purchaseDetailsList');

          _purchases.addAll(purchaseDetailsList);
          _listenToPurchaseUpdated(purchaseDetailsList);
        },
        onDone: () {
          log("onDone-----onDone");
          _subscription.cancel();
        },
        onError: (error) {
          log("error-----$error");
          _subscription.cancel();
        },
      );
    } catch (e) {
      log("e-----$e");
    }
    _initialize();
  }

  void _initialize() async {
    _available = await _inAppPurchase.isAvailable();
    print("_available---$_available");
    List<ProductDetails> products = await _getProducts(
      productIds: _productID.toSet(),
    );
    print("products---${products}");
    print("products---${products[0].price}");
    print("products---${products[0].title}");

    setState(() {
      _products = products;
    });
  }

  Future<List<ProductDetails>> _getProducts({Set<String>? productIds}) async {
    final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
        _inAppPurchase.getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(productIds!);

    return response.productDetails;
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    log('purchaseDetails.purchaseDetailsList------>${purchaseDetailsList}');
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      log('purchaseDetails.status------>${purchaseDetails.status}');
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          break;
        case PurchaseStatus.restored:
          if (purchaseDetails == purchaseDetailsList.last) {
            print("<<<---restore---data---successfully--->>>");
          }
          break;
        case PurchaseStatus.purchased:
          print('purchased successfully------${purchaseDetails.verificationData.localVerificationData} ');
          validateReceiptIos(purchaseDetails.verificationData.localVerificationData, purchaseDetails);

          break;

        case PurchaseStatus.canceled:
          print('PurchaseStatus.canceled ');

          break;
        case PurchaseStatus.error:
          print("purchaseDetails.error.message ${purchaseDetails.error!.message}");
          print("purchaseDetails.error.message ${purchaseDetails.error!.details}");
          break;
        default:
          break;
      }
      if (purchaseDetails.pendingCompletePurchase) {
        log('purchaseDetails--->${purchaseDetails}');
        await _inAppPurchase.completePurchase(purchaseDetails);
      }
    });
  }

  Future<http.Response> validateReceiptIos(receiptBody, purchaseDetails) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        loading = true;
      });
    });

    String? token = await PrefManager.getString("token");

    print('it called');
    const String url = 'https://creconobehub.com/api/verifyReceipt';
    log('url----->${url}');

    final body = {
      "test_mode": false,
      "password": "5d3193f379a243eca1ccbba09450fba1",
      "receipt-data": receiptBody,
      "exclude-old-transactions": false
    };
    Map<String, String> header = {'Content-Type': 'application/json'};

    log("body======1111111====$body");
    http.Response response = await http.post(Uri.parse(url), headers: header, body: jsonEncode(body));
    log("receiptBody----->>>>${json.encode(receiptBody)}");
    if (response.statusCode == 200) {
      _inAppPurchase.completePurchase(purchaseDetails);
      var data = jsonDecode(response.body);
      log('response--->${response.body}');
      if (data['data']['status'] == 0) {
        try {
          String? name = await PrefManager.getString("name");
          if (name == "guest") {
            showDialog(
              context: context,
              builder: (context) {
                return Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  child: Center(
                    child: IntrinsicHeight(
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.35,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Subscribed Successfully!! To access all the premium features please register or login first.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: GoogleFonts.athiti().fontFamily,
                                      color: Colors.black)),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.05,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          elevation: 5,
                                          minimumSize: const Size.fromHeight(50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        onPressed: () async {
                                          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                            setState(() {
                                              loading = false;
                                            });
                                          });
                                          PrefManager.saveString("subscriptionId", subscriptionId.toString());
                                          getSubscriptionId();
                                          Navigator.pop(context);
                                        },
                                        child: Text("Skip",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: GoogleFonts.athiti().fontFamily,
                                                color: Colors.green)),
                                      )),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                          child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          elevation: 5,
                                          minimumSize: const Size.fromHeight(50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                        ),
                                        onPressed: () async {
                                          PrefManager.saveString("subscriptionId", subscriptionId.toString());
                                          Navigator.pop(context);
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(builder: (context) => const Login()));
                                        },
                                        child: Text("LogIn",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: GoogleFonts.athiti().fontFamily,
                                                color: Colors.white)),
                                      )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            const String url = 'https://creconobehub.com/api/afterPaymentPost';
            final body = {"user_id": token, "subscription_id": subscriptionId};
            http.Response response = await http.post(Uri.parse(url), headers: header, body: jsonEncode(body));
            if (response.statusCode == 200) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  loading = false;
                });
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Payment Successful.'), backgroundColor: Colors.green));
              String? token = await PrefManager.getString("name");
              Get.offAll(() => DashboardBottom(token.toString()));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Payment Unsuccessful.'), backgroundColor: Colors.red));
            }
          }
        } catch (error) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            setState(() {
              loading = false;
            });
          });
          log(error.toString());
        }
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          loading = false;
        });
      });
      print('STATUS CODE--${response.statusCode}');
    }
    return response;
  }

  // TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Subscription",
            style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontSize: 20,color: Colors.white),
          ),
          centerTitle: true,  backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: PreviewMusic(),
        body: DefaultTabController(
          length: 3,
          child: FutureBuilder<SubscriptionModel>(
              future: getSubscrition(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // While the data is being fetched, show a loading indicator

                  return const Center(child: CircularProgressIndicator(color: Colors.green));
                } else if (snapshot.hasData) {
                  dataModel = snapshot.data!;
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                              height: 45,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25.0)),
                              child: TabBar(
                                physics: const NeverScrollableScrollPhysics(),
                                // controller: tabController,
                                indicator:
                                    BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(25.0)),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                onTap: (value) {
                                  subscriptionId = dataModel.data[value].id.toString();
                                  setState(() {});
                                  log("subscriptionId------->$subscriptionId");
                                },
                                tabs: const [
                                  Tab(
                                    text: 'FREE',
                                  ),
                                  Tab(
                                    text: 'SILVER',
                                  ),
                                  Tab(
                                    text: 'GOLD',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                FreeSubscription(dataModel.data[0]),
                                SilverSubscription(dataModel.data[1],
                                    product: _products.isEmpty ? null : _products[1],
                                    restoreSubscriptionId: restoreSubscriptionId),
                                GoldSubscription(dataModel.data[2],
                                    product: _products.isEmpty ? null : _products[0],
                                    restoreSubscriptionId: restoreSubscriptionId),
                              ],
                            ))
                          ],
                        ),
                      ),
                      loading
                          ? Expanded(
                              child: Container(
                              color: Colors.grey.withOpacity(0.2),
                              child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                            ))
                          : const SizedBox()
                    ],
                  );
                } else if (snapshot.hasError) {
                  //  profileModel = snapshot!;
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Text("No internet Found");
                }
              }),
        ));
  }

  Future<SubscriptionModel> getSubscrition() async {
    String? token = await PrefManager.getString("token");

    ApiInterface apiInterface = ApiInterface(Dio());

    final logger = Logger();
    SubscriptionModel model = await apiInterface.getSubscriptions(token.toString());

    logger.d("subscription ====>>>>${model.data.length}");
    return apiInterface.getSubscriptions(token.toString());
  }
}
