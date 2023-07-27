import 'package:Staff/views/utils/AppColor.dart';
import 'package:Staff/views/widgets/custom_text_field.dart';
import 'package:Staff/views/widgets/modals/todo/current_list.dart';
import 'package:Staff/views/widgets/modals/todo/todo_Screen.dart';
import 'package:Staff/views/widgets/modals/todo/user_request_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebaseAuth;
import 'package:flutter/material.dart';

class UserRequestScreen extends StatelessWidget {
  final String todoItemId;

  const UserRequestScreen({required this.todoItemId});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.User? currentUser = FirebaseAuth.FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: AppColor.primary,
        ),
        body: Center(
          child: Text('Please log in to view the profile.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: AppColor.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                builder: (context) =>TodoScreen()
            ),
            );
            },
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where('requestId', isEqualTo: todoItemId)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: AppColor.primaryExtraSoft,
                color: AppColor.primary,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.data?.docs.isEmpty ?? true) {
            return Center(
              child: Text('User member not found'),
            );
          }

          final userDocs = snapshot.data!.docs;

          final userData = userDocs[0].data();
          final user = UserRequest(
            docId: userDocs[0].id,
            postURL: userData['postURL'] ?? '',
            Name: userData['Name'] ?? '',
            WasteType: userData['WasteType'] ?? '',
            Email: userData['Email'] ?? '',
            Address: userData['Address'] ?? '',
            uid: userData['uid'] ?? '',
            requestId: userData['requestId'] ?? '',
            requestCode: userData['requestCode'] ?? '',
            Phone: userData['Phone'] ?? '',
            quantity: userData['quantity'] ?? '',
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user.postURL!),
                            backgroundColor: AppColor.whiteSoft,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    // FullName
                    Text(
                      'User',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${user.Name}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    // Email
                    buildInfoRow('Email', user.Email!),
                    SizedBox(height: 16),
                    Divider(),
                    // Phone
                    buildInfoRow('Phone', user.Phone!),
                    SizedBox(height: 16),
                    Divider(),
                    // Address
                    buildInfoRow('Address', user.Address!),
                    SizedBox(height: 16),
                    Divider(),
                    // WasteType
                    buildInfoRow('Waste Type', user.WasteType!),
                    SizedBox(height: 16),
                    Divider(),
                    // Quantity
                    buildInfoRow('Quantity', user.quantity!),
                    SizedBox(height: 16),
                    Divider(),
                    // RequestCode
                    Text(
                      'Cleaner Code:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      user.requestCode!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(),
                    // RequestId
                    Text(
                      'Cleaner Id:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      user.requestId!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    Divider(),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}
