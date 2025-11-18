import 'package:equatable/equatable.dart';

class SliderEntity extends Equatable {
  final List<Datum>? data;
  final String? message;
  final int? status;

  const SliderEntity({this.data, this.message, this.status});

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
  final String? name;
  final String? url;
  final String? image;

  Datum({this.id, this.url, this.image, this.name});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    url: json["url"],
    image: json["image"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "image": image,
    "name": name,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [id, url, image, name];
}
