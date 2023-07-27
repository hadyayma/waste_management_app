import 'package:Staff/views/utils/AppColor.dart';
import 'package:Staff/views/widgets/modals/chat/chat_screen.dart';
import 'package:Staff/views/widgets/modals/todo/todo_Screen_modal.dart';
import 'package:Staff/views/widgets/modals/todo/user_request_data.dart';
import 'package:Staff/views/widgets/modals/todo/user_request_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:url_launcher/url_launcher.dart';

class CurrentListScreen extends StatelessWidget {

  Future<void> _launchURL(String component) async {
    try {
      // Convert the component name to geographic coordinates
      List<Location> locations = await locationFromAddress(component);

      if (locations.isNotEmpty) {
        // Extract the first location from the results
        Location location = locations.first;

        // Check if the location is within the boundaries of Egypt
        double latitude = location.latitude;
        double longitude = location.longitude;
        bool isInsideEgypt = latitude >= 22.0 && latitude <= 31.7 && longitude >= 25.0 && longitude <= 36.9;

        if (isInsideEgypt) {
          // Create the URL location using the latitude and longitude
          String url = 'https://maps.google.com/?q=$latitude,$longitude';

          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        } else {
          throw 'The location is outside the boundaries of Egypt.';
        }
      } else {
        throw 'No location found for $component';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }


  void updateTodoItemStatus(int index) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('requests')
        .where('Aactivation', isEqualTo: true)
        .where('ServeceStatus', isEqualTo: 'Door To Door')
        .get();

    if (snapshot.docs.length > index) {
      DocumentReference docRef = snapshot.docs[index].reference;
      try {
        await docRef.update({'Aactivation': false});
      } catch (e) {
        print('Error updating todo item status: $e');
      }
    } else {
      print('Todo item not found at index $index');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('requests')
          .where('Aactivation', isEqualTo: true)
          .where('ServeceStatus', isEqualTo: 'Door To Door')
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

        List<TodoItem> todoItems = snapshot.data!.docs.map((doc) {
          return TodoItem.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
        return ListView.builder(
          itemCount: todoItems.length,
          itemBuilder: (context, index) {
            UserRequest user = UserRequest(
              uid: todoItems[index].uid,
            ); // Create an instance of the User class with the uid

            return GestureDetector(
              onTap: () {
                // Open the new screen for userdata
                if (Navigator.canPop(context)) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserRequestScreen(
                        todoItemId: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserRequestScreen(
                        todoItemId: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                }
              },
              child: ListTile(
                title: Text(todoItems[index].Name),
                subtitle: Text('Time: ${todoItems[index].datePublished}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.location_on,
                      ),
                      onPressed: () => _launchURL(todoItems[index].Address),
                      color: AppColor.primary,
                    ),
                    IconButton(
                      icon: Icon(Icons.chat),
                      onPressed: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                chatUserId: user.uid!, // Access uid through the user instance
                                todoItemId: snapshot.data!.docs[index].id,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(
                                chatUserId: user.uid!, // Access uid through the user instance
                                todoItemId: snapshot.data!.docs[index].id,
                              ),
                            ),
                          );
                        }
                      },
                      color: AppColor.primary,
                    ),
                    // IconButton(
                    //   icon: Icon(Icons.check_box),
                    //   onPressed: () => updateTodoItemStatus(index),
                    //   color: AppColor.primary,
                    // ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
