import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final bool? status;
  final int? code;
  final String? message;
  final Data? data;

  const UserEntity({this.status, this.code, this.message, this.data});

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    status: json["status"] ?? false,
    code: json["code"] ?? 0,
    message: json["message"] ?? '',
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
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

class Data extends Equatable {
  final Userdata? userdata;
  final Token? token;

  const Data({this.userdata, this.token});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userdata: json["userdata"] == null
        ? null
        : Userdata.fromJson(json["userdata"]),
    token: json["token"] == null ? null : Token.fromJson(json["token"]),
  );

  Map<String, dynamic> toJson() => {
    "userdata": userdata?.toJson(),
    "token": token?.toJson(),
  };

  @override
  // TODO: implement props
  List<Object?> get props => [userdata, token];
}

class Token extends Equatable {
  final Original? original;

  const Token({this.original});

  factory Token.fromJson(Map<String, dynamic> json) => Token(
    original: json["original"] == null
        ? null
        : Original.fromJson(json["original"]),
  );

  Map<String, dynamic> toJson() => {"original": original?.toJson()};

  @override
  // TODO: implement props
  List<Object?> get props => [original];
}

class Original extends Equatable {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;

  const Original({this.accessToken, this.tokenType, this.expiresIn});

  factory Original.fromJson(Map<String, dynamic> json) => Original(
    accessToken: json["access_token"] ?? '',
    tokenType: json["token_type"] ?? '',
    expiresIn: json["expires_in"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [accessToken, tokenType, expiresIn];
}

class Userdata extends Equatable {
  final int? id;
  final String? fullName;
  final String? username;
  final String? image;
  final String? phone;
  final String? address;
  final String? countryCode;
  final int? banned;
  final String? email;
  final String? latitude;
  final String? longitude;
  final String? code;
  final int? verificationType;
  final int? clientType;
  final int? countryId;
  // final String? gender;
  // final String? bloodGroup;
  // final String? birthdate;
  final String? fcmToken;

  const Userdata({
    this.id,
    this.fullName,
    this.username,
    this.image,
    this.phone,
    this.address,
    this.countryCode,
    this.banned,
    this.email,
    this.latitude,
    this.longitude,
    this.code,
    this.verificationType,
    this.clientType,
    this.countryId,
    // this.gender,
    // this.bloodGroup,
    // this.birthdate,
    this.fcmToken,
  });

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
    id: json["id"] ?? 0,
    fullName: json["full_name"] ?? '',
    username: json["username"] ?? '',
    image: json["image"] ?? '',
    phone: json["phone"] ?? '',
    address: json["address"] ?? '',
    countryCode: json["country_code"] ?? '',
    banned: json["banned"] ?? 0,
    email: json["email"] ?? '',
    latitude: (json["latitude"] ?? 0.0).toString(),
    longitude: (json["longitude"] ?? 0.0).toString(),
    code: json["code"] ?? '',
    verificationType: json["verification_type"] ?? 0,
    clientType: json["client_type"] ?? 0,
    countryId: json["country_id"] ?? 0,
    // gender: json["gender"] ?? '',
    // bloodGroup: json["blood_group"] ?? '',
    // birthdate: json["birthdate"] ?? '',
    fcmToken: json["fcm_token"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "username": username,
    "image": image,
    "phone": phone,
    "address": address,
    "country_code": countryCode,
    "banned": banned,
    "email": email,
    "latitude": latitude,
    "longitude": longitude,
    "code": code,
    "verification_type": verificationType,
    "client_type": clientType,
    "country_id": countryId,
    // "gender": gender,
    // "blood_group": bloodGroup,
    // "birthdate": birthdate,
    "fcm_token": fcmToken,
  };

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    fullName,
    username,
    image,
    phone,
    address,
    countryCode,
    banned,
    email,
    latitude,
    longitude,
    code,
    verificationType,
    clientType,
    countryId,
    // gender,
    // bloodGroup,
    // birthdate,
    fcmToken,
  ];
}
