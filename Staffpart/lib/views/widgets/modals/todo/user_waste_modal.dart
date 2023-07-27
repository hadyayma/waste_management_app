import 'package:cloud_firestore/cloud_firestore.dart';
class UserWaste {
  final String? docId;
  final String? ApartmentNumber;
  final String? buildingNumber;
  final String? street;
  final String? datePublished;
  final String? Servecedate;
  final String? Servecetime;
  final String? Name;
  final String? Email;
  final String? uid;
  final String? Phone;
  final String? postURL;
  final String? postId;

  UserWaste({
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
  UserWaste.fromJson(Map<String, dynamic> json)
      : docId = json['docId'] ?? '',
        Name = json['Name'] ?? '',
        datePublished = (json['datePublished'] as Timestamp).toDate().toString(),
        Phone = json['Phone'] ?? '',
        Email = json['Email'] ?? '',
        uid = json['uid'] ?? '',
        Servecedate = json['Servecedate'],
        Servecetime = json['Servecetime'] ,
        ApartmentNumber = json['ApartmentNumber'] ?? '',
        buildingNumber = json['buildingNumber'] ?? '',
        street = json['street'] ?? '',
        postId = json['postId'] ?? '',
        postURL = json['postURL'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'datePublished': datePublished,
      'Email': Email,
      'Phone': Phone,
      'uid': uid,
      'Servecedate': Servecedate,
      'Servecetime': Servecetime,
      'ApartmentNumber': ApartmentNumber,
      'buildingNumber': buildingNumber,
      'street': street,
      'postId': postId,
      'postURL': postURL,
    };
  }
}

