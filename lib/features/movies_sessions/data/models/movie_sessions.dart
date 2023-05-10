import 'dart:convert';

MovieSessionsImpl movieSessionsFromJson(String str) =>
    MovieSessionsImpl.fromJson(json.decode(str));

String movieSessionsToJson(MovieSessionsImpl data) =>
    json.encode(data.toJson());

class MovieSessionsImpl {
  List<MovieSessionModel> data;

  MovieSessionsImpl({
    required this.data,
  });

  void sortFromNewToOld() {
    for (int i = 0; i < data.length - 1; i++) {
      for (int j = 0; j < data.length - 1; j++) {
        if (data[j].date > data[j + 1].date) {
          var temp = data[j].date;
          data[j].date = data[j + 1].date;
          data[j + 1].date = temp;
        }
      }
    }
  }

  factory MovieSessionsImpl.fromJson(Map<String, dynamic> json) =>
      MovieSessionsImpl(
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
  List<RoomRow> rows;

  Room({
    required this.id,
    required this.name,
    required this.rows,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        name: json["name"],
        rows: List<RoomRow>.from(json["rows"].map((x) => RoomRow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
      };
}

class RoomRow {
  int id;
  int index;
  List<Seat> seats;

  RoomRow({
    required this.id,
    required this.index,
    required this.seats,
  });

  factory RoomRow.fromJson(Map<String, dynamic> json) => RoomRow(
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
