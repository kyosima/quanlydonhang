// To parse this JSON data, do
//
//     final chiTietDonHang = chiTietDonHangFromJson(jsonString);

import 'dart:convert';

ChiTietDonHang chiTietDonHangFromJson(String str) =>
    ChiTietDonHang.fromJson(json.decode(str));

String chiTietDonHangToJson(ChiTietDonHang data) => json.encode(data.toJson());

class ChiTietDonHang {
  ChiTietDonHang({
    required this.id,
    required this.name,
    required this.ngaypost,
    required this.nguoipost,
    required this.trangthai,
    required this.deadline,
    required this.giatien,
    required this.trangthaihost,
    required this.giahost,
    this.ngaybatdauhost,
    required this.tenmien,
    required this.trangthaitenmien,
    required this.giatenmien,
    required this.ngaybatdautenmien,
    required this.tiencoc,
    required this.danhgia,
    required this.gopy,
    required this.kythuat,
    required this.sale,
  });

  int id;
  String name;
  String ngaypost;
  String nguoipost;
  String trangthai;
  String deadline;
  String giatien;
  int trangthaihost;
  int giahost;
  String? ngaybatdauhost;
  String tenmien;
  String trangthaitenmien;
  String giatenmien;
  String ngaybatdautenmien;
  String tiencoc;
  int danhgia;
  String gopy;
  String kythuat;
  String sale;

  factory ChiTietDonHang.fromJson(Map<String, dynamic> json) => ChiTietDonHang(
        id: json["id"],
        name: json["name"],
        ngaypost: json["ngaypost"],
        nguoipost: json["nguoipost"],
        trangthai: json["trangthai"],
        deadline: json["deadline"],
        giatien: json["giatien"],
        trangthaihost: json["trangthaihost"],
        giahost: json["giahost"],
        ngaybatdauhost: json["ngaybatdauhost"],
        tenmien: json["tenmien"],
        trangthaitenmien: json["trangthaitenmien"],
        giatenmien: json["giatenmien"],
        ngaybatdautenmien: json["ngaybatdautenmien"],
        tiencoc: json["tiencoc"],
        danhgia: json["danhgia"],
        gopy: json["gopy"],
        kythuat: json["kythuat"],
        sale: json["sale"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ngaypost": ngaypost,
        "nguoipost": nguoipost,
        "trangthai": trangthai,
        "deadline": deadline,
        "giatien": giatien,
        "trangthaihost": trangthaihost,
        "giahost": giahost,
        "ngaybatdauhost": ngaybatdauhost,
        "tenmien": tenmien,
        "trangthaitenmien": trangthaitenmien,
        "giatenmien": giatenmien,
        "ngaybatdautenmien": ngaybatdautenmien,
        "tiencoc": tiencoc,
        "danhgia": danhgia,
        "gopy": gopy,
        "kythuat": kythuat,
        "sale": sale,
      };
}
