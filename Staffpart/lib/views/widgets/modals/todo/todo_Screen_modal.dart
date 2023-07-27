
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoItem {
  String Name;
  dynamic Address;
  String datePublished;
  String Email;
  String Phone;
  String uid;
  bool? Aactivation; // Nullable field
  String ServeceStatus='Door To Door';


  TodoItem({
    required this.Name,
    required this.Address,
    required this.datePublished,
    required this.Phone,
    required this.Email,
    required this.uid,
    required this.ServeceStatus,

    this.Aactivation, // Nullable field
  });

  TodoItem.fromJson(Map<String, dynamic> json)
      : Name = json['Name'] ?? '',
        Address = json['Address'] ?? '',
        datePublished = (json['datePublished'] as Timestamp).toDate().toString(),
        Phone = json['Phone'] ?? '',
        Email = json['Email'] ?? '',
        uid = json['uid'] ?? '',// Initialize isCompleted to false
        ServeceStatus = json['ServeceStatus'] ?? '',
        Aactivation = json['Aactivation'] ?? ''; // Assign the value from JSON

  Map<String, dynamic> toMap() {
    return {
      'Name': Name,
      'Address': Address,
      'datePublished': datePublished,
      'Email': Email,
      'Phone': Phone,
      'uid': uid,
    };
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class TodoItem {
//   String name;
//   String address;
//   String age;
//   String email;
//
//   TodoItem({
//     required this.name,
//     required this.address,
//     required this.age,
//     required this.email,
//   });
//
//   TodoItem.fromJson(Map<String, dynamic> json)
//       : name = json['Name'],
//         address = json['Address'],
//         age = json['Age'].toString(),
//         email = json['Email'];
//
//   Map<String, dynamic> toMap() {
//     return {
//       'Name': name,
//       'Address': address,
//       'Age': age,
//       'Email': email,
//     };
//   }
// }
//
