// import 'package:Staff/views/utils/AppColor.dart';
// import 'package:flutter/material.dart';
//
// import 'staff_splash/staff_splash_screen.dart';
// import 'welcome_page.dart';
//
// class AskScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Zero Waste',
//           style: TextStyle(
//             fontSize: 20.0,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       extendBodyBehindAppBar: true,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xff9ad559),
//               Color(0xff5ec465),
//             ],
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               child: Image.asset(
//                 'assets/images/z.png',
//                 width: 200,
//                 height: 200,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 30),
//
//               child: Text(
//                 'Are you a Staff or a User?',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 30,
//                   color: AppColor.primaryExtraSoft,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             SizedBox(height: 40),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigate to the staff page
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => OnBoardingScreen()),
//                         );
//                       },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                           AppColor.primaryExtraSoft,
//                         ),
//                         foregroundColor: MaterialStateProperty.all(
//                           Colors.black,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Text(
//                           'Staff',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Navigate to the user page
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => WelcomePage()),
//                         );
//                       },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                           AppColor.primaryExtraSoft,
//                         ),
//                         foregroundColor: MaterialStateProperty.all(
//                           Colors.black,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: Text(
//                           'User',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
