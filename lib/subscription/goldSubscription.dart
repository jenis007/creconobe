// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:creconobe_transformation/authentication/login.dart';
import 'package:creconobe_transformation/dashboard/dashboardBottom.dart';
import 'package:creconobe_transformation/models/subscriptionModel.dart';
import 'package:creconobe_transformation/prefManager.dart';
import 'package:creconobe_transformation/subscription/controller/subscribe_controller.dart';
import 'package:creconobe_transformation/subscription/paymentGateway.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:http/http.dart' as http;

class GoldSubscription extends StatefulWidget {
  final Datum data;
  final ProductDetails? product;  final String? restoreSubscriptionId;
  const GoldSubscription(this.data, {super.key, this.product, this.restoreSubscriptionId});

  @override
  State<GoldSubscription> createState() => _GoldSubscription();
}

class _GoldSubscription extends State<GoldSubscription> {
  SubScribeController subScribeController = Get.put(SubScribeController());
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Stack(
        children: [
          Container(
            height: 480,
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 47,
                      height: 47,
                      margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Image.asset("assets/images/king_crown.png"),
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(5, 20, 0, 0),
                        child: Text(
                          widget.data.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontWeight: FontWeight.w700,
                          ),
                        ))
                  ],
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                  width: double.infinity,
                  height: 32,
                  child: Text(
                    'What You’ll Get',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Container(
                    margin: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: 249,
                          child: Text(
                            widget.data.description[0],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: 249,
                          child: Text(
                            widget.data.description[1],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    )),

                Container(
                    margin: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: 249,
                          child: Text(
                            widget.data.description[2],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    )),
                // Container(
                //     margin: const EdgeInsets.fromLTRB(25, 15, 0, 0),
                //     child: Row(
                //       children: [
                //         const Icon(
                //           Icons.check_circle,
                //           color: Colors.white,
                //         ),
                //         Container(
                //           margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                //           width: 249,
                //           child: Text(
                //             widget.data.description[2],
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 18,
                //               fontFamily: GoogleFonts.inter().fontFamily,
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //         )
                //       ],
                //     )),

                const SizedBox(
                  height: 20,
                ),

                //dotted lines
                Container(
                    margin: const EdgeInsets.fromLTRB(25, 15, 25, 0),

                    //  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: const DottedLine(
                      dashColor: Colors.white,
                    )),

                const Spacer(),
                Container(
                    margin: const EdgeInsets.fromLTRB(25, 10, 0, 15),
                    child: Text(
                      '\$ ${widget.data.price} for ${widget.data.validity}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.w700,
                      ),
                    )),

                //choose btn
                Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                        String name = await fullName();
                        if (Platform.isAndroid) {
                          if (name == "guest") {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Material(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                  child: Center(
                                    child: Container(
                                      width: MediaQuery.of(context).size.height * 0.35,
                                      height: MediaQuery.of(context).size.height * 0.25,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Please log in or register to access all of these features',
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
                                                      // margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text("Cancel",
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: GoogleFonts.athiti().fontFamily,
                                                                  color: Colors.green)),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      // margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                                            Navigator.pop(context);
                                                            Navigator.of(context)
                                                                .push(MaterialPageRoute(builder: (context) => Login()));
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
                                );
                              },
                            );
                          }else{
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const PaymentGateway("3");
                                },
                              ),
                            );
                          }
                        }
                        else {
                          if(widget.restoreSubscriptionId != ""){
                            if (name == "guest") {
                              restoreDialogue();
                            } else {
                              restorePurchase();
                            }
                          }else{
                            subScribeController.subscribe(product: widget.product);
                          }

                        }
                      },
                      child: Text(widget.restoreSubscriptionId != "" ? "Restore Purchase" :  widget.data.paid ? "Already Selected" : "Choose",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.athiti().fontFamily,
                              color: Colors.green)),
                    )),
              ],
            ),
          ),
          loading
              ? Container(
                color: Colors.grey.withOpacity(0.2),
                child: const Center(child: CircularProgressIndicator(color: Colors.white)),
              )
              : const SizedBox()
        ],
      ),
    )));
  }

  Future<String> fullName() async {
    String? token = await PrefManager.getString("name");
    return token.toString();
  }

  restorePurchase() async {
    setState(() {
      loading = true;
    });
    Map<String, String> header = {'Content-Type': 'application/json'};
    String? token = await PrefManager.getString("token");
    const String url = 'https://creconobehub.com/api/afterPaymentPost';
    final body = {"user_id": token, "subscription_id": widget.restoreSubscriptionId};
    http.Response response = await http.post(Uri.parse(url), headers: header, body: jsonEncode(body));
    if (response.statusCode == 200) {
      PrefManager.saveString("subscriptionId", "");
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Successful Restore Purchase'), backgroundColor: Colors.green));
      String? token = await PrefManager.getString("name");
      Get.offAll(() => DashboardBottom(token.toString()));
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          loading = false;
        });
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          loading = false;
        });
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Payment Unsuccessful.'), backgroundColor: Colors.red));
    }
  }

  restoreDialogue(){
    return  showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.height * 0.35,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Restore your ${widget.restoreSubscriptionId == "3" ? "gold" : "silver"} subscription!!! please register or login first.',
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
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel",
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
        );
      },
    );
  }
}
