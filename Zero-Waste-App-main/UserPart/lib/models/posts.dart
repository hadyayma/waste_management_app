// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zeros/db/authentication/firebase_auth_methods.dart';

/*class UserPost {
  final title;
  final houseStatus;
  final houseType;
  final email;
  final contactnumber;
  final location;
  final overview;
  final price;
  final beds;
  final rooms;
  final sqft;
  final uid;
  final userName;
  final postId;
  final datePublished;
  final postURL;

  final likes;
  // creating the constructor here...
  UserPost({
    required this.houseStatus,
    required this.houseType,
    required this.title,
    required this.contactnumber,
    required this.email,
    required this.uid,
    required this.userName,
    required this.postId,
    required this.datePublished,
    required this.postURL,
    required this.likes,
    required this.beds,
    required this.location,
    required this.overview,
    required this.price,
    required this.rooms,
    required this.sqft,
  });
  // converting it to the map object
  Map<String, dynamic> toJson() => {
        "houseStatus": houseStatus,
        "houseType": houseType,
        "postId": postId,
        "contactnumber": contactnumber,
        "useremail": email,
        "title": title,
        "userName": userName,
        "location": location,
        "price": price,
        "beds": beds,
        "rooms": rooms,
        "sqft": sqft,
        "overview": overview,
        "datePublished": datePublished,
        "likes": likes,
        "postURL": postURL,
        "uid": FirebaseAuth.instance.currentUser!.uid,
      };
  static UserPost fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return UserPost(
      uid: snapshot['uid'],
      houseStatus: snapshot['houseStatus'],
      houseType: snapshot['houseType'],
      email: snapshot['email'],
      contactnumber: snapshot['contactnumber'],
      userName: snapshot['userName'],
      likes: snapshot['likes'],
      datePublished: snapshot['datePublished'],
      postURL: snapshot['postURL'],
      postId: snapshot['postId'],
      sqft: snapshot['sqft'],
      beds: snapshot['beds'],
      location: snapshot['location'],
      overview: snapshot['overview'],
      price: snapshot['price'],
      rooms: snapshot['rooms'],
      title: snapshot['title'],
    );
  }
}*/

class UserRequest {
  final quantity;
  final ServeceStatus;
  final WasteType;
  final email;
  final contactnumber;
  final totalPoint;
  final overview;
  final Name;
  final Email;
  final Phone;
  final Address;
  final uid;
  final userName;
  final postId;
  final datePublished;
  final postURL;
  bool Aactivation;


  // creating the constructor here...
  UserRequest({
    required this.contactnumber,
    required this.email,
    required this.uid,
    required this.userName,
    required this.postId,
    required this.datePublished,
    required this.postURL,
    required this.overview,
    required this.ServeceStatus,
    required this.WasteType,
    required this.quantity,
    required this.totalPoint,
    required this. Name,
    required this. Email,
    required this. Phone,
    required this. Address,
    this.Aactivation = true,
  });
  // converting it to the map object
  Map<String, dynamic> toJson() => {
    "ServeceStatus": ServeceStatus,
    "WasteType": WasteType,
    "postId": postId,
    "Aactivation": Aactivation,
    "contactnumber": contactnumber,
    "useremail": email,
    "quantity": quantity,
    "userName": userName,
    "totalPoint": totalPoint,
    "Name": Name,
    "Email": Email,
    "Phone": Phone,
    "Address": Address,
    "overview": overview,
    "datePublished": datePublished,
    "postURL": postURL,
    "uid": FirebaseAuth.instance.currentUser!.uid,
  };
  static UserRequest fromSnap(Map<String, dynamic> snapshot) {
    return UserRequest(
      uid: snapshot['uid'],
      ServeceStatus: snapshot['ServeceStatus'],
      Aactivation: snapshot['Aactivation'] ?? true,
      WasteType: snapshot['WasteType'],
      email: snapshot['email'],
      contactnumber: snapshot['contactnumber'],
      userName: snapshot['userName'],
      datePublished: snapshot['datePublished'],
      postURL: snapshot['postURL'],
      postId: snapshot['postId'],
      Address: snapshot['Address'],
      Phone: snapshot['Phone'],
      Name: snapshot['Name'],
      overview: snapshot['overview'],
      totalPoint: snapshot['totalPoint'],
      quantity: snapshot['quantity'],
      Email: snapshot['Email'],
    );
  }
}
class UserwasteCollection {
  final ApartmentNumber;
  final Servecedate;
  final Servecetime;
  final email;
  final contactnumber;
  final buildingNumber;
  final street;
  final Name;
  final Email;
  final Phone;
  final uid;
  final userName;
  final postId;
  final datePublished;
  final postURL;


  // creating the constructor here...
  UserwasteCollection({
    required this.contactnumber,
    required this.email,
    required this.uid,
    required this.userName,
    required this.postId,
    required this.datePublished,
    required this.postURL,
    required this.ApartmentNumber,
    required this.Servecedate,
    required this.Servecetime,
    required this.buildingNumber,
    required this.street,
    required this. Name,
    required this. Email,
    required this. Phone,
  });
  // converting it to the map object
  Map<String, dynamic> toJson() => {
    "Servecetime": Servecetime,
    "Servecedate": Servecedate,
    "postId": postId,
    "contactnumber": contactnumber,
    "useremail": email,
    "street": street,
    "userName": userName,
    "buildingNumber": buildingNumber,
    "Name": Name,
    "Email": Email,
    "Phone": Phone,
    "ApartmentNumber": ApartmentNumber,
    "datePublished": datePublished,
    "postURL": postURL,
    "uid": FirebaseAuth.instance.currentUser!.uid,
  };
  static UserwasteCollection fromSnap(Map<String, dynamic> snapshot) {
    return UserwasteCollection(
      uid: snapshot['uid'],
      Servecetime: snapshot['Servecetime'],
      Servecedate: snapshot['Servecedate'],
      email: snapshot['email'],
      contactnumber: snapshot['contactnumber'],
      userName: snapshot['userName'],
      datePublished: snapshot['datePublished'],
      postURL: snapshot['postURL'],
      postId: snapshot['postId'],
      Phone: snapshot['Phone'],
      Name: snapshot['Name'],
      buildingNumber: snapshot['buildingNumber'],
      ApartmentNumber: snapshot['ApartmentNumber'],
      street: snapshot['street'],
      Email: snapshot['Email'],
    );
  }
}
class MessageDataModel {
  MessageDataModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.time,
  });

  final String senderId;
  final String receiverId;
  final String message;
  final Timestamp time;

  MessageDataModel.fromJson(Map<String, dynamic> json)
      : senderId = json['senderId'] ?? '',
        receiverId = json['receiverId'] ?? '',
        message = json['message'] ?? '',
        time = json['time'] as Timestamp? ?? Timestamp.now();

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'time': time,
    };
  }
}



