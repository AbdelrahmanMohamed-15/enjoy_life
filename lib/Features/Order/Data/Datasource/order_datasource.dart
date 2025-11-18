import 'package:dio/dio.dart';
import 'package:easy_life/Core/Constant/api_urls.dart';

class OrderDatasource {
  final Dio privateDio;
  OrderDatasource({required this.privateDio});

  Future<Response> getPendingOrder() async =>
      privateDio.get(ApiUrls.pendingOrders);

  Future<Response> getCompletedOrder() async =>
      privateDio.get(ApiUrls.compelteOrders);

  Future<Response> getCancelledOrder() async =>
      privateDio.get(ApiUrls.cancleOrders);
}
