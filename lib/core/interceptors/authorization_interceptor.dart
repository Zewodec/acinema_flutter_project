import 'package:acinema_flutter_project/features/login/data/data_source/token_local_datasource.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await TokenLocalDataSource.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // options.headers['Content-Type'] = 'application/json';

    super.onRequest(options, handler);
  }
}
