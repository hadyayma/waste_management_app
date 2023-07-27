//import 'dart:ffi';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.greenAccent,
  bool isUpperCase = true,
  double radius = 10.0,
  required Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20.0,
          ),
        ),
      ),
    );

// decoration: BoxDecoration(
//   borderRadius: BorderRadiusDirectional.only(
//     topStart: Radius.elliptical(10, 10),
//     bottomStart: Radius.elliptical(10, 10),
//     bottomEnd: Radius.elliptical(10, 10),
//     topEnd: Radius.elliptical(10, 10),
//   ),
// ),
// clipBehavior: Clip.antiAliasWithSaveLayer,

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefix,
  required Color color,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      cursorColor: Colors.lightGreen,
      obscureText: isPassword,
      decoration: InputDecoration(
        fillColor: Colors.lightGreen,
        hoverColor: Colors.lightGreen,
        labelText: label,
        prefixIcon: Icon(
          prefix,
          color: color,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
            color: color,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
      keyboardType: type,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: (value) {
        return validate(value);
      },
    );
//
// Widget buildTaskItem(Map model, context) => Dismissible(
//   key: Key(model['id'].toString()),
//   child:   Padding(
//     padding: const EdgeInsets.all(20.0),
//
//     child: Row(
//
//       children: [
//
//         CircleAvatar(
//
//           radius: 50.0,
//
//           child: Text(''),
//
//           backgroundColor: Colors.lightGreen,
//
//         ),
//
//         SizedBox(
//
//           width: 20.0,
//
//         ),
//
//         Expanded(
//
//           child: Column(
//
//             mainAxisSize: MainAxisSize.min,
//
//             crossAxisAlignment: CrossAxisAlignment.start,
//
//             children: [
//
//               Text(
//
//                 '${model['Name']}',
//
//                 style: TextStyle(
//
//                   fontSize: 18.0,
//
//                   fontWeight: FontWeight.bold,
//
//                   //color: Colors.white,
//
//                 ),
//
//               ),
//
//               SizedBox(
//
//                 height: 5.0,
//
//               ),
//
//               Text(
//
//                 '${model['Phone']}',
//
//                 style: TextStyle(
//
//                   color: Colors.grey,
//
//                 ),
//
//               ),
//
//               Text(
//
//                 '${model['Birthdate']}',
//
//                 style: TextStyle(
//
//                   color: Colors.grey,
//
//                   fontWeight: FontWeight.bold,
//
//                 ),
//
//               ),
//
//             ],
//
//           ),
//
//         ),
//
//         SizedBox(
//
//           width: 20.0,
//
//         ),
//
//         IconButton(
//
//           onPressed: () {
//
//             AppCubit.get(context).updateData(
//
//               status: 'Done',
//
//               id: model['id'],
//
//             );
//
//           },
//
//           icon: Icon(
//
//             Icons.check_box,
//
//             color: Colors.lightGreen,
//
//           ),
//
//         ),
//
//         IconButton(
//
//           onPressed: () {
//
//             AppCubit.get(context).updateData(
//
//               status: 'Archived',
//
//               id: model['id'],
//
//             );
//
//           },
//
//           icon: Icon(
//
//             Icons.archive,
//
//             color: Colors.black54,
//
//           ),
//
//         ),
//
//       ],
//
//     ),
//
//   ),
//   onDismissed: (direction)
//   {
//     AppCubit.get(context).deleteData(id: model['id'],);
//   },
// );

// Widget tasksBuilder({
//   @required List<Map> tasks,
// }) => ConditionalBuilder(
//   condition: tasks.isNotEmpty,
//   builder: (context)=>ListView.separated(
//     itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
//     separatorBuilder: (context, index) => MyDivider(),
//     itemCount: tasks.length,
//   ),
//   fallback: (context) => Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.menu,
//           size: 100,
//           color: Colors.grey,
//         ),
//         Text(
//           'No Data yet, Please add data',
//           style: TextStyle(
//             fontSize: 16.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     ),
//   ),
// );

Widget MyDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

// Widget buildTaskItem(Map model, context) => Dismissible(
//   key: Key(model['id'].toString()),
//   child:   Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Row(
//       children: [
//         CircleAvatar(
//
//           radius: 50.0,
//
//           child: Text(''),
//
//           backgroundColor: Colors.lightGreen,
//
//         ),
//         SizedBox(
//
//           width: 20.0,
//
//         ),
//         Expanded(
//
//           child: Column(
//
//             mainAxisSize: MainAxisSize.min,
//
//             crossAxisAlignment: CrossAxisAlignment.start,
//
//             children: [
//
//               Text(
//
//                 '${model['Name']}',
//
//                 style: TextStyle(
//
//                   fontSize: 18.0,
//
//                   fontWeight: FontWeight.bold,
//
//                   //color: Colors.white,
//
//                 ),
//
//               ),
//
//               SizedBox(
//
//                 height: 5.0,
//
//               ),
//
//               Text(
//
//                 '${model['Phone']}',
//
//                 style: TextStyle(
//
//                   color: Colors.grey,
//
//                 ),
//
//               ),
//
//               Text(
//
//                 '${model['Birthdate']}',
//
//                 style: TextStyle(
//
//                   color: Colors.grey,
//
//                   fontWeight: FontWeight.bold,
//
//                 ),
//
//               ),
//
//             ],
//
//           ),
//
//         ),
//         SizedBox(
//
//           width: 20.0,
//
//         ),
//         IconButton(
//
//           onPressed: () {
//
//             AppCubit.get(context).updateData(
//
//               status: 'Done',
//
//               id: model['id'],
//
//             );
//
//           },
//
//           icon: Icon(
//
//             Icons.check_box,
//
//             color: Colors.lightGreen,
//
//           ),
//
//         ),
//         IconButton(
//
//           onPressed: () {
//
//             AppCubit.get(context).updateData(
//
//               status: 'Archived',
//
//               id: model['id'],
//
//             );
//
//           },
//
//           icon: Icon(
//
//             Icons.archive,
//
//             color: Colors.black54,
//
//           ),
//
//         ),
//       ],
//     ),
//   ),
//   onDismissed: (direction)
//   {
//     AppCubit.get(context).deleteData(id: model['id'],);
//   },
// );
// Widget tasksBuilder({
//   required List<Map> tasks,
// }) => ConditionalBuilder(
//   condition: tasks.isNotEmpty,
//   builder: (context)=>ListView.separated(
//     itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
//     separatorBuilder: (context, index) => MyDivider(),
//     itemCount: tasks.length,
//   ),
//   fallback: (context) => Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(
//           Icons.menu,
//           size: 100,
//           color: Colors.grey,
//         ),
//         Text(
//           'No Data yet, Please add data',
//           style: TextStyle(
//             fontSize: 16.0,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     ),
//   ),
// );

Widget buildArticleItem(article) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0,),
          image: DecorationImage(
            image: NetworkImage('${article['urlToImage']}'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);
Widget articleBuilder(list) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated (
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index]),
    separatorBuilder: (context, index) => MyDivider(),
    itemCount: 10,
  ),
  fallback: (context) => Center(
    child: CircularProgressIndicator(),
  ),
);
