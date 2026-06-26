import 'package:equatable/equatable.dart';

class BaseEntity extends Equatable {
  final int? status;
  final int? code;
  final dynamic message;

  const BaseEntity({this.status, this.code, this.message});

  factory BaseEntity.fromJson(Map<String, dynamic> json) {
    final rawStatus = json['status'];

    int parsedStatus;

    if (rawStatus is bool) {
      parsedStatus = rawStatus ? 200 : 400;
    } else if (rawStatus is int) {
      parsedStatus = rawStatus;
    } else if (rawStatus is String) {
      // optional safety for "true"/"false"
      if (rawStatus.toLowerCase() == 'true') {
        parsedStatus = 200;
      } else if (rawStatus.toLowerCase() == 'false') {
        parsedStatus = 400;
      } else {
        parsedStatus = 400;
      }
    } else {
      parsedStatus = 400;
    }

    return BaseEntity(
      status: parsedStatus,
      code: json['code'] is int
          ? json['code']
          : int.tryParse('${json['code']}'),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
  };

  @override
  List<Object?> get props => [status, code, message];
}
