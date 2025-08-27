import 'package:equatable/equatable.dart';

class BaseEntity extends Equatable {
  final bool? status;
  final int? code;
  final String? message;

  const BaseEntity({this.status, this.code, this.message});

  factory BaseEntity.fromJson(Map<String, dynamic> json) => BaseEntity(
    status: json["status"] ?? false,
    code: json["code"] ?? 0,
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [status, code, message];
}
