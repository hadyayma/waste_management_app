import 'package:Staff/views/utils/AppColor.dart';
import 'package:Staff/views/widgets/modals/todo/current_list.dart';
import 'package:Staff/views/widgets/modals/todo/finished_list.dart';
import 'package:Staff/views/widgets/modals/todo/waste_collection_list.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreensState createState() => _TodoScreensState();
}

class _TodoScreensState extends State<TodoScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          'Todo List',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to the previous screen
          },
        ),
      ),
      body: _buildScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        fixedColor: AppColor.primary,
        selectedFontSize: 14,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.delete_forever,
            ),
            label: 'Waste Collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
            ),
            label: 'Current Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Finished Requests',
          ),
        ],
      ),
    );
  }

  Widget _buildScreen() {
    if (_currentIndex == 0) {
      return WasteCollectionListScreen();
    } else if (_currentIndex == 1) {
      return CurrentListScreen();
    }else if (_currentIndex == 2) {
      return FinishedListScreen();
    }
    return Container();
  }
}
