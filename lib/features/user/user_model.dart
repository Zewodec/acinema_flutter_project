import 'dart:convert';

UserModelImpl userImplFromJson(String str) =>
    UserModelImpl.fromJson(json.decode(str));

String userImplToJson(UserModelImpl data) => json.encode(data.toJson());

class UserModelImpl {
  UserModel data;

  UserModelImpl({
    required this.data,
  });

  factory UserModelImpl.fromJson(Map<String, dynamic> json) => UserModelImpl(
        data: UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UserModel {
  int id;
  String name;
  String phoneNumber;
  int createdAt;
  int updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
        name: json["name"] ?? "No Name",
        phoneNumber: json["phoneNumber"] ?? "No Phone Number",
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phoneNumber,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
