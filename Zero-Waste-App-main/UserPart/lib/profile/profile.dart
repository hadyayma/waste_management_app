import 'package:flutter/material.dart';
import 'package:zeros/profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:  SafeArea(child: Body()),
    );
  }
}
