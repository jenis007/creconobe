import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CustomInterceptor extends Interceptor {


  /*@override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Perform tasks before the request is sent, e.g., add headers
   // options.headers["Authorization"] = "Bearer your_token_here";


    //debugPrint("Response received: ${response.data}");

    super.onRequest(options, handler);
  }*/

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Perform tasks on response, e.g., logging
    debugPrint("Response received: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Perform error handling tasks
    debugPrint("Error occurred: ${err.response?.statusCode} - ${err.message}");
    super.onError(err, handler);
  }
}
