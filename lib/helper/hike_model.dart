import 'package:m_hike_flutter/helper/db_helper.dart';

class HikeModel {

  int? id;
  String? name;
  String? location;
  String? date;
  String? parking;
  String? length;
  String? difficulty;
  String? accommodation;
  String? personLimit;
  String? description;

  HikeModel(
      this.id,
      this.name,
      this.location,
      this.date,
      this.parking,
      this.length,
      this.difficulty,
      this.accommodation,
      this.personLimit,
      this.description);

  HikeModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    location = map['location'];
    date = map["date"];
    parking = map["parking"];
    length = map["length"];
    difficulty = map["difficulty"];
    accommodation = map["accommodation"];
    personLimit = map["personLimit"];
    description = map["description"];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnLocation: location,
      DatabaseHelper.columnDate: date,
      DatabaseHelper.columnParking: parking,
      DatabaseHelper.columnLength: length,
      DatabaseHelper.columnDifficulty: difficulty,
      DatabaseHelper.columnAccommodation: accommodation,
      DatabaseHelper.columnPersonLimit: personLimit,
      DatabaseHelper.columnDescription: description,
    };
  }
}