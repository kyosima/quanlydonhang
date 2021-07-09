// To parse this JSON data, do
//
//     final donHang = donHangFromJson(jsonString);

import 'dart:convert';

Map<String, DonHang> donHangFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, DonHang>(k, DonHang.fromJson(v)));

String donHangToJson(Map<String, DonHang> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class DonHang {
  DonHang({
    required this.id,
    required this.name,
    required this.status,
    required this.date,
  });

  int id;
  String name;
  int status;
  String date;

  factory DonHang.fromJson(Map<String, dynamic> json) => DonHang(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "date": date,
      };
}
