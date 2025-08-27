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
