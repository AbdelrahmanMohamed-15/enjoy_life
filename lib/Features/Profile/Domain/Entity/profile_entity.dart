import 'package:easy_life/Features/Authentication/Domain/Entity/user_entity.dart';
import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final bool? status;
  final int? code;
  final String? message;
  final Userdata? data;

  const ProfileEntity({this.status, this.code, this.message, this.data});

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => ProfileEntity(
    status: json["status"] ?? false,
    code: json["code"] ?? 0,
    message: json["message"] ?? '',
    data: json["data"] == null ? null : Userdata.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [status, code, message, data];
}
