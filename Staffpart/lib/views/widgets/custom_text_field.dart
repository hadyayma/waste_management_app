import 'package:Staff/views/utils/AppColor.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String title;
  final String hint;
  final TextEditingController? controller;
  final IconData? prefix;
  final IconData? suffix;
  final TextInputType? keyboardType;
  final Color? color;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  Function()? suffixPressed;
  final Function(String)? validate;

  CustomTextField({
    required this.title,
    required this.hint,
    this.validate,
    this.keyboardType,
    this.prefix,
    this.color,
    this.suffix,
    this.controller,
    this.obscureText = false,
    this.padding,
    this.margin,
    this.suffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              '$title',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(color: AppColor.primaryExtraSoft, borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              style: TextStyle(fontSize: 14),
              cursorColor: AppColor.primary,
              obscureText: obscureText,
              decoration: InputDecoration(
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
                hintText: '$hint',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                contentPadding: EdgeInsets.only(left: 16),
                border: InputBorder.none,
              ),
              validator: (value) {
                return validate! (value!);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildInfoRow(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
    ],
  );
}
