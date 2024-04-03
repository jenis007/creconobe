import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermsAndCondition extends StatelessWidget{
  String url;
   TermsAndCondition(this.url ,{super.key});








   @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body:  InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)),
      ),

      
      //WebViewWidget(controller: controller),
    );
  }

}