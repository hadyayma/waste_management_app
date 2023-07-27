import 'package:Staff/views/utils/AppColor.dart';
import 'package:Staff/views/widgets/modals/Profile/profile_screen.dart';
import 'package:Staff/views/widgets/modals/todo/todo_Screen.dart';
import 'package:flutter/material.dart';

class OptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text('Options'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 200.0, height: 200.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColor.primaryExtraSoft),
                    shape: MaterialStateProperty.all(
                      CircleBorder(eccentricity: 0.5),
                    ),
                    foregroundColor: MaterialStateProperty.all(AppColor.primary),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()), // Pass staffId here
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 60.0),
                      SizedBox(height: 10.0),
                      Text(
                        'Profile',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 200.0, height: 200.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(AppColor.primaryExtraSoft),
                    shape: MaterialStateProperty.all(
                      CircleBorder(eccentricity: 0.5),
                    ),
                    foregroundColor: MaterialStateProperty.all(AppColor.primary),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TodoScreen()),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.list_alt_outlined, size: 60.0),
                      SizedBox(height: 10.0),
                      Text(
                        'Todo List',
                        style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
