import 'dart:developer';

import 'package:creconobe_transformation/models/dashboardModel.dart';
import 'package:creconobe_transformation/models/payment_model.dart';
import 'package:creconobe_transformation/models/profileModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:logger/logger.dart';

import '../models/albumById.dart';
import '../models/audioPlayListModel.dart';
import '../models/booksMainModel.dart';
import '../models/forgotPasswordModel.dart';
import '../models/login_signup_model.dart';
import '../models/subscriptionModel.dart';
import 'customInterceptor.dart';
part 'api_interface.g.dart';

//https://creconobehub.com/public/api/podcastByAlbum
@RestApi(baseUrl: "https://creconobehub.com/public/api/")
abstract class ApiInterface {
  //factory ApiInterface(Dio dio,{String baseUrl})= _ApiInterface;

  factory ApiInterface(Dio dio, {String? baseUrl}) {
    dio.interceptors.add(CustomInterceptor()); // Add your custom interceptor

    var data = _ApiInterface(dio, baseUrl: baseUrl);
    print("ApiInterface ${data._dio.printError}");
    return data;
  }

  @POST("login")
  Future<LoginSignupModel> getLogin(@Field() String email, @Field() String password);

  @POST('signup')
  Future<LoginSignupModel> getSignup(@Field() String name, @Field() String email, @Field() String password);

  @POST("setprofile")
  Future<LoginSignupModel> setProfile(@Field() String token, @Field() String name);

  @POST('getprofile')
  @FormUrlEncoded()
  Future<ProfileModel> getProfile(@Field() String token);

  @POST('forget_password')
  Future<ForgotPasswordModel> getForgotPassword(@Field() String email);

  @POST('podcasts')
  Future<AudioPlayListModel> getAllPlaylist(@Field() String token, @Field() String category, @Field() String tag);

  @POST('ebooks')
  Future<BooksMainModel> getAlleBooks(@Field() String token, @Field() String tag);

  @POST('ebookById')
  Future<LoginSignupModel> getEBooksbyId(@Field() String token, @Field() String id);

  @POST('payment')
  Future<Payment_Model> getPayment(@Field() String token, @Field() String subscription_id);

  @POST('podcastByAlbum')
  Future<AlbumById> getAlbumbyId(@Field() String token, @Field() String id);

  @POST('dashboard')
  @FormUrlEncoded()
  Future<DashboardModel> getDashboard(@Field() String token);

  @POST('subscriptions')
  @FormUrlEncoded()
  Future<SubscriptionModel> getSubscriptions(@Field() String token);
}
