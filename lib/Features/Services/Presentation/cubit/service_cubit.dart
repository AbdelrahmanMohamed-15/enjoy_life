import 'package:easy_life/Core/Routes/app_navigation.dart';
import 'package:easy_life/Core/Routes/routes.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_life/Features/Services/Domain/Entity/room_entity.dart';
import 'package:easy_life/Features/Services/Domain/Entity/table_entity.dart';
import 'package:easy_life/Features/Services/Domain/Usecases/add_to_cart_usecases.dart';
import 'package:easy_life/Features/Services/Domain/Usecases/get_avaliable_tables_usecases.dart';
import 'package:easy_life/Features/Services/Domain/Usecases/get_avaliable_trips_usecases.dart';
import 'package:easy_life/Features/Services/Domain/Usecases/get_hotel_details_usecases.dart';
import 'package:easy_life/Features/Services/Domain/Usecases/get_resturant_details_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../../Core/Enums/level_message_enums.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../Domain/Entity/service_deatils_entity.dart';
import '../../Domain/Entity/trip_entity.dart';
import '../../Domain/Usecases/get_avaliable_rooms_usecases.dart';
import '../../Domain/Usecases/get_trip_details_usecases.dart';

part 'sevice_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit({
    required this.getResturantDetailsUsecases,
    required this.getHotelDetailsUsecases,
    required this.getTripDetailsUsecases,
    required this.getAvaliableTablesUsecases,
    required this.getAvaliableRoomsUsecases,
    required this.addToCartUsecases,
    required this.getAvaliableTripsUsecases,
  }) : super(ResturantInitial());

  static ServiceCubit get(context) => BlocProvider.of(context);

  // Variables of usecases
  final GetResturantDetailsUsecases getResturantDetailsUsecases;
  final GetHotelDetailsUsecases getHotelDetailsUsecases;
  final GetTripDetailsUsecases getTripDetailsUsecases;
  final GetAvaliableTablesUsecases getAvaliableTablesUsecases;
  final GetAvaliableRoomsUsecases getAvaliableRoomsUsecases;
  final AddToCartUsecases addToCartUsecases;
  final GetAvaliableTripsUsecases getAvaliableTripsUsecases;

  // Variables of entity
  ServiceDetailsEntity? serviceDetails;
  TableEntity? tableEntity;
  RoomEntity? roomEntity;
  TripEntity? tripEntity;

  // Variables of request state
  RequestState serviceRequestState = RequestState.initial;
  RequestState tableRequestState = RequestState.initial;
  RequestState roomRequestState = RequestState.initial;
  RequestState tripRequestState = RequestState.initial;

  // Variables of date
  DateTime? fromDate;
  TimeOfDay? fromTime;
  DateTime? toDate;
  TimeOfDay? toTime;

  getinitialData({required int id, required String type}) {
    var typeUpper = type.toUpperCase();
    if (typeUpper == 'Restaurant'.toUpperCase() || typeUpper == 'مطعم') {
      getResturantDetails(id: id);
    } else if (typeUpper == 'Hotel'.toUpperCase() || typeUpper == 'فندق') {
      getHotelDetails(id: id);
    } else if (typeUpper == 'Trip'.toUpperCase() || typeUpper == 'رحلة') {
      getTripDetails(id: id);
    }
  }

  Future<void> getResturantDetails({required int id}) async {
    emit(ResturantLoading());
    final res = await getResturantDetailsUsecases.call(resturantId: id);
    res.fold(
      (failure) {
        serviceRequestState = RequestState.error;
        emit(ResturantErrorState(requestState: serviceRequestState));
      },
      (resDetails) {
        serviceDetails = resDetails;
        if (resDetails.data != null) {
          emit(ResturantSuccessState(resturant: resDetails));
        } else {
          serviceRequestState = RequestState.empty;
          emit(ResturantErrorState(requestState: serviceRequestState));
        }
      },
    );
  }

  Future<void> getHotelDetails({required int id}) async {
    emit(HotelLoading());
    final res = await getHotelDetailsUsecases.call(hotelID: id);
    res.fold(
      (failure) {
        serviceRequestState = RequestState.error;
        emit(HotelErrorState(requestState: serviceRequestState));
      },
      (hotelDetails) {
        serviceDetails = hotelDetails;
        if (hotelDetails.data != null) {
          emit(HotelSuccessState(hotel: hotelDetails));
        } else {
          serviceRequestState = RequestState.empty;
          emit(HotelErrorState(requestState: serviceRequestState));
        }
      },
    );
  }

  Future<void> getTripDetails({required int id}) async {
    emit(TripLoading());
    final res = await getTripDetailsUsecases.call(tripID: id);
    res.fold(
      (failure) {
        serviceRequestState = RequestState.error;
        emit(TripErrorState(requestState: serviceRequestState));
      },
      (tripDetails) {
        serviceDetails = tripDetails;
        if (tripDetails.data != null) {
          emit(TripSuccessState(trip: tripDetails));
        } else {
          serviceRequestState = RequestState.empty;
          emit(TripErrorState(requestState: serviceRequestState));
        }
      },
    );
  }

  Future<void> selectDate({
    required BuildContext context,
    required bool isFrom,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isFrom) {
        fromDate = picked;
        emit(SetDateState(dateTime: picked));
      } else {
        toDate = picked;
        emit(SetDateState(dateTime: picked));
      }
    }
  }

  Future<void> selectTime({
    required BuildContext context,
    required bool isFrom,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      if (isFrom) {
        fromTime = picked;
        emit(SetTimeState(timeOfDay: picked));
      } else {
        toTime = picked;
        emit(SetTimeState(timeOfDay: picked));
      }
    }
  }

  clearSlots() {
    fromDate = null;
    fromTime = null;
    toDate = null;
    toTime = null;
  }

  getAvaliableTables({
    required int resturantID,
    required String startDate,
    required String endDate,
    required String title,
    required ServiceCubit serviceCubit,
  }) async {
    debugPrint('tables.data tables');
    EasyLoading.show();
    final res = await getAvaliableTablesUsecases.call(
      resturantID: resturantID,
      startDate: startDate,
      endDate: endDate,
    );
    res.fold(
      (failure) {
        EasyLoading.dismiss();
        AppNavigation.pop();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (tables) {
        EasyLoading.dismiss();
        tableEntity = tables;
        debugPrint('tables.data ${tables.data}');
        if (tables.data != null) {
          AppNavigation.pop();
          AppNavigation.pushNamed(
            AppRoutes.tablesScreen,
            arguments: {
              'tableData': tables.data,
              'title': title,
              'serviceCubit': serviceCubit,
              'startDate': startDate,
              'endDate': endDate,
            },
          );
        } else {
          serviceRequestState = RequestState.empty;
          emit(ErrorAvaliableTables(requestState: serviceRequestState));
        }
      },
    );
  }

  getAvaliableRooms({
    required int hotelID,
    required String startDate,
    required String endDate,
    required String title,
    required ServiceCubit serviceCubit,
  }) async {
    EasyLoading.show();
    final res = await getAvaliableRoomsUsecases.call(
      hotelID: hotelID,
      startDate: startDate,
      endDate: endDate,
    );
    res.fold(
      (failure) {
        EasyLoading.dismiss();
        AppNavigation.pop();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (rooms) {
        EasyLoading.dismiss();
        roomEntity = rooms;
        if (rooms.data != null) {
          AppNavigation.pop();
          AppNavigation.pushNamed(
            AppRoutes.roomScreen,
            arguments: {
              'tableData': rooms.data,
              'title': title,
              'serviceCubit': serviceCubit,
              'startDate': startDate,
              'endDate': endDate,
            },
          );
        } else {
          serviceRequestState = RequestState.empty;
          emit(ErrorAvaliableRooms(requestState: serviceRequestState));
        }
      },
    );
  }

  Future<bool> addToCart({
    required String type,
    int? id,
    int? branchID,
    int? tableID,
    int? roomID,
    int? tripID,
    String? startDate,
    String? endDate,
    int? optionID,
    bool showLoading = true,
    bool showMessage = true,
  }) async {
    if (showLoading) {
      EasyLoading.show();
    }
    final res = await addToCartUsecases.call(
      type: type,
      id: id,
      branchID: branchID,
      tableID: tableID,
      roomID: roomID,
      tripID: tripID,
      startDate: startDate,
      endDate: endDate,
      optionID: optionID,
    );
    return res.fold(
      (failure) {
        if (showLoading) {
          EasyLoading.dismiss();
        }
        if (showMessage) {
          showCustomSnackBar(
            failure.message,
            backgroundColor: AppColors.darkRed,
          );
        }
        return false;
      },
      (cart) {
        if (showLoading) {
          EasyLoading.dismiss();
        }
        final success = cart.status == 200;
        if (showMessage) {
          showCustomSnackBar(
            cart.message ?? '',
            backgroundColor: success ? AppColors.primary400 : AppColors.darkRed,
          );
        }
        return success;
      },
    );
  }

  getAvaliableTrips({
    required int tripID,
    required String title,
    required ServiceCubit serviceCubit,
  }) async {
    EasyLoading.show();
    final res = await getAvaliableTripsUsecases.getAvaliableTrips(
      tripID: tripID,
    );
    res.fold(
      (failure) {
        EasyLoading.dismiss();
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (trips) {
        EasyLoading.dismiss();
        tripEntity = trips;
        if (trips.data != null) {
          AppNavigation.pop();
          AppNavigation.pushNamed(
            AppRoutes.tripScreen,
            arguments: {
              'tripsData': trips.data,
              'title': title,
              'serviceCubit': serviceCubit,
            },
          );
        } else {
          serviceRequestState = RequestState.empty;
          emit(ErrorAvaliableTrips(requestState: serviceRequestState));
        }
      },
    );
  }
}
