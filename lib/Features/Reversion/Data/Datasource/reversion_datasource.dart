import 'package:dio/dio.dart';

import '../../../../Core/Constant/api_urls.dart';

class ReversionDatasource {
  final Dio privateDio;
  ReversionDatasource({required this.privateDio});

  Future<Response> getVendorResturant({
    required String status,
    required int serviceID,
  }) async {
    return await privateDio.get(
      ApiUrls.getAllReversion,
      queryParameters: {'status': status, 'service': serviceID},
    );
  }

  Future<Response> scanOrder({required String qrCode}) async {
    return await privateDio.post(
      ApiUrls.scanOrder,
      data: {'order_code': qrCode},
    );
  }
}
