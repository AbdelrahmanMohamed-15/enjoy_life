part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

// state of get sliders
final class HomeLoadingState extends HomeState {}

final class HomeErrorState extends HomeState {
  final RequestState requestState;
  const HomeErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class HomeSuccessState extends HomeState {
  final SliderEntity sliders;
  const HomeSuccessState({required this.sliders});

  @override
  List<Object> get props => [sliders];
}

// state of get Resturant
final class HomeResturantLoadingState extends HomeState {}

final class HomeResturantErrorState extends HomeState {
  final RequestState requestState;
  const HomeResturantErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class HomeResturantSuccessState extends HomeState {
  final HomeEntity resturant;
  const HomeResturantSuccessState({required this.resturant});

  @override
  List<Object> get props => [resturant];
}

// state of get Trips
final class HomeTripsLoadingState extends HomeState {}

final class HomeTripsErrorState extends HomeState {
  final RequestState requestState;
  const HomeTripsErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class HomeTripsSuccessState extends HomeState {
  final HomeEntity trips;
  const HomeTripsSuccessState({required this.trips});

  @override
  List<Object> get props => [trips];
}

// state of get Hotels
final class HomeHotelsLoadingState extends HomeState {}

final class HomeHotelsErrorState extends HomeState {
  final RequestState requestState;
  const HomeHotelsErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class HomeHotelsSuccessState extends HomeState {
  final HomeEntity hotels;
  const HomeHotelsSuccessState({required this.hotels});

  @override
  List<Object> get props => [hotels];
}

// state of get Favourite
final class HomeFavouriteLoadingState extends HomeState {}

final class HomeFavouriteErrorState extends HomeState {
  final RequestState requestState;
  const HomeFavouriteErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class HomeFavouriteSuccessState extends HomeState {
  final HomeEntity favourite;
  const HomeFavouriteSuccessState({required this.favourite});

  @override
  List<Object> get props => [favourite];
}

// state of get All Home
final class HomeAllLoadingState extends HomeState {}

final class HomeAllErrorState extends HomeState {
  final RequestState requestState;
  const HomeAllErrorState({required this.requestState});

  @override
  List<Object> get props => [requestState];
}

final class HomeAllSuccessState extends HomeState {
  final HomeEntity all;
  const HomeAllSuccessState({required this.all});

  @override
  List<Object> get props => [all];
}
