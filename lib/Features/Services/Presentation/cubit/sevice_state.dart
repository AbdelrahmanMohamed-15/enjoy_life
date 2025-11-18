part of 'service_cubit.dart';

sealed class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

final class ResturantInitial extends ServiceState {}

// state of get Resturant
final class ResturantLoading extends ServiceState {}

final class ResturantSuccessState extends ServiceState {
  final ServiceDetailsEntity resturant;
  const ResturantSuccessState({required this.resturant});
  @override
  List<Object> get props => [resturant];
}

final class ResturantErrorState extends ServiceState {
  final RequestState requestState;
  const ResturantErrorState({required this.requestState});
  @override
  List<Object> get props => [requestState];
}

// state of get Hotel
final class HotelLoading extends ServiceState {}

final class HotelSuccessState extends ServiceState {
  final ServiceDetailsEntity hotel;
  const HotelSuccessState({required this.hotel});
  @override
  List<Object> get props => [hotel];
}

final class HotelErrorState extends ServiceState {
  final RequestState requestState;
  const HotelErrorState({required this.requestState});
  @override
  List<Object> get props => [requestState];
}

// state of get Trip
final class TripLoading extends ServiceState {}

final class TripSuccessState extends ServiceState {
  final ServiceDetailsEntity trip;
  const TripSuccessState({required this.trip});
  @override
  List<Object> get props => [trip];
}

final class TripErrorState extends ServiceState {
  final RequestState requestState;
  const TripErrorState({required this.requestState});
  @override
  List<Object> get props => [requestState];
}

// state of time
final class SetTimeState extends ServiceState {
  final TimeOfDay timeOfDay;
  const SetTimeState({required this.timeOfDay});
  @override
  List<Object> get props => [timeOfDay];
}

// state of time
final class SetDateState extends ServiceState {
  final DateTime dateTime;
  const SetDateState({required this.dateTime});
  @override
  List<Object> get props => [dateTime];
}

// state of avaliable tables

final class AvaliableTablesLoading extends ServiceState {}

final class AvaliableTablesState extends ServiceState {
  final TableEntity tableEntity;
  const AvaliableTablesState({required this.tableEntity});
  @override
  List<Object> get props => [tableEntity];
}

final class ErrorAvaliableTables extends ServiceState {
  final RequestState requestState;
  const ErrorAvaliableTables({required this.requestState});
  @override
  List<Object> get props => [requestState];
}

// state of avaliable rooms

final class AvaliableRoomsLoading extends ServiceState {}

final class AvaliableRoomsState extends ServiceState {
  final RoomEntity roomEntity;
  const AvaliableRoomsState({required this.roomEntity});
  @override
  List<Object> get props => [roomEntity];
}

final class ErrorAvaliableRooms extends ServiceState {
  final RequestState requestState;
  const ErrorAvaliableRooms({required this.requestState});
  @override
  List<Object> get props => [requestState];
}

// state of avaliable Trips

final class AvaliableTripsLoading extends ServiceState {}

final class AvaliableTripsState extends ServiceState {
  final TripEntity tripEntity;
  const AvaliableTripsState({required this.tripEntity});
  @override
  List<Object> get props => [tripEntity];
}

final class ErrorAvaliableTrips extends ServiceState {
  final RequestState requestState;
  const ErrorAvaliableTrips({required this.requestState});
  @override
  List<Object> get props => [requestState];
}
