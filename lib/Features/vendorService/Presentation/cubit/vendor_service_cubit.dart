import 'package:easy_life/Core/Helper/safe_emit_mixin.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_life/Core/Enums/level_message_enums.dart';
import 'package:easy_life/Core/L10n/locale_keys.dart';
import 'package:easy_life/Core/Routes/routes.dart';
import 'package:easy_life/Features/vendorService/Data/Model/hotel_item_model.dart';
import 'package:easy_life/Features/vendorService/Data/Model/resturnat_item_model.dart';
import 'package:easy_life/Features/vendorService/Data/Model/trip_schedule_item_model.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_branch_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_category_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/all_service_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/hotel_details_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/resturant_deatils_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Entities/trip_details_entity.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_branch_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_category_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_resturant_usecaes.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_service_otion_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_service_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/create_trip_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/get_all_branch_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/get_all_category_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/get_all_service_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/get_all_trip_schedule_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/show_hotel_usecases.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/show_resturant_usecase.dart';
import 'package:easy_life/Features/vendorService/Domain/Usecases/show_trip_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Core/Themes/app_colors.dart';
import '../../../../Core/Widget/custom_snack_bar.dart';
import '../../../Home/Domain/Entity/resturant_entity.dart';
import '../../../Home/Domain/Usecases/get_vendor_hotels_usecases.dart';
import '../../../Home/Domain/Usecases/get_vendor_resturant_usecases.dart';
import '../../../Home/Domain/Usecases/get_vendor_trips_usecases.dart';
import '../../Domain/Entities/all_trip_schedual_entity.dart';
import '../../Domain/Usecases/create_hotel_usecaes.dart';
part 'vendor_service_state.dart';

class VendorServiceCubit extends Cubit<VendorServiceState> with SafeEmitMixin<VendorServiceState> {
  VendorServiceCubit({
    required this.createBranchUsecases,
    required this.createCategoryUsecases,
    required this.getAllBranchUsecases,
    required this.getAllTripScheduleUsecases,
    required this.createResturantUsecaes,
    required this.createHotelUsecaes,
    required this.createTripUsecases,
    required this.showHotelUsecases,
    required this.showResturantUsecase,
    required this.showTripUsecases,
    required this.getVendorResturantUsecases,
    required this.getVendorTripsUsecases,
    required this.getVendorHotelsUsecases,
    required this.getAllCategoryUsecases,
    required this.getAllServiceUsecases,
    required this.createServiceUsecases,
    required this.createServiceOtionUsecases,
  }) : super(VendorServiceInitial());
  static VendorServiceCubit get(context) => BlocProvider.of(context);
  // --------------------------
  //     Variables
  // --------------------------
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double? initialLatitude;
  double? initialLongitude;
  File? logoImage;
  String language = 'ar';
  List<File> imageFiles = [];
  final int maxImages = 3;
  int initialCountryID = 1;
  int initialStatusID = 1;
  int initialTypeID = 1;
  PageController pageController = PageController();
  int currentPage = 0;
  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  TextEditingController descriptionArController = TextEditingController();
  TextEditingController descriptionEnController = TextEditingController();
  TextEditingController addressArController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  AllBranchEntity? allBranchEntity;
  AllTripScheduleEntity? allTripSchedualEntity;
  RequestState branchRequestState = RequestState.initial;
  RequestState tripRequestState = RequestState.initial;
  List<ResturnatItemModel> tableList = [ResturnatItemModel()];
  List<HotelItemModel> roomList = [HotelItemModel()];
  List<TripScheduleItemModel> tripScheduleList = [TripScheduleItemModel()];
  ResturantDeatilsEntity? resturantDeatilsEntity;
  HotelDetailsEntity? hotelDetailsEntity;
  TripDetailsEntity? tripDetailsEntity;
  HomeEntity? vendorResturantEntity;
  HomeEntity? vendorTripsEntity;
  HomeEntity? vendorHotelsEntity;
  AllCategoryEntity? allCategoryEntity;
  AllServiceEntity? allServiceEntity;
  RequestState resturantRequestState = RequestState.initial;
  RequestState hotelRequestState = RequestState.initial;
  RequestState tripScheduleRequestState = RequestState.initial;
  RequestState vendorResturantRequestState = RequestState.initial;
  RequestState vendorTripsRequestState = RequestState.initial;
  RequestState vendorHotelsRequestState = RequestState.initial;
  RequestState categoryRequestState = RequestState.initial;
  RequestState serviceRequestState = RequestState.initial;
  int branchID = 0;
  int catID = 0;
  int serviceID = 0;
  int selectedService = 0;

