// To parse this JSON data, do
//
//     final expiryData = expiryDataFromJson(jsonString);

import 'dart:convert';

List<ExpiryData> expiryDataFromJson(String str) => List<ExpiryData>.from(json.decode(str).map((x) => ExpiryData.fromJson(x)));

String expiryDataToJson(List<ExpiryData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpiryData {
    String expiryDates;

    ExpiryData({
        required this.expiryDates,
    });

    factory ExpiryData.fromJson(Map<String, dynamic> json) => ExpiryData(
        expiryDates: json["expiry_dates"],
    );

    Map<String, dynamic> toJson() => {
        "expiry_dates": expiryDates,
    };
}
