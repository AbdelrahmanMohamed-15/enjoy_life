import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/Widget/custom_snack_bar.dart';
import 'package:easy_life/Features/Home/Domain/Entity/slider_entity.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/add_favourite_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_hotels_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_my_favourite_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_resturant_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_sliders_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Entity/resturant_entity.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/get_trips_usecases.dart';
import 'package:easy_life/Features/Home/Domain/Usecases/remove_favourite_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Themes/app_colors.dart';
import '../../Domain/Usecases/get_all_home_usecases.dart';
import '../../Domain/Usecases/get_vendor_hotels_usecases.dart';
import '../../Domain/Usecases/get_vendor_resturant_usecases.dart';
import '../../Domain/Usecases/get_vendor_trips_usecases.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getSlidersUsecases,
    required this.getResturantUsecases,
    required this.getTripsUsecases,
    required this.getHotelsUsecases,
    required this.getVendorResturantUsecases,
    required this.getVendorTripsUsecases,
    required this.getVendorHotelsUsecases,
    required this.addFavouriteUsecases,
    required this.removeFavouriteUsecases,
    required this.getMyFavouriteUsecases,
    required this.getAllHomeUsecases,
  }) : super(HomeInitial());

  // general varialbe of cubit instance
  static HomeCubit get(context) => BlocProvider.of(context);

  // usecases variable
  final GetSlidersUsecases getSlidersUsecases;
  final GetResturantUsecases getResturantUsecases;
  final GetTripsUsecases getTripsUsecases;
  final GetHotelsUsecases getHotelsUsecases;
  final GetVendorResturantUsecases getVendorResturantUsecases;
  final GetVendorTripsUsecases getVendorTripsUsecases;
  final GetVendorHotelsUsecases getVendorHotelsUsecases;
  final AddFavouriteUsecases addFavouriteUsecases;
  final RemoveFavouriteUsecases removeFavouriteUsecases;
  final GetMyFavouriteUsecases getMyFavouriteUsecases;
  final GetAllHomeUsecases getAllHomeUsecases;

  // entity variable
  SliderEntity? slidersEntity;
  HomeEntity? resturantEntity;
  HomeEntity? tripsEntity;
  HomeEntity? hotelsEntity;
  HomeEntity? myFavouriteEntity;
  HomeEntity? totalHomeEntity;
  HomeEntity? vendorResturantEntity;
  HomeEntity? vendorTripsEntity;
  HomeEntity? vendorHotelsEntity;

  // request state variable
  RequestState sliderRequestState = RequestState.initial;
  RequestState resturantRequestState = RequestState.initial;
  RequestState tripsRequestState = RequestState.initial;
  RequestState hotelsRequestState = RequestState.initial;
  RequestState vendorResturantRequestState = RequestState.initial;
  RequestState vendorTripsRequestState = RequestState.initial;
  RequestState vendorHotelsRequestState = RequestState.initial;
  RequestState myFavouriteRequestState = RequestState.initial;
  RequestState totalHomeRequestState = RequestState.initial;

  Future<void> getSliders() async {
    emit(HomeLoadingState());
    final result = await getSlidersUsecases.call();
    result.fold(
      (failure) {
        sliderRequestState = RequestState.error;
        emit(HomeErrorState(requestState: sliderRequestState));
      },
      (sliders) {
        slidersEntity = sliders;
        if (sliders.data!.isNotEmpty) {
          emit(HomeSuccessState(sliders: sliders));
        } else {
          sliderRequestState = RequestState.empty;
          emit(HomeErrorState(requestState: sliderRequestState));
        }
      },
    );
  }

  Future<void> getResturant() async {
    emit(HomeLoadingState());
    final result = await getResturantUsecases.call();
    result.fold(
      (failure) {
        resturantRequestState = RequestState.error;
        emit(HomeResturantErrorState(requestState: resturantRequestState));
      },
      (resturant) {
        resturantEntity = resturant;
        if (resturant.data!.isNotEmpty) {
          emit(HomeResturantSuccessState(resturant: resturant));
        } else {
          resturantRequestState = RequestState.empty;
          emit(HomeResturantErrorState(requestState: resturantRequestState));
        }
      },
    );
  }

  Future<void> getTrips() async {
    emit(HomeLoadingState());
    final result = await getTripsUsecases.call();
    result.fold(
      (failure) {
        tripsRequestState = RequestState.error;
        emit(HomeTripsErrorState(requestState: tripsRequestState));
      },
      (trips) {
        tripsEntity = trips;
        if (trips.data!.isNotEmpty) {
          emit(HomeTripsSuccessState(trips: trips));
        } else {
          tripsRequestState = RequestState.empty;
          emit(HomeTripsErrorState(requestState: tripsRequestState));
        }
      },
    );
  }

  Future<void> getHotels() async {
    emit(HomeLoadingState());
    final result = await getHotelsUsecases.call();
    result.fold(
      (failure) {
        hotelsRequestState = RequestState.error;
        emit(HomeHotelsErrorState(requestState: hotelsRequestState));
      },
      (hotels) {
        hotelsEntity = hotels;
        if (hotels.data!.isNotEmpty) {
          emit(HomeHotelsSuccessState(hotels: hotels));
        } else {
          hotelsRequestState = RequestState.empty;
          emit(HomeHotelsErrorState(requestState: hotelsRequestState));
        }
      },
    );
  }

  Future<void> getVendorResturant() async {
    emit(HomeLoadingState());
    final result = await getVendorResturantUsecases.call();
    result.fold(
      (failure) {
        vendorResturantRequestState = RequestState.error;
        emit(
          HomeResturantErrorState(requestState: vendorResturantRequestState),
        );
      },
      (resturant) {
        vendorResturantEntity = resturant;
        if (resturant.data!.isNotEmpty) {
          emit(HomeResturantSuccessState(resturant: resturant));
        } else {
          vendorResturantRequestState = RequestState.empty;
          emit(
            HomeResturantErrorState(requestState: vendorResturantRequestState),
          );
        }
      },
    );
  }

  Future<void> getVendorTrips() async {
    emit(HomeLoadingState());
    final result = await getVendorTripsUsecases.call();
    result.fold(
      (failure) {
        vendorTripsRequestState = RequestState.error;
        emit(HomeTripsErrorState(requestState: vendorTripsRequestState));
      },
      (trips) {
        vendorTripsEntity = trips;
        if (trips.data!.isNotEmpty) {
          emit(HomeTripsSuccessState(trips: trips));
        } else {
          vendorTripsRequestState = RequestState.empty;
          emit(HomeTripsErrorState(requestState: vendorTripsRequestState));
        }
      },
    );
  }

  Future<void> getVendorHotels() async {
    emit(HomeLoadingState());
    final result = await getVendorHotelsUsecases.call();
    result.fold(
      (failure) {
        vendorHotelsRequestState = RequestState.error;
        emit(HomeHotelsErrorState(requestState: vendorHotelsRequestState));
      },
      (hotels) {
        vendorHotelsEntity = hotels;
        if (hotels.data!.isNotEmpty) {
          emit(HomeHotelsSuccessState(hotels: hotels));
        } else {
          vendorHotelsRequestState = RequestState.empty;
          emit(HomeHotelsErrorState(requestState: vendorHotelsRequestState));
        }
      },
    );
  }

  getAllVendorHome() async {
    await getVendorResturant();
    await getVendorTrips();
    await getVendorHotels();
  }

  Future<void> addFavourite({required int id, required String type}) async {
    final result = await addFavouriteUsecases.call(id: id, type: type);
    result.fold(
      (failure) {
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (favourite) {
        if (favourite == true) {
          showCustomSnackBar(
            'تم الاضافة بنجاح',
            backgroundColor: AppColors.primary400,
          );
        } else {
          showCustomSnackBar('حدث خطأ', backgroundColor: AppColors.darkRed);
        }
      },
    );
  }

  Future<void> removeFavourite({required int id, required String type}) async {
    final result = await removeFavouriteUsecases.call(id: id, type: type);
    result.fold(
      (failure) {
        showCustomSnackBar(failure.message, backgroundColor: AppColors.darkRed);
      },
      (favourite) {
        if (favourite == true) {
          showCustomSnackBar(
            'تم الحذف بنجاح',
            backgroundColor: AppColors.primary400,
          );
        } else {
          showCustomSnackBar('حدث خطأ', backgroundColor: AppColors.darkRed);
        }
      },
    );
  }

  getMyFavourite() async {
    final result = await getMyFavouriteUsecases.call();
    result.fold(
      (failure) {
        myFavouriteRequestState = RequestState.error;
        emit(HomeFavouriteErrorState(requestState: myFavouriteRequestState));
      },
      (myFavourite) {
        myFavouriteEntity = myFavourite;
        if (myFavourite.data!.isNotEmpty) {
          emit(HomeFavouriteSuccessState(favourite: myFavourite));
        } else {
          myFavouriteRequestState = RequestState.empty;
          emit(HomeFavouriteErrorState(requestState: myFavouriteRequestState));
        }
      },
    );
  }

  getAllHome({required String type}) async {
    final result = await getAllHomeUsecases.call(type: type);
    result.fold(
      (failure) {
        totalHomeRequestState = RequestState.error;
        emit(HomeAllErrorState(requestState: totalHomeRequestState));
      },
      (home) {
        totalHomeEntity = home;
        if (home.data!.isNotEmpty) {
          emit(HomeAllSuccessState(all: home));
        } else {
          totalHomeRequestState = RequestState.empty;
          emit(HomeAllErrorState(requestState: totalHomeRequestState));
        }
      },
    );
  }
}
