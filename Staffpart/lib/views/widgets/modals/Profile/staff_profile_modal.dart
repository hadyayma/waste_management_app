import 'package:cloud_firestore/cloud_firestore.dart';

class Staff {
  final String? docId;
  final String? photoURL;
  final String? department;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? address;
  final String? uid;
  final String? phone;
  final String? bio;
  final bool? isActive;
  final bool? Active;

  Staff({
    this.docId,
    this.photoURL,
    this.department,
    this.firstname,
    this.lastname,
    this.email,
    this.address,
    this.uid,
    this.phone,
    this.bio,
    this.isActive,
    this.Active,
  });

  Staff.fromJson(Map<String, dynamic> json)
      : firstname = json['firstname'] ?? '',
        lastname = json['lastname'] ?? '',
        address = json['address'] ?? '',
        docId = json['docId'] ?? '',
        department = json['department'] ?? '',
        photoURL = json['photoURL'] ?? '',
        phone = json['phone'] ?? '',
        email = json['email'] ?? '',
        uid = json['uid'] ?? '',
        isActive = json['isActive'] ?? '',
        Active = json['Active'] ?? '',
        bio = json['bio'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'docId': docId,
      'department': department,
      'photoURL': photoURL,
      'uid': uid,
      'phone': phone,
      'email': email,
      'bio': bio,
      'isActive': isActive,
      'Active': Active,
    };
  }
}
