import 'package:dio/dio.dart';
import 'package:easy_life/Core/Helper/dependency_injection_helper.dart';

import '../../../../Core/Constant/api_urls.dart';
import '../../../../Core/Handler/auth_handler.dart';

class CartDatasource {
  final Dio privateDio;
  CartDatasource({required this.privateDio});

  Future<Response> getCart() async {
    return await privateDio.get(ApiUrls.getCart);
  }

  Future<Response> removeCartItem({required String rowID}) async {
    return await privateDio.post(
      ApiUrls.removeCartItem,
      data: {'rowId': rowID},
    );
  }

  Future<Response> updateCartItemQuantity({
    required String rowID,
    required String quantity,
  }) async {
    return await privateDio.post(
      ApiUrls.updateCartQuantityItem,
      data: {'rowId': rowID, 'qty': quantity},
    );
  }

  Future<Response> createOrder() async {
    final session = DependencyInjectionHelper()
        .sl<AuthHandlerInterface>()
        .getCookies();

    if (session == null || session.trim().isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(path: ApiUrls.createOrder),
        message: 'Cart session is not available',
      );
    }

    final token = session.split(';').first.split('=').last;
    return await privateDio.post(ApiUrls.createOrder, data: {'session': token});
  }

  Future<Response> storeSession({required String session}) async {
    return await privateDio.post(
      ApiUrls.storeClientSession,
      data: {'session': session},
    );
  }
}