  // --------------------------
  //     usecaes & Entities
  // --------------------------
  final CreateCategoryUsecases createCategoryUsecases;
  final CreateBranchUsecases createBranchUsecases;
  final GetAllBranchUsecases getAllBranchUsecases;
  final GetAllCategoryUsecases getAllCategoryUsecases;
  final GetAllTripScheduleUsecases getAllTripScheduleUsecases;
  final CreateResturantUsecaes createResturantUsecaes;
  final CreateHotelUsecaes createHotelUsecaes;
  final CreateTripUsecases createTripUsecases;
  final ShowResturantUsecase showResturantUsecase;
  final ShowHotelUsecases showHotelUsecases;
  final ShowTripUsecases showTripUsecases;
  final GetVendorResturantUsecases getVendorResturantUsecases;
  final GetVendorTripsUsecases getVendorTripsUsecases;
  final GetVendorHotelsUsecases getVendorHotelsUsecases;
  final GetAllServiceUsecases getAllServiceUsecases;
  final CreateServiceUsecases createServiceUsecases;
  final CreateServiceOtionUsecases createServiceOtionUsecases;
  // --------------------------
  //     Api Methods
  // --------------------------
  createCategory() async {
    EasyLoading.show();
    var data = {
      'name[ar]': nameArController.text,
      'name[en]': nameEnController.text,
      'status': initialStatusID,
    };
    debugPrint('Ceate Category data : $data');
    var response = await createCategoryUsecases.call(
      formData: FormData.fromMap(data),
    );
    response.fold(
      (l) {
        EasyLoading.dismiss();
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        if (r.status == 200) {
          if (AppNavigation.navigatorKey.currentState != null) {
            AppNavigation.pop();
          }
          showCustomSnackBar(r.message, backgroundColor: Colors.green);
        } else {
          showCustomSnackBar(r.message, backgroundColor: AppColors.darkRed);
        }
      },
    );
  }

  createBranch() async {
    EasyLoading.show();
    var data = {
      'name[ar]': nameArController.text,
      'name[en]': nameEnController.text,
      'address': addressArController.text,
      'phone': phoneController.text,
      'latitude': initialLatitude,
      'longitude': initialLongitude,
      'delivery': 0,
      'status': initialStatusID,
      'countries[0]': initialCountryID,
    };
    if (logoImage != null) {
      data['logo'] = await MultipartFile.fromFile(logoImage!.path);
    }
    if (imageFiles.isNotEmpty) {
      data['image'] = await MultipartFile.fromFile(imageFiles.first.path);
    }
    debugPrint('Ceate Branch data : $data');
    var response = await createBranchUsecases.call(
      formData: FormData.fromMap(data),
    );
    response.fold(
      (l) {
        EasyLoading.dismiss();
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        if (r.status == 200) {
          if (AppNavigation.navigatorKey.currentState != null) {
            AppNavigation.pop();
          }
          showCustomSnackBar(r.message, backgroundColor: Colors.green);
        } else {
          showCustomSnackBar(r.message, backgroundColor: AppColors.darkRed);
        }
      },
    );
  }

