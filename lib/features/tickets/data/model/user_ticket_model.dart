import 'dart:convert';

UserTicketsImpl userTicketsImplFromJson(String str) =>
    UserTicketsImpl.fromJson(json.decode(str));

String userTicketsImplToJson(UserTicketsImpl data) =>
    json.encode(data.toJson());

class UserTicketsImpl {
  List<UserTicketModel> data;

  UserTicketsImpl({
    required this.data,
  });

  factory UserTicketsImpl.fromJson(Map<String, dynamic> json) =>
      UserTicketsImpl(
        data: List<UserTicketModel>.from(
            json["data"].map((x) => UserTicketModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class UserTicketModel {
  int id;
  int movieId;
  String name;
  int date;
  String image;
  String smallImage;

  UserTicketModel({
    required this.id,
    required this.movieId,
    required this.name,
    required this.date,
    required this.image,
    required this.smallImage,
  });

  factory UserTicketModel.fromJson(Map<String, dynamic> json) =>
      UserTicketModel(
        id: json["id"],
        movieId: json["movieId"],
        name: json["name"],
        date: json["date"],
        image: json["image"],
        smallImage: json["smallImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "movieId": movieId,
        "name": name,
        "date": date,
        "image": image,
        "smallImage": smallImage,
      };
}
