// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_interface.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiInterface implements ApiInterface {
  _ApiInterface(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://creconobehub.com/public/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginSignupModel> getLogin(
    String email,
    String password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'email': email,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<LoginSignupModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'login',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = LoginSignupModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginSignupModel> getSignup(
    String name,
    String email,
    String password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'name': name,
      'email': email,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<LoginSignupModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'signup',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = LoginSignupModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<LoginSignupModel> setProfile(
    String token,
    String name,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'name': name,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<LoginSignupModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'setprofile',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = LoginSignupModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ProfileModel> getProfile(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};

    try {
      final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<ProfileModel>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
        contentType: 'application/x-www-form-urlencoded',
      )
          .compose(
            _dio.options,
            'getprofile',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
              baseUrl: _combineBaseUrls(
            _dio.options.baseUrl,
            baseUrl,
          ))));
      final value = ProfileModel.fromJson(_result.data!);
      return value;
    } catch (e) {
      return Future.error("Please connect to the network");
    }
  }

  @override
  Future<ForgotPasswordModel> getForgotPassword(String email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<ForgotPasswordModel>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          'forget_password',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = ForgotPasswordModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AudioPlayListModel> getAllPlaylist(
    String token,
    String category,
    String tag,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'category': category,
      'tag': tag,
    };

    try {
      final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<AudioPlayListModel>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            'podcasts',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
              baseUrl: _combineBaseUrls(
            _dio.options.baseUrl,
            baseUrl,
          ))));
      log("_result.data!--------------> ${_result.data!}");

      final value = AudioPlayListModel.fromJson(_result.data!);
      return value;
    } catch (e) {
      return Future.error("Please connect to the network");
    }
  }

  @override
  Future<BooksMainModel> getAlleBooks(
    String token,
    String tag,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'tag': tag,
    };

    try {
      final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BooksMainModel>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            'ebooks',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
              baseUrl: _combineBaseUrls(
            _dio.options.baseUrl,
            baseUrl,
          ))));
      final value = BooksMainModel.fromJson(_result.data!);
      return value;
    } catch (e) {
      return Future.error("Please connect to the network");
    }
  }

  @override
  Future<LoginSignupModel> getEBooksbyId(
    String token,
    String id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'id': id,
    };

    try {
      final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<LoginSignupModel>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            'ebookById',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
              baseUrl: _combineBaseUrls(
            _dio.options.baseUrl,
            baseUrl,
          ))));
      final value = LoginSignupModel.fromJson(_result.data!);
      return value;
    } catch (e) {
      return Future.error("Please connect to the network");
    }
  }

  @override
  Future<Payment_Model> getPayment(
    String token,
    String subscription_id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'subscription_id': subscription_id,
    };

    try {
      final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<Payment_Model>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            'payment',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
              baseUrl: _combineBaseUrls(
            _dio.options.baseUrl,
            baseUrl,
          ))));
      final value = Payment_Model.fromJson(_result.data!);
      return value;
    } catch (e) {
      return Future.error("Please connect to the network");
    }
  }

  @override
  Future<AlbumById> getAlbumbyId(
    String token,
    String id,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'token': token,
      'id': id,
    };

    try {
      final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<AlbumById>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
      )
          .compose(
            _dio.options,
            'podcastByAlbum',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
              baseUrl: _combineBaseUrls(
            _dio.options.baseUrl,
            baseUrl,
          ))));
      final value = AlbumById.fromJson(_result.data!);
      return value;
    } catch (e) {
      return Future.error("Please connect to the network");
    }
  }

  @override
  Future<DashboardModel> getDashboard(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};
    try {
      final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<DashboardModel>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
        contentType: 'application/x-www-form-urlencoded',
      )
          .compose(
            _dio.options,
            'dashboard',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
              baseUrl: _combineBaseUrls(
            _dio.options.baseUrl,
            baseUrl,
          ))));
      final value = DashboardModel.fromJson(_result.data!);
      return value;
    } catch (e) {
      return Future.error("Please connect to the network");
    }
  }

  @override
  Future<SubscriptionModel> getSubscriptions(String token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'token': token};

    try {
      final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<SubscriptionModel>(Options(
        method: 'POST',
        headers: _headers,
        extra: _extra,
        contentType: 'application/x-www-form-urlencoded',
      )
          .compose(
            _dio.options,
            'subscriptions',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(
              baseUrl: _combineBaseUrls(
            _dio.options.baseUrl,
            baseUrl,
          ))));
      final value = SubscriptionModel.fromJson(_result.data!);
      return value;
    } catch (e) {
      return Future.error("Please connect to the network");
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
