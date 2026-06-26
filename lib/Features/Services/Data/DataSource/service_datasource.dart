import 'package:dio/dio.dart';
import 'package:easy_life/Core/Constant/api_urls.dart';

class ServiceDatasource {
  final Dio privateDio;
  ServiceDatasource({required this.privateDio});

  Future<Response> getResturantByID({required int resturantID}) async {
    return await privateDio.get('${ApiUrls.getResturantByID}$resturantID');
  }

  Future<Response> getHotelByID({required int hotelID}) async {
    return await privateDio.get('${ApiUrls.getHotelByID}$hotelID');
  }

  Future<Response> getTripByID({required int tripID}) async {
    return await privateDio.get('${ApiUrls.getTripByID}$tripID');
  }

  Future<Response> getAvaliableTables({
    required int resturantID,
    required String startDate,
    required String endDate,
  }) async {
    return await privateDio.post(
      ApiUrls.getAvaliableTables,
      data: {
        'restaurant_id': resturantID,
        'start_time': startDate,
        'end_time': endDate,
      },
    );
  }

  Future<Response> getAvaliableTrips({required int tripsID}) async {
    return await privateDio.post(
      ApiUrls.getAvaliableTrips,
      data: {'trip_id': tripsID},
    );
  }

  Future<Response> getAvaliableRooms({
    required int hotelID,
    required String startDate,
    required String endDate,
  }) async {
    return await privateDio.post(
      ApiUrls.getAvaliableRooms,
      data: {'hotel_id': hotelID, 'start_time': startDate, 'end_time': endDate},
    );
  }

  Future<Response> addToCart({
    required String type,
    int? id,
    int? branchID,
    int? tableID,
    int? roomID,
    int? tripID,
    String? startDate,
    String? endDate,
    int? optionID,
  }) async {
    Map<String, dynamic> data;
    if (type == 'service') {
      data = {'service_id': id, 'branch_id': branchID};
    } else if (type == 'service_option') {
      data = {'service_id': optionID, 'branch_id': branchID};
    } else if (type == 'table') {
      data = {
        'restaurantTable_id': tableID,
        'start_time': startDate,
        'end_time': endDate,
      };
    } else if (type == 'room') {
      data = {
        'hotelRoom_id': roomID,
        'start_time': startDate,
        'end_time': endDate,
      };
    } else {
      data = {'tripSchedule_id': tripID};
    }
    return await privateDio.post(ApiUrls.addToCart, data: data);
  }
}
