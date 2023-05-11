import 'dart:convert';

UserImpl userImplFromJson(String str) => UserImpl.fromJson(json.decode(str));

String userImplToJson(UserImpl data) => json.encode(data.toJson());

class UserImpl {
  UserModel data;

  UserImpl({
    required this.data,
  });

  factory UserImpl.fromJson(Map<String, dynamic> json) => UserImpl(
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
        name: json["name"],
        phoneNumber: json["phoneNumber"],
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
