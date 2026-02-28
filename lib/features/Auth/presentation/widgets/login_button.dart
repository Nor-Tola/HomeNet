import 'package:flutter/material.dart';

Widget loginButton(BuildContext context, String name, Color color, Color textColor, Widget page) {
  return Center(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 50, vertical: 10)
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
      }, child: Text(name, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 23, color: textColor),)),
  );
}
