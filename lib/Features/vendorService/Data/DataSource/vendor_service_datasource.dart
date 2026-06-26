import 'package:dio/dio.dart';
import 'package:easy_life/Core/Constant/api_urls.dart';

class VendorServiceDatasource {
  final Dio privateDio;

  VendorServiceDatasource({required this.privateDio});

  Future<Response> createCategory({required FormData formData}) async {
    try {
      Response response = await privateDio.post(
        ApiUrls.createCategory,
        data: formData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createBranch({required FormData formData}) async {
    try {
      Response response = await privateDio.post(
        ApiUrls.createBranch,
        data: formData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllBranch() async {
    try {
      Response response = await privateDio.get(
        ApiUrls.getAllBranch,
        queryParameters: {'per_page': -1},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllCategory() async {
    try {
      Response response = await privateDio.get(
        ApiUrls.getAllCategory,
        queryParameters: {'per_page': -1},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllTripSchedule() async {
    try {
      Response response = await privateDio.get(
        ApiUrls.getAllTripSchedule,
        queryParameters: {'per_page': -1},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createResturant({
    required FormData formData,
    required bool isEdit,
    int? id,
  }) async {
    try {
      Response response = await privateDio.post(
        isEdit == false
            ? ApiUrls.createResturant
            : '${ApiUrls.createResturant}/$id',
        data: formData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createHotel({
    required FormData formData,
    required bool isEdit,
    int? id,
  }) async {
    try {
      Response response = await privateDio.post(
        isEdit == false ? ApiUrls.createHotel : '${ApiUrls.createHotel}/$id',
        data: formData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createTrip({
    required FormData formData,
    required bool isEdit,
    int? id,
  }) async {
    try {
      Response response = await privateDio.post(
        isEdit == false ? ApiUrls.createTrip : '${ApiUrls.createTrip}/$id',
        data: formData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> showResturant({required int id}) async {
    try {
      Response response = await privateDio.get(
        '${ApiUrls.createResturant}/$id',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> showHotel({required int id}) async {
    try {
      Response response = await privateDio.get('${ApiUrls.createHotel}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> showTrip({required int id}) async {
    try {
      Response response = await privateDio.get('${ApiUrls.createTrip}/$id');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAllService() async {
    try {
      Response response = await privateDio.get(
        ApiUrls.getAllService,
        queryParameters: {'per_page': -1},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createService({required FormData formData}) async {
    try {
      Response response = await privateDio.post(
        ApiUrls.createService,
        data: formData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> createServiceOtion({required FormData formData}) async {
    try {
      Response response = await privateDio.post(
        ApiUrls.createServiceOtions,
        data: formData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
