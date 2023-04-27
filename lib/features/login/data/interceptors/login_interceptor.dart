import 'package:acinema_flutter_project/features/login/data/datasource/login_storage.dart';
import 'package:dio/dio.dart';

class LoginInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await LoginStorage.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Accept-Language'] = 'uk';
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }
}
