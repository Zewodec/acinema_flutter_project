import 'package:dio/dio.dart';

class AcceptLanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = 'uk';
    super.onRequest(options, handler);
  }
}
