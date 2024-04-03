import 'dart:convert';
import 'dart:developer';
import 'package:creconobe_transformation/models/payment_model.dart';
import 'package:creconobe_transformation/prefManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_super_html_viewer/flutter_super_html_viewer.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';
import '../apiservices/api_interface.dart';

class PaymentGateway extends StatefulWidget {
  final String id;
  const PaymentGateway(this.id, {Key? key}) : super(key: key);

  @override
  State<PaymentGateway> createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  Map<String, dynamic>? paymentIntent;

  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: FutureBuilder<Payment_Model>(
        future: getPaymentHtml(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.green));
          } else if (snapshot.hasData) {
            Payment_Model conditons = snapshot.data!;
            return Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: HtmlContentViewer(
                  htmlContent: conditons.htmlContent!,
                  initialContentHeight: MediaQuery.of(context).size.height,
                  initialContentWidth: MediaQuery.of(context).size.width,
                )
                /*
             Text(
               widget.stringValue == "Terms of Use"
                   ? conditons.termsofuse.toString()
                   : conditons.privacypolicy.toString(),
               style: TextStyle(
                 color: Colors.black,
                 fontSize: 14,
                 fontFamily: GoogleFonts.mulish.toString(),
                 fontWeight: FontWeight.w600,
                 height: 1.67,
               ),
             ),
*/
                );
          } else if (snapshot.hasError) {
            //  profileModel = snapshot!;
            return Center(child: Text("Encountered an error: ${snapshot.error}"));
          } else {
            return const Text("No internet connection");
          }
        },
      ),
    );
  }

  Future<Payment_Model> getPaymentHtml() async {
    ApiInterface apiInterface = ApiInterface(Dio());
    String? token = await PrefManager.getString("token");
    return apiInterface.getPayment(token!, widget.id);
  }
}
