// To parse this JSON data, do
//
//     final strikesData = strikesDataFromJson(jsonString);

import 'dart:convert';

List<StrikesData> strikesDataFromJson(String str) => List<StrikesData>.from(json.decode(str).map((x) => StrikesData.fromJson(x)));

String strikesDataToJson(List<StrikesData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StrikesData {
    int strikes;

    StrikesData({
        required this.strikes,
    });

    factory StrikesData.fromJson(Map<String, dynamic> json) => StrikesData(
        strikes: json["strikes"],
    );

    Map<String, dynamic> toJson() => {
        "strikes": strikes,
    };
}
