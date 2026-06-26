import 'package:dio/dio.dart';

import '../../../../Core/Constant/api_urls.dart';

class ProfileDatasource {
  final Dio privateDio;
  ProfileDatasource({required this.privateDio});

  Future<Response> getProfile() async {
    return await privateDio.get(ApiUrls.getProfile);
  }

  Future<Response> updateProfile({required FormData formData}) async {
    return await privateDio.post(ApiUrls.updateProfile, data: formData);
  }

  Future<Response> getAdditionalPage({required String type}) async {
    return await privateDio.post(
      ApiUrls.getAdditionalPage,
      data: {'type': type},
    );
  }

  Future<Response> deleteAccount() async {
    return await privateDio.delete(ApiUrls.deleteAccount);
  }
}
