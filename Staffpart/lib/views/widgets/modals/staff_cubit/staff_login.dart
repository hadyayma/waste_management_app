import 'package:Staff/views/screens/home_todo.dart';
import 'package:Staff/views/utils/AppColor.dart';
import 'package:Staff/views/widgets/custom_text_field.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'staff_login_cubit.dart';
import 'staff_login_states.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var staffEmailController = TextEditingController();
  var staffPasswordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isPassword = true;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SLoginCubit(),
        child: BlocConsumer<SLoginCubit, StaffLoginStates>(
          listener: (context, state) {
            if (state is SLoginErrorState) {
              Fluttertoast.showToast(
                  msg: state.error,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 60.0,
                            ),
                            child: Image(
                              image: AssetImage('assets/images/k.png'),
                              height: 300.0,
                              width: 300.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 70.0,
                          ),
                          CustomTextField(
                            obscureText: false,
                            color: AppColor.primarySoft,
                            prefix: Icons.email,
                            title: 'Email',
                            hint: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            controller: staffEmailController,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          CustomTextField(
                            obscureText: isPassword,
                            color: AppColor.primarySoft,
                            prefix: Icons.lock,
                            title: 'Password',
                            hint: 'Enter your password',
                            keyboardType: TextInputType.visiblePassword,
                            controller: staffPasswordController,
                            margin: EdgeInsets.only(top: 16),
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                            suffix: isPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            suffixPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                          ),
                          SizedBox(height: 16.0),
                          Container(
                            margin: EdgeInsets.only(top: 32, bottom: 6),
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: ConditionalBuilder(
                              condition: state is! SLoginLoadingState,
                              builder: (context) => ElevatedButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    formkey.currentState?.save();
                                    try {
                                      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(
                                        EmailAuthProvider.credential(
                                          email: staffEmailController.text,
                                          password: staffPasswordController.text,
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                      var snapshot; // Define and initialize your snapshot variable
                                      var index;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => OptionScreen(),
                                        ),
                                      );
                                      Fluttertoast.showToast(
                                        msg: 'Login Successfully',
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: AppColor.primarySoft,
                                        textColor: AppColor.whiteSoft,
                                        fontSize: 16.0,
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        Fluttertoast.showToast(
                                          msg: 'No user found for that email.',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        print('No user found for that email.');
                                      } else if (e.code == 'wrong-password') {
                                        Fluttertoast.showToast(
                                          msg: 'Wrong password please try again!',
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                        print('Wrong password provided for that user.');
                                      }
                                    }
                                  }
                                },
                                child: Text('Login',
                                    style: TextStyle(
                                        color: AppColor.secondary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'inter')),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  primary: AppColor.primarySoft,
                                ),
                              ),
                              fallback: (context) => Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.primary,
                                  backgroundColor: AppColor.primaryExtraSoft,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
