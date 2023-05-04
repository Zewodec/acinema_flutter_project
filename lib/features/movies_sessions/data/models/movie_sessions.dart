import 'dart:convert';

MovieSessions movieSessionsFromJson(String str) =>
    MovieSessions.fromJson(json.decode(str));

String movieSessionsToJson(MovieSessions data) => json.encode(data.toJson());

class MovieSessions {
  List<MovieSessionModel> data;

  MovieSessions({
    required this.data,
  });

  factory MovieSessions.fromJson(Map<String, dynamic> json) => MovieSessions(
        data: List<MovieSessionModel>.from(
            json["data"].map((x) => MovieSessionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MovieSessionModel {
  int id;
  int date;
  String type;
  int minPrice;
  Room room;

  MovieSessionModel({
    required this.id,
    required this.date,
    required this.type,
    required this.minPrice,
    required this.room,
  });

  factory MovieSessionModel.fromJson(Map<String, dynamic> json) =>
      MovieSessionModel(
        id: json["id"],
        date: json["date"],
        type: json["type"],
        minPrice: json["minPrice"],
        room: Room.fromJson(json["room"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "type": type,
        "minPrice": minPrice,
        "room": room.toJson(),
      };
}

class Room {
  int id;
  String name;
  List<Row> rows;

  Room({
    required this.id,
    required this.name,
    required this.rows,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        name: json["name"],
        rows: List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class Row {
  int id;
  int index;
  List<Seat> seats;

  Row({
    required this.id,
    required this.index,
    required this.seats,
  });

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json["id"],
        index: json["index"],
        seats: List<Seat>.from(json["seats"].map((x) => Seat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "index": index,
        "seats": List<dynamic>.from(seats.map((x) => x.toJson())),
      };
}

class Seat {
  int id;
  int index;
  int type;
  int price;
  bool isAvailable;

  Seat({
    required this.id,
    required this.index,
    required this.type,
    required this.price,
    required this.isAvailable,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        id: json["id"],
        index: json["index"],
        type: json["type"],
        price: json["price"],
        isAvailable: json["isAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "index": index,
        "type": type,
        "price": price,
        "isAvailable": isAvailable,
      };
}
