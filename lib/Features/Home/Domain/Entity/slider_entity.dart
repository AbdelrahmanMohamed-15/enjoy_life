import 'package:equatable/equatable.dart';

class SliderEntity extends Equatable {
  final List<Datum>? data;
  final String? message;
  final int? status;

  SliderEntity({this.data, this.message, this.status});

  factory SliderEntity.fromJson(Map<String, dynamic> json) => SliderEntity(
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"] ?? "",
    status: json["status"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [data, message, status];
}

class Datum extends Equatable {
  final int? id;
  final String? type;
  final String? url;
  final String? image;
  final int? status;
  final String? name;

  Datum({this.id, this.type, this.url, this.image, this.status, this.name});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    type: json["type"],
    url: json["url"],
    image: json["image"],
    status: json["status"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "url": url,
    "image": image,
    "status": status,
    "name": name,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, type, url, image, status, name];
}
