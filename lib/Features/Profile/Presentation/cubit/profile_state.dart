part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

// state of get profile

final class GetProfileLoading extends ProfileState {}

final class GetProfileSuccess extends ProfileState {
  final ProfileEntity profileEntity;
  const GetProfileSuccess({required this.profileEntity});
  @override
  List<Object> get props => [profileEntity];
}

final class GetProfileError extends ProfileState {
  final RequestState requestState;
  const GetProfileError({required this.requestState});
  @override
  List<Object> get props => [requestState];
}

// state of set UserData

final class SetUserDataSuccess extends ProfileState {
  final Userdata userdata;
  const SetUserDataSuccess({required this.userdata});
  @override
  List<Object> get props => [userdata];
}

// state of set image file

final class ProfileImagePicked extends ProfileState {
  final File image;
  const ProfileImagePicked({required this.image});
  @override
  List<Object> get props => [image];
}

// state of get additional page

final class GetAdditionalPageLoading extends ProfileState {}

final class GetAdditionalPageSuccess extends ProfileState {
  final AdditionalEntity additionalPageEntity;
  const GetAdditionalPageSuccess({required this.additionalPageEntity});
  @override
  List<Object> get props => [additionalPageEntity];
}

final class GetAdditionalPageError extends ProfileState {
  final RequestState requestState;
  const GetAdditionalPageError({required this.requestState});
  @override
  List<Object> get props => [requestState];
}
