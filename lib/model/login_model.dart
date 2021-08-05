class UserModel {
  UserModel({
    required this.name,
    required this.status,
    required this.id,
    required this.sdt,
    this.email,
    this.address,
  });
  final String name;
  final int? status;
  final int? id;
  final int? sdt;
  final String? email;
  final String? address;
}
