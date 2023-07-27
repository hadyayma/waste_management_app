import 'package:cloud_firestore/cloud_firestore.dart';
class UserWastee {
  final String? docId;
  final String? ApartmentNumber;
  final String? buildingNumber;
  final String? street;
  final String? datePublished;
  final bool? Servecedate;
  final bool? Servecetime;
  final String? Name;
  final String? Email;
  final String? uid;
  final String? Phone;
  final String? postURL;
  final String? postId;

  UserWastee({
    this.docId,
    this.ApartmentNumber,
    this.buildingNumber,
    this.street,
    this.datePublished,
    this.Servecedate,
    this.Servecetime,
    this.Name,
    this.Email,
    this.uid,
    this.Phone,
    this.postURL,
    this.postId,
  });

}

