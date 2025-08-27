import 'package:dio/dio.dart';
import 'package:easy_life/Core/Constant/api_urls.dart';

class HomeDatasource {
  final Dio privateDio;
  HomeDatasource({required this.privateDio});

  Future<Response> getSliders() async {
    return await privateDio.post(
      ApiUrls.sliders,
      queryParameters: {'per_page': -1},
    );
  }
}
