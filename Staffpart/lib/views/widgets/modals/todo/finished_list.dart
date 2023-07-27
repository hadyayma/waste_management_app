import 'package:Staff/views/utils/AppColor.dart';
import 'package:Staff/views/widgets/modals/todo/todo_Screen_modal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FinishedListScreen extends StatelessWidget {

  void updateTodoItemStatus(int index) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('requests')
        .where('Aactivation', isEqualTo: false)
        .where('ServeceStatus', isEqualTo: 'Door To Door')
        .get();

    if (snapshot.docs.length > index) {
      DocumentReference docRef = snapshot.docs[index].reference;
      try {
        await docRef.update({'Aactivation': true});
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
          .where('Aactivation', isEqualTo: false)
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
            return ListTile(
              title: Text(todoItems[index].Name),
              subtitle: Text('Time: ${todoItems[index].datePublished}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // IconButton(
                  //   icon: Icon(Icons.restart_alt),
                  //   onPressed: () => updateTodoItemStatus(index),
                  //   color: AppColor.primary,
                  //),
                ],
              ),
            );
          },
        );
      },
    );
  }
}