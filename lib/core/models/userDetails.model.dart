

import 'dart:convert';

GetUserUpdateDetaile getUserUpdateDetaileFromJson(String str) => GetUserUpdateDetaile.fromJson(json.decode(str));

String getUserUpdateDetaileToJson(GetUserUpdateDetaile data) => json.encode(data.toJson());

class GetUserUpdateDetaile {
  GetUserUpdateDetaile({
    required this.id,
    required this.name,
    required this.email,
    required this.contactNo,
    required this.address,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String email;
  String contactNo;
  String address;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory GetUserUpdateDetaile.fromJson(Map<String, dynamic> json) => GetUserUpdateDetaile(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    contactNo: json["contact_no"],
    address: json["address"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "contact_no": contactNo,
    "address": address,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
