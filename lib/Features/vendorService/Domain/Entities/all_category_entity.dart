class AllCategoryEntity {
  final List<CategoryData>? data;
  final String? message;
  final int? status;

  AllCategoryEntity({this.data, this.message, this.status});

  factory AllCategoryEntity.fromJson(Map<String, dynamic> json) =>
      AllCategoryEntity(
        data: json["data"] == null
            ? []
            : List<CategoryData>.from(
                json["data"]!.map((x) => CategoryData.fromJson(x)),
              ),
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
}

class CategoryData {
  final int? id;
  final int? clientId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? name;

  CategoryData({
    this.id,
    this.clientId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"] ?? 0,
    clientId: json["client_id"] ?? 0,
    status: json["status"] ?? 0,
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"] ?? "",
    name: json["name"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "name": name,
  };
}
