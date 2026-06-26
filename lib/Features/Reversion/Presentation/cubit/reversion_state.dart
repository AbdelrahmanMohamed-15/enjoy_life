part of 'reversion_cubit.dart';

sealed class ReversionState extends Equatable {
  const ReversionState();

  @override
  List<Object?> get props => [];
}

final class ReversionInitial extends ReversionState {}

// state of set Status and Service ID
final class SetReversionStatus extends ReversionState {
  final String? status;
  final int? serviceID;
  const SetReversionStatus({this.status, this.serviceID});

  @override
  List<Object?> get props => [status, serviceID];
}

// state of get All Reversion
final class GetAllReversion extends ReversionState {
  final ReversionEntity reversionEntity;
  final RequestState reversionRequestState;
  const GetAllReversion({
    required this.reversionEntity,
    required this.reversionRequestState,
  });

  @override
  List<Object?> get props => [reversionEntity, reversionRequestState];
}

final class ReversionLoading extends ReversionState {}

final class ReversionError extends ReversionState {
  final RequestState error;
  const ReversionError({required this.error});

  @override
  List<Object?> get props => [error];
}