  getAllBranches() async {
    var response = await getAllBranchUsecases.call();
    response.fold(
      (l) {
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
        branchRequestState = RequestState.error;
        emit(EmptyBranchesState(requestState: branchRequestState));
      },
      (r) {
        if (r.status == 200) {
          allBranchEntity = r;
          branchRequestState = RequestState.loaded;
          emit(GetAllBranchesState(allBranches: r));
          if (r.data!.isEmpty) {
            branchRequestState = RequestState.empty;
            emit(EmptyBranchesState(requestState: branchRequestState));
          } else {
            branchRequestState = RequestState.loaded;
            emit(GetAllBranchesState(allBranches: r));
          }
        } else {
          branchRequestState = RequestState.error;
          showCustomSnackBar(
            r.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
          emit(EmptyBranchesState(requestState: branchRequestState));
        }
      },
    );
  }

  getAllTripSchedual() async {
    var response = await getAllTripScheduleUsecases.call();
    response.fold(
      (l) {
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
        tripRequestState = RequestState.error;
        emit(EmptyTripSchedualState(requestState: tripRequestState));
      },
      (r) {
        if (r.status == 200) {
          allTripSchedualEntity = r;
          tripRequestState = RequestState.loaded;
          emit(GetAllTripScheduleState(allTripSchedule: r));
          if (r.data!.isEmpty) {
            tripRequestState = RequestState.empty;
            emit(EmptyTripSchedualState(requestState: tripRequestState));
          } else {
            tripRequestState = RequestState.loaded;
            emit(GetAllTripScheduleState(allTripSchedule: r));
          }
        } else {
          tripRequestState = RequestState.error;
          showCustomSnackBar(
            r.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
          emit(EmptyTripSchedualState(requestState: tripRequestState));
        }
      },
    );
  }

  createResturant({required bool isEdit, int? id}) async {
    EasyLoading.show();
    var data = {
      'name[ar]': nameArController.text,
      'name[en]': nameEnController.text,
      'address': addressArController.text,
      'phone': phoneController.text,
      'latitude': initialLatitude,
      'longitude': initialLongitude,
      'delivery': 0,
      'status': initialStatusID,
      'countries[0]': initialCountryID,
    };
    if (isEdit == false) {
      if (logoImage != null) {
        data['logo'] = await MultipartFile.fromFile(logoImage!.path);
      }
      if (imageFiles.isNotEmpty) {
        data['images[]'] = imageFiles
            .map((e) async => await MultipartFile.fromFile(e.path))
            .toList();
      }
    } else {
      data['_method'] = 'put';
    }
    if (tableList.isNotEmpty) {
      for (int i = 0; i < tableList.length; i++) {
        data['restaurantTables[$i][branch_id]'] = tableList[i].branchID;
        data['restaurantTables[$i][table_number]'] =
            tableList[i].tableNumber?.text;
        data['restaurantTables[$i][capacity]'] = tableList[i].capacity?.text;
        data['restaurantTables[$i][price]'] = tableList[i].price?.text;
        data['restaurantTables[$i][deposit]'] = tableList[i].deposit?.text;
        data['restaurantTables[$i][status]'] = 1;
      }
    }

    debugPrint('Ceate Resturant data : $data');
    var response = await createResturantUsecaes.call(
      formData: FormData.fromMap(data),
      isEdit: isEdit,
      id: id,
    );
    response.fold(
      (l) {
        EasyLoading.dismiss();
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        if (r.status == 200) {
          if (AppNavigation.navigatorKey.currentState != null) {
            AppNavigation.pop();
          }
          showCustomSnackBar(r.message, backgroundColor: Colors.green);
        } else {
          showCustomSnackBar(r.message, backgroundColor: AppColors.darkRed);
        }
      },
    );
  }

  createHotel({required bool isEdit, int? id}) async {
    EasyLoading.show();
    var data = {
      'name[ar]': nameArController.text,
      'name[en]': nameEnController.text,
      'address': addressArController.text,
      'phone': phoneController.text,
      'latitude': initialLatitude,
      'longitude': initialLongitude,
      'delivery': 0,
      'status': initialStatusID,
      'countries[0]': initialCountryID,
    };
    if (isEdit == false) {
      if (logoImage != null) {
        data['logo'] = await MultipartFile.fromFile(logoImage!.path);
      }
      if (imageFiles.isNotEmpty) {
        data['images[]'] = imageFiles
            .map((e) async => await MultipartFile.fromFile(e.path))
            .toList();
      }
    } else {
      data['_method'] = 'put';
    }
    if (roomList.isNotEmpty) {
      for (int i = 0; i < roomList.length; i++) {
        data['hotelRooms[$i][branch_id]'] = roomList[i].branchID;
        data['hotelRooms[$i][room_number]'] = roomList[i].roomNumber?.text;
        data['hotelRooms[$i][floor_number]'] = roomList[i].floorNumber?.text;
        data['hotelRooms[$i][capacity]'] = roomList[i].capacity?.text;
        data['hotelRooms[$i][price]'] = roomList[i].price?.text;
        data['hotelRooms[$i][deposit]'] = roomList[i].deposit?.text;
        data['hotelRooms[$i][status]'] = 1;
      }
    }

    debugPrint('Ceate Hotel data : $data');
    var response = await createHotelUsecaes.call(
      formData: FormData.fromMap(data),
      isEdit: isEdit,
      id: id,
    );
    response.fold(
      (l) {
        EasyLoading.dismiss();
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        if (r.status == 200) {
          if (AppNavigation.navigatorKey.currentState != null) {
            AppNavigation.pop();
          }
          showCustomSnackBar(r.message, backgroundColor: Colors.green);
        } else {
          showCustomSnackBar(r.message, backgroundColor: AppColors.darkRed);
        }
      },
    );
  }

  createTrip({required bool isEdit, int? id}) async {
    EasyLoading.show();
    var data = {
      'name[ar]': nameArController.text,
      'name[en]': nameEnController.text,
      'address': addressArController.text,
      'phone': phoneController.text,
      'latitude': initialLatitude,
      'longitude': initialLongitude,
      'delivery': 0,
      'status': initialStatusID,
      'countries[0]': initialCountryID,
    };
    if (isEdit == false) {
      if (logoImage != null) {
        data['logo'] = await MultipartFile.fromFile(logoImage!.path);
      }
      if (imageFiles.isNotEmpty) {
        data['images[]'] = imageFiles
            .map((e) async => await MultipartFile.fromFile(e.path))
            .toList();
      }
    } else {
      data['_method'] = 'put';
    }
    if (tripScheduleList.isNotEmpty) {
      for (int i = 0; i < tripScheduleList.length; i++) {
        data['tripSchedules[$i][branch_id]'] = tripScheduleList[i].branchID;
        data['tripSchedules[$i][schedule_number]'] =
            tripScheduleList[i].tripScheduleID;
        data['tripSchedules[$i][price]'] = tripScheduleList[i].price.text;
        data['tripSchedules[$i][location_from]'] =
            tripScheduleList[i].startPlace.text;
        data['tripSchedules[$i][location_to]'] =
            tripScheduleList[i].endPlace.text;
        data['tripSchedules[$i][moving_time]'] =
            tripScheduleList[i].startDate.text;
        data['tripSchedules[$i][returning_time]'] =
            tripScheduleList[i].endDate.text;
        data['tripSchedules[$i][capacity]'] = tripScheduleList[i].capacity.text;
        data['tripSchedules[$i][deposit]'] = tripScheduleList[i].deposit.text;
        data['tripSchedules[$i][status]'] = 1;
      }
    }
    debugPrint('Ceate Trip data : $data');
    var response = await createTripUsecases.call(
      formData: FormData.fromMap(data),
      isEdit: isEdit,
      id: id,
    );
    response.fold(
      (l) {
        EasyLoading.dismiss();
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        if (r.status == 200) {
          if (AppNavigation.navigatorKey.currentState != null) {
            AppNavigation.pop();
          }
          showCustomSnackBar(r.message, backgroundColor: Colors.green);
        } else {
          showCustomSnackBar(r.message, backgroundColor: AppColors.darkRed);
        }
      },
    );
  }

  showResturant({required int id}) async {
    EasyLoading.show();
    var response = await showResturantUsecase.call(id: id);
    response.fold(
      (l) {
        EasyLoading.dismiss();
        resturantRequestState = RequestState.error;
        emit(EmptyResturantDetailsState(requestState: resturantRequestState));
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        resturantDeatilsEntity = r;
        emit(GetResturantDetailsState(resturantDetails: r));
        if (r.status == 200) {
          resturantDeatilsEntity = r;
          resturantRequestState = RequestState.loaded;
          emit(GetResturantDetailsState(resturantDetails: r));
          nameArController.text = r.data!.name ?? '';
          nameEnController.text = r.data!.name ?? '';
          addressArController.text = r.data!.address ?? '';
          phoneController.text = r.data!.phone ?? '';
          if (r.data!.logo != null) {
            logoImage = File(r.data!.logo ?? '');
            SetLogoImage(images: logoImage!);
          }
          if (r.data!.images!.isNotEmpty) {
            imageFiles = r.data!.images!.map((e) => File(e.url ?? '')).toList();
            SetImages(images: imageFiles);
          }
          if (r.data!.restaurantTables!.isNotEmpty) {
            removeResturantTable(0);
            for (var item in r.data!.restaurantTables!) {
              tableList.add(
                ResturnatItemModel(
                  branchID: item.branch!.id,
                  tableNumber: TextEditingController(
                    text: item.tableNumber ?? '',
                  ),
                  capacity: TextEditingController(
                    text: (item.capacity ?? 0).toString(),
                  ),
                  price: TextEditingController(text: item.price ?? ''),
                  deposit: TextEditingController(text: item.deposit ?? ''),
                ),
              );
            }
          }
          if (r.data!.latitude != null && r.data!.longitude != null) {
            initialLatitude = double.parse(r.data!.latitude ?? '0.0');
            initialLongitude = double.parse(r.data!.longitude ?? '0.0');
            setLatitudeLongitude(
              latitude: double.parse(r.data!.latitude ?? '0.0'),
              longitude: double.parse(r.data!.longitude ?? '0.0'),
            );
          }
        } else {
          resturantRequestState = RequestState.error;
          emit(EmptyResturantDetailsState(requestState: resturantRequestState));

          showCustomSnackBar(
            r.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  showHotel({required int id}) async {
    EasyLoading.show();
    var response = await showHotelUsecases.call(id: id);
    response.fold(
      (l) {
        EasyLoading.dismiss();
        hotelRequestState = RequestState.error;
        emit(EmptyHotelDetailsState(requestState: hotelRequestState));
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        hotelDetailsEntity = r;
        emit(GetHotelDetailsState(hotelDetails: r));
        if (r.status == 200) {
          hotelDetailsEntity = r;
          hotelRequestState = RequestState.loaded;
          emit(GetHotelDetailsState(hotelDetails: r));
          nameArController.text = r.data!.name ?? '';
          nameEnController.text = r.data!.name ?? '';
          addressArController.text = r.data!.address ?? '';
          phoneController.text = r.data!.phone ?? '';
          if (r.data!.logo != null) {
            logoImage = File(r.data!.logo ?? '');
            SetLogoImage(images: logoImage!);
          }
          if (r.data!.images!.isNotEmpty) {
            imageFiles = r.data!.images!.map((e) => File(e.url ?? '')).toList();
            SetImages(images: imageFiles);
          }
          if (r.data!.latitude != null && r.data!.longitude != null) {
            initialLatitude = double.parse(r.data!.latitude ?? '0.0');
            initialLongitude = double.parse(r.data!.longitude ?? '0.0');
            setLatitudeLongitude(
              latitude: double.parse(r.data!.latitude ?? '0.0'),
              longitude: double.parse(r.data!.longitude ?? '0.0'),
            );
          }
          if (r.data!.hotelRooms!.isNotEmpty) {
            removeHotelTable(0);
            for (var item in r.data!.hotelRooms!) {
              roomList.add(
                HotelItemModel(
                  branchID: item.branch!.id,
                  roomNumber: TextEditingController(
                    text: item.roomNumber ?? '',
                  ),
                  floorNumber: TextEditingController(
                    text: item.floorNumber ?? '',
                  ),
                  capacity: TextEditingController(
                    text: (item.capacity ?? 0).toString(),
                  ),
                  price: TextEditingController(text: item.price ?? ''),
                  deposit: TextEditingController(text: item.deposit ?? ''),
                ),
              );
            }
          }
        } else {
          hotelRequestState = RequestState.error;
          emit(EmptyHotelDetailsState(requestState: hotelRequestState));

          showCustomSnackBar(
            r.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  showTrip({required int id}) async {
    EasyLoading.show();
    var response = await showTripUsecases.call(id: id);
    response.fold(
      (l) {
        EasyLoading.dismiss();
        tripRequestState = RequestState.error;
        emit(EmptyTripDetailsState(requestState: tripRequestState));
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        tripDetailsEntity = r;
        emit(GetTripDetailsState(tripDetails: r));
        if (r.status == 200) {
          tripDetailsEntity = r;
          tripRequestState = RequestState.loaded;
          emit(GetTripDetailsState(tripDetails: r));
          nameArController.text = r.data!.name ?? '';
          nameEnController.text = r.data!.name ?? '';
          addressArController.text = r.data!.address ?? '';
          phoneController.text = r.data!.phone ?? '';
          if (r.data!.logo != null) {
            logoImage = File(r.data!.logo ?? '');
            SetLogoImage(images: logoImage!);
          }
          if (r.data!.images!.isNotEmpty) {
            imageFiles = r.data!.images!.map((e) => File(e.url ?? '')).toList();
            SetImages(images: imageFiles);
          }
          if (r.data!.latitude != null && r.data!.longitude != null) {
            initialLatitude = double.parse(r.data!.latitude ?? '0.0');
            initialLongitude = double.parse(r.data!.longitude ?? '0.0');
            setLatitudeLongitude(
              latitude: double.parse(r.data!.latitude ?? '0.0'),
              longitude: double.parse(r.data!.longitude ?? '0.0'),
            );
          }
          if (r.data!.tripScheduless!.isNotEmpty) {
            removeTripSchedule(0);
            for (var item in r.data!.tripScheduless!) {
              tripScheduleList.add(
                TripScheduleItemModel(
                  branchID: item.branch!.id,
                  tripScheduleID: item.id,
                  capacity: TextEditingController(
                    text: (item.capacity ?? 0).toString(),
                  ),
                  price: TextEditingController(text: item.price ?? ''),
                  deposit: TextEditingController(text: item.deposit ?? ''),
                  startPlace: TextEditingController(
                    text: item.locationFrom ?? '',
                  ),
                  endPlace: TextEditingController(text: item.locationTo ?? ''),
                  startDate: TextEditingController(
                    text: _formatDateTime(
                      item.movingTime,
                      TimeOfDay.fromDateTime(item.movingTime ?? DateTime.now()),
                    ),
                  ),
                  endDate: TextEditingController(
                    text: _formatDateTime(
                      item.returningTime,
                      TimeOfDay.fromDateTime(
                        item.returningTime ?? DateTime.now(),
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        } else {
          tripRequestState = RequestState.error;
          emit(EmptyTripDetailsState(requestState: tripRequestState));

          showCustomSnackBar(
            r.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  // --------------------------
  //     Setters Methods
  // --------------------------

  String _formatDateTime(DateTime? date, TimeOfDay? time) {
    if (date == null || time == null) return '';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day $hour:$minute';
  }

  setLanguage({required String lang}) {
    language = lang;
    emit(SetLanguageState(language: language));
  }

  setLatitudeLongitude({required double latitude, required double longitude}) {
    initialLatitude = latitude;
    initialLongitude = longitude;
    emit(SetLatitudeLongitudeState(latitude: latitude, longitude: longitude));
  }

  setCountryID({required int countryID}) {
    initialCountryID = countryID;
    emit(SetCountryIDState(countryID: countryID));
  }

  setStatusID({required int statusID}) {
    initialStatusID = statusID;
    emit(SetStatusState(status: statusID));
  }

  setTypeID({required int type}) {
    initialTypeID = type;
    emit(SetTypeState(type: type));
    if (type == 1) getVendorResturant();
    if (type == 2) getVendorHotels();
    if (type == 3) getVendorTrips();
  }

  setCurrentPage({required int page}) {
    currentPage = page;
    emit(SetCurrentPageState(pageIndex: page));
  }

  bool _isResturantTableItemValid(ResturnatItemModel item) {
    return item.branchID != null &&
        item.tableNumber?.text.isNotEmpty == true &&
        item.capacity?.text.isNotEmpty == true &&
        item.price?.text.isNotEmpty == true &&
        item.deposit?.text.isNotEmpty == true;
  }

  void addResturantTable() {
    // Check if the last item in the list is valid before adding a new one
    if (tableList.isNotEmpty) {
      final lastItem = tableList.last;
      if (!_isResturantTableItemValid(lastItem)) {
        showCustomSnackBar(
          LocaleKeys.vendorValidationFillCurrentItem.tr(),
          backgroundColor: AppColors.darkRed,
        );
        return;
      }
    }
    tableList.add(ResturnatItemModel());
    debugPrint('Table List Length : ${tableList.length}');
    emit(TableUpdated(tableList: List.from(tableList)));
  }

  void removeResturantTable(int index) {
    tableList.removeAt(index);
    emit(TableUpdated(tableList: List.from(tableList)));
  }

  void updateResturantBranch(int index, int? value) {
    tableList[index].branchID = value;
    emit(TableUpdated(tableList: List.from(tableList)));
  }

  bool _isHotelTableItemValid(HotelItemModel item) {
    return item.branchID != null &&
        item.roomNumber?.text.isNotEmpty == true &&
        item.floorNumber?.text.isNotEmpty == true &&
        item.capacity?.text.isNotEmpty == true &&
        item.price?.text.isNotEmpty == true &&
        item.deposit?.text.isNotEmpty == true;
  }

  void addHotelRoom() {
    // Check if the last item in the list is valid before adding a new one
    if (roomList.isNotEmpty) {
      final lastItem = roomList.last;
      if (!_isHotelTableItemValid(lastItem)) {
        showCustomSnackBar(
          LocaleKeys.vendorValidationFillCurrentItem.tr(),
          backgroundColor: AppColors.darkRed,
        );
        return;
      }
    }
    roomList.add(HotelItemModel());
    debugPrint('Room List Length : ${roomList.length}');
    emit(TableUpdated(tableList: List.from(roomList)));
  }

  void removeHotelTable(int index) {
    roomList.removeAt(index);
    emit(TableUpdated(tableList: List.from(roomList)));
  }

  void updateHotelBranch(int index, int? value) {
    roomList[index].branchID = value;
    emit(TableUpdated(tableList: List.from(roomList)));
  }

  bool _isTripScheduleItemValid(TripScheduleItemModel item) {
    return item.tripScheduleID != null &&
        item.capacity.text.trim().isNotEmpty &&
        item.price.text.trim().isNotEmpty &&
        item.deposit.text.trim().isNotEmpty &&
        item.startPlace.text.trim().isNotEmpty &&
        item.endPlace.text.trim().isNotEmpty &&
        item.startDate.text.trim().isNotEmpty &&
        item.endDate.text.trim().isNotEmpty;
  }

  void addTripSchedule() {
    // Check if the last item in the list is valid before adding a new one
    if (tripScheduleList.isNotEmpty) {
      final lastItem = tripScheduleList.last;
      if (!_isTripScheduleItemValid(lastItem)) {
        showCustomSnackBar(
          LocaleKeys.vendorValidationFillCurrentItem.tr(),
          backgroundColor: AppColors.darkRed,
        );
        return;
      }
    }
    tripScheduleList.add(TripScheduleItemModel());
    debugPrint('Trip Schedule List Length : ${tripScheduleList.length}');
    emit(TableUpdated(tableList: List.from(tripScheduleList)));
  }

  void removeTripSchedule(int index) {
    tripScheduleList.removeAt(index);
    emit(TableUpdated(tableList: List.from(tripScheduleList)));
  }

  void updateTripSchedule(int index, int? value) {
    tripScheduleList[index].tripScheduleID = value;
    emit(TableUpdated(tableList: List.from(tripScheduleList)));
  }

  void updateTripScheduleBranch(int index, int? value) {
    tripScheduleList[index].branchID = value;
    emit(TableUpdated(tableList: List.from(tripScheduleList)));
  }

  // --------------------------
  //     Image Picker
  // --------------------------

  pickLogoFile({required ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      logoImage = File(pickedFile.path);
      emit(SetLogoImage(images: logoImage!));
    }
  }

  pickFile({required ImageSource source}) async {
    if (imageFiles.length >= maxImages) {
      showCustomSnackBar(
        LocaleKeys.vendorImageMaxLimit.tr(
          namedArgs: {'max': '$maxImages'},
        ),
        backgroundColor: AppColors.darkRed,
      );
      return;
    }

    final ImagePicker _picker = ImagePicker();

    if (source == ImageSource.gallery) {
      // Allow picking multiple images from gallery
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        int remainingSlots = maxImages - imageFiles.length;
        int filesToAdd = pickedFiles.length > remainingSlots
            ? remainingSlots
            : pickedFiles.length;

        // Create a new list to ensure state change is detected
        List<File> updatedFiles = List.from(imageFiles);

        for (int i = 0; i < filesToAdd; i++) {
          updatedFiles.add(File(pickedFiles[i].path));
        }

        imageFiles = updatedFiles;

        debugPrint(
          'Added ${filesToAdd} images. Total images: ${imageFiles.length}',
        );

        if (pickedFiles.length > remainingSlots) {
          showCustomSnackBar(
            LocaleKeys.vendorImagePartialAdd.tr(
              namedArgs: {
                'count': '$remainingSlots',
                'max': '$maxImages',
              },
            ),
            backgroundColor: AppColors.darkRed,
          );
        } else if (filesToAdd > 0) {
          showCustomSnackBar(
            LocaleKeys.vendorImageAddSuccessCount.tr(
              namedArgs: {'count': '$filesToAdd'},
            ),
            backgroundColor: Colors.green,
          );
        }

        emit(SetImages(images: List.from(imageFiles)));
      }
    } else {
      // Camera - single image
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        // Create a new list to ensure state change is detected
        List<File> updatedFiles = List.from(imageFiles);
        updatedFiles.add(File(pickedFile.path));
        imageFiles = updatedFiles;
        debugPrint(
          'Added 1 image from camera. Total images: ${imageFiles.length}',
        );
        showCustomSnackBar(
          LocaleKeys.vendorImageAddSuccess.tr(),
          backgroundColor: Colors.green,
        );
        emit(SetImages(images: List.from(imageFiles)));
      }
    }
  }

  removeImage(int index) {
    if (index >= 0 && index < imageFiles.length) {
      // Create a new list to ensure state change is detected
      List<File> updatedFiles = List.from(imageFiles);
      updatedFiles.removeAt(index);
      imageFiles = updatedFiles;
      emit(SetImages(images: List.from(imageFiles)));
    }
  }

  clearImages() {
    imageFiles.clear();
    emit(SetImages(images: List.from(imageFiles)));
  }

  setBranchID({required int brID}) {
    branchID = brID;
    emit(SetBranchID(branchID: branchID));
  }

  setCategoryID({required int categoryID}) {
    catID = categoryID;
    emit(SetCategoryID(categoryID: categoryID));
  }

  setServiceID({required int svID}) {
    selectedService = svID;

    emit(SetServiceID(serviceID: svID));
    debugPrint('service id Vendor $serviceID');
  }

  getAllCategory() async {
    var response = await getAllCategoryUsecases.getAllCategory();
    response.fold(
      (l) {
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
        categoryRequestState = RequestState.error;
        emit(EmptyCategoryState(requestState: categoryRequestState));
      },
      (r) {
        if (r.status == 200) {
          allCategoryEntity = r;
          categoryRequestState = RequestState.loaded;
          emit(GetAllCategoryState(allCategoryEntity: r));
          if (r.data!.isEmpty) {
            categoryRequestState = RequestState.empty;
            emit(EmptyCategoryState(requestState: categoryRequestState));
          } else {
            categoryRequestState = RequestState.loaded;
            emit(GetAllCategoryState(allCategoryEntity: r));
          }
        } else {
          categoryRequestState = RequestState.error;
          showCustomSnackBar(
            r.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
          emit(EmptyCategoryState(requestState: categoryRequestState));
        }
      },
    );
  }

  Future<void> getVendorResturant() async {
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

  createService() async {
    EasyLoading.show();
    var data = {
      'name[ar]': nameArController.text,
      'name[en]': nameEnController.text,
      'description[ar]': descriptionArController.text,
      'description[en]': descriptionEnController.text,
      'branch_id': branchID,
      'price': priceController.text,
      'discount': discountController.text,
      'service_branch_category_id': catID,
      'service_id': initialTypeID,
      'status': initialStatusID,
      'countries[0]': initialCountryID,
    };
    if (initialTypeID == 1) data['restaurant_id'] = selectedService;
    if (initialTypeID == 2) data['hotel_id'] = selectedService;
    if (initialTypeID == 3) data['trip_id'] = selectedService;
    if (logoImage != null) {
      data['image'] = await MultipartFile.fromFile(logoImage!.path);
    }
    FormData formData = FormData.fromMap(data);
    var response = await createServiceUsecases.call(formData: formData);
    response.fold(
      (l) {
        EasyLoading.dismiss();
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        if (r.status == 200) {
          AppNavigation.pop();
          showCustomSnackBar(r.message ?? '', backgroundColor: Colors.green);
        } else {
          showCustomSnackBar(
            r.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  getAllService() async {
    var response = await getAllServiceUsecases.call();
    response.fold(
      (l) {
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
        serviceRequestState = RequestState.error;
        emit(ServiceErrorState(requestState: serviceRequestState));
      },
      (r) {
        if (r.status == 200) {
          allServiceEntity = r;
          emit(ServiceSuccessState(allServiceEntity: r));
        } else {
          serviceRequestState = RequestState.empty;
          emit(ServiceErrorState(requestState: serviceRequestState));
          showCustomSnackBar(
            r.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }

  setCurrentService({required int servID}) {
    selectedService = servID;
    emit(SetCurrentService(currentService: servID));
  }

  createServiceOption() async {
    EasyLoading.show();
    var data = {
      'name[ar]': nameArController.text,
      'name[en]': nameEnController.text,
      'service_branch_id': selectedService,
      'price': priceController.text,
      'discount': discountController.text,
      'status': initialStatusID,
      'countries[0]': initialCountryID,
    };
    FormData formData = FormData.fromMap(data);
    var response = await createServiceOtionUsecases.call(formData: formData);
    response.fold(
      (l) {
        EasyLoading.dismiss();
        showCustomSnackBar(
          l.message.toString(),
          backgroundColor: AppColors.darkRed,
        );
      },
      (r) {
        EasyLoading.dismiss();
        if (r.status == 200) {
          AppNavigation.pop();
          showCustomSnackBar(r.message ?? '', backgroundColor: Colors.green);
        } else {
          showCustomSnackBar(
            r.message ?? '',
            backgroundColor: AppColors.darkRed,
          );
        }
      },
    );
  }
}
