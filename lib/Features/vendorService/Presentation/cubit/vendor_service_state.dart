part of 'vendor_service_cubit.dart';

sealed class VendorServiceState extends Equatable {
  const VendorServiceState();

  @override
  List<Object> get props => [];
}

final class VendorServiceInitial extends VendorServiceState {}

// state of set latitude and longitude
final class SetLatitudeLongitudeState extends VendorServiceState {
  final double latitude;
  final double longitude;

  const SetLatitudeLongitudeState({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [latitude, longitude];
}

// state of set Language
final class SetLanguageState extends VendorServiceState {
  final String language;
  const SetLanguageState({required this.language});

  @override
  List<Object> get props => [language];
}

// state of pick Image
final class SetImages extends VendorServiceState {
  final List<File> images;
  const SetImages({required this.images});

  @override
  List<Object> get props => [images];
}

// state of pick Logo Image
final class SetLogoImage extends VendorServiceState {
  final File images;
  const SetLogoImage({required this.images});

  @override
  List<Object> get props => [images];
}

// state of set country ID
final class SetCountryIDState extends VendorServiceState {
  final int countryID;
  const SetCountryIDState({required this.countryID});

  @override
  List<Object> get props => [countryID];
}

// state of status yes / no
final class SetStatusState extends VendorServiceState {
  final int status;
  const SetStatusState({required this.status});

  @override
  List<Object> get props => [status];
}

// state of status Type
final class SetTypeState extends VendorServiceState {
  final int type;
  const SetTypeState({required this.type});

  @override
  List<Object> get props => [type];
}

// state of page index
final class SetCurrentPageState extends VendorServiceState {
  final int pageIndex;
  const SetCurrentPageState({required this.pageIndex});

  @override
  List<Object> get props => [pageIndex];
}

// state of Get All Branches
final class GetAllBranchesState extends VendorServiceState {
  final AllBranchEntity allBranches;
  const GetAllBranchesState({required this.allBranches});

  @override
  List<Object> get props => [allBranches];
}

final class EmptyBranchesState extends VendorServiceState {
  final RequestState requestState;
  const EmptyBranchesState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

// state of Get All Trip Schedule
final class GetAllTripScheduleState extends VendorServiceState {
  final AllTripScheduleEntity allTripSchedule;
  const GetAllTripScheduleState({required this.allTripSchedule});

  @override
  List<Object> get props => [allTripSchedule];
}

final class EmptyTripSchedualState extends VendorServiceState {
  final RequestState requestState;
  const EmptyTripSchedualState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class TableUpdated extends VendorServiceState {
  final List<dynamic> tableList;
  const TableUpdated({required this.tableList});

  @override
  List<Object> get props => [tableList];
}

// state of Get Restaurant Details
final class GetResturantDetailsState extends VendorServiceState {
  final ResturantDeatilsEntity resturantDetails;
  const GetResturantDetailsState({required this.resturantDetails});

  @override
  List<Object> get props => [resturantDetails];
}

final class EmptyResturantDetailsState extends VendorServiceState {
  final RequestState requestState;
  const EmptyResturantDetailsState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}
// state of Get Hotel Details

final class GetHotelDetailsState extends VendorServiceState {
  final HotelDetailsEntity hotelDetails;
  const GetHotelDetailsState({required this.hotelDetails});

  @override
  List<Object> get props => [hotelDetails];
}

final class EmptyHotelDetailsState extends VendorServiceState {
  final RequestState requestState;
  const EmptyHotelDetailsState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

// state of Get Trip Details

final class GetTripDetailsState extends VendorServiceState {
  final TripDetailsEntity tripDetails;
  const GetTripDetailsState({required this.tripDetails});

  @override
  List<Object> get props => [tripDetails];
}

final class EmptyTripDetailsState extends VendorServiceState {
  final RequestState requestState;
  const EmptyTripDetailsState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class SetBranchID extends VendorServiceState {
  final int branchID;
  const SetBranchID({required this.branchID});

  @override
  List<Object> get props => [branchID];
}

final class SetCategoryID extends VendorServiceState {
  final int categoryID;
  const SetCategoryID({required this.categoryID});

  @override
  List<Object> get props => [categoryID];
}

final class SetServiceID extends VendorServiceState {
  final int serviceID;
  const SetServiceID({required this.serviceID});

  @override
  List<Object> get props => [serviceID];
}

final class GetAllCategoryState extends VendorServiceState {
  final AllCategoryEntity allCategoryEntity;
  const GetAllCategoryState({required this.allCategoryEntity});

  @override
  List<Object> get props => [allCategoryEntity];
}

final class EmptyCategoryState extends VendorServiceState {
  final RequestState requestState;
  const EmptyCategoryState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

// state of get Resturant
final class HomeResturantLoadingState extends VendorServiceState {}

final class HomeResturantErrorState extends VendorServiceState {
  final RequestState requestState;
  const HomeResturantErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class HomeResturantSuccessState extends VendorServiceState {
  final HomeEntity resturant;
  const HomeResturantSuccessState({required this.resturant});

  @override
  List<Object> get props => [resturant];
}

// state of get Trips
final class HomeTripsLoadingState extends VendorServiceState {}

final class HomeTripsErrorState extends VendorServiceState {
  final RequestState requestState;
  const HomeTripsErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class HomeTripsSuccessState extends VendorServiceState {
  final HomeEntity trips;
  const HomeTripsSuccessState({required this.trips});

  @override
  List<Object> get props => [trips];
}

// state of get Hotels
final class HomeHotelsLoadingState extends VendorServiceState {}

final class HomeHotelsErrorState extends VendorServiceState {
  final RequestState requestState;
  const HomeHotelsErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class HomeHotelsSuccessState extends VendorServiceState {
  final HomeEntity hotels;
  const HomeHotelsSuccessState({required this.hotels});

  @override
  List<Object> get props => [hotels];
}

// state of get Service
final class ServiceLoadingState extends VendorServiceState {}

final class ServiceErrorState extends VendorServiceState {
  final RequestState requestState;
  const ServiceErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class ServiceSuccessState extends VendorServiceState {
  final AllServiceEntity allServiceEntity;
  const ServiceSuccessState({required this.allServiceEntity});

  @override
  List<Object> get props => [allServiceEntity];
}

// state of set cureentserive
final class SetCurrentService extends VendorServiceState {
  final int currentService;
  const SetCurrentService({required this.currentService});

  @override
  List<Object> get props => [currentService];
}

final class RemoveLogoImage extends VendorServiceState {}
