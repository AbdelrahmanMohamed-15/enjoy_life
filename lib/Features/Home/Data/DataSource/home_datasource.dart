import 'package:dio/dio.dart';
import 'package:easy_life/Core/Constant/api_urls.dart';

class HomeDatasource {
  final Dio privateDio;
  HomeDatasource({required this.privateDio});

  Future<Response> getSliders() async {
    return await privateDio.get(
      ApiUrls.sliders,
      queryParameters: {'per_page': -1},
    );
  }

  Future<Response> getResturant() async {
    return await privateDio.get(
      ApiUrls.getResturant,
      queryParameters: {'per_page': -1, 'take': 4},
    );
  }

  Future<Response> getHotels() async {
    return await privateDio.get(
      ApiUrls.getHotels,
      queryParameters: {'per_page': -1, 'take': 4},
    );
  }

  Future<Response> getTrips() async {
    return await privateDio.get(
      ApiUrls.getTrips,
      queryParameters: {'per_page': -1, 'take': 4},
    );
  }

  Future<Response> getVendorResturant() async {
    return await privateDio.get(
      ApiUrls.getVendorResturant,
      queryParameters: {'per_page': -1, 'take': 4},
    );
  }

  Future<Response> getVendorHotels() async {
    return await privateDio.get(
      ApiUrls.getVendoHotels,
      queryParameters: {'per_page': -1, 'take': 4},
    );
  }

  Future<Response> getVendorTrips() async {
    return await privateDio.get(
      ApiUrls.getVendoTrips,
      queryParameters: {'per_page': -1, 'take': 4},
    );
  }

  Future<Response> getTotalHome({required String type}) async {
    if (type.toLowerCase() == 'resturant' || type.toLowerCase() == 'مطعم') {
      return await privateDio.get(
        ApiUrls.getResturant,
        queryParameters: {'per_page': -1},
      );
    } else if (type.toLowerCase() == 'hotel' || type.toLowerCase() == 'فندق') {
      return await privateDio.get(
        ApiUrls.getHotels,
        queryParameters: {'per_page': -1},
      );
    } else {
      return await privateDio.get(
        ApiUrls.getTrips,
        queryParameters: {'per_page': -1},
      );
    }
  }

  Future<Response> getFavourite() async {
    return await privateDio.get(
      ApiUrls.getAllFavourite,
      queryParameters: {'per_page': -1},
    );
  }

  Future<Response> addFavourite({required int id, required String type}) async {
    return await privateDio.post(
      ApiUrls.addFavourite,
      data: type.toLowerCase() == 'resturant' || type.toLowerCase() == 'مطعم'
          ? {'type': 'restaurant', 'restaurant_id': id}
          : type.toLowerCase() == 'hotel' || type.toLowerCase() == 'فندق'
          ? {'type': 'hotel', 'hotel_id': id}
          : {'type': 'trip', 'trip_id': id},
    );
  }

  Future<Response> removeFavourite({
    required int id,
    required String type,
  }) async {
    return await privateDio.post(
      ApiUrls.removeFavourite,
      data: type.toLowerCase() == 'resturant' || type.toLowerCase() == 'مطعم'
          ? {'type': 'restaurant', 'restaurant_id': id}
          : type.toLowerCase() == 'hotel' || type.toLowerCase() == 'فندق'
          ? {'type': 'hotel', 'hotel_id': id}
          : {'type': 'trip', 'trip_id': id},
    );
  }

  Future<Response> search({required String query}) async {
    return await privateDio.get(
      ApiUrls.search,
      queryParameters: {'search': query},
    );
  }
}
