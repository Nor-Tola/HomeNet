import 'package:flutter/material.dart';

Widget cardWidget1(int number, String name, Color colors) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 2, color: colors),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$number',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
          Text(name),
        ],
      ),
    ),
  );
}

Widget cardWidget2(int number, String name, String icon, Color colors) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 2, color: colors),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            icon,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
          Text(
            '$number',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
          Text(name),
        ],
      ),
    ),
  );
}
