import 'package:Staff/views/utils/AppColor.dart';
import 'package:Staff/views/widgets/modals/chat/chat_screen.dart';
import 'package:Staff/views/widgets/modals/todo/user_waste_data.dart';
import 'package:Staff/views/widgets/modals/todo/user_waste_modal.dart';
import 'package:Staff/views/widgets/modals/todo/user_wastee_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class WasteCollectionListScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('wasteCollection')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            color: AppColor.primary,
            backgroundColor: AppColor.primaryExtraSoft,
          ));
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No todos found.'));
        }

        List<UserWaste> userWasteList = snapshot.data!.docs.map((doc) {
          return UserWaste.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        return ListView.builder(
          itemCount: userWasteList.length,
          itemBuilder: (context, index) {
            UserWastee user = UserWastee(
              uid: userWasteList[index].uid,
            ); // Create an instance of the User class with the uid

            return GestureDetector(
              onTap: () {
                // Open the new screen for userdata
                if (Navigator.canPop(context)) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserWasteScreen(
                        todoItemId: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserWasteScreen(
                        todoItemId: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                }
              },
              child: ListTile(
                title: Text(userWasteList[index].Name!),
                subtitle: Text('Time: ${userWasteList[index].datePublished}'),
              ),
            );
          },
        );
      },
    );
  }
}
