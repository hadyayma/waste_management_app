import 'package:Staff/views/screens/auth/staff_splash/staff_splash_screen.dart';
import 'package:Staff/views/utils/bloc_observer.dart';
import 'package:Staff/views/utils/remote/dio_helper.dart';
import 'package:Staff/views/widgets/modals/Profile/staff_profile_modal.dart';
import 'package:Staff/views/widgets/modals/chat/user_chat.dart';
import 'package:Staff/views/widgets/modals/staff_cubit/staff_login.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Initialize other services
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<Staff?> staff = Future.value(Staff());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Open Sans',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light().copyWith(
          // Modify the bouncing color here
          secondary: Colors.green,
        ),
      ),
      routes: {
        '/login': (context) => LoginScreen(),
      },
      home: SplashScreen(),
    );
  }
}
