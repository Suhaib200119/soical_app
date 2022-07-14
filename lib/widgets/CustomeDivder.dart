import 'package:flutter/material.dart';

Widget CustomeDivder({required double height,required Color color}){
  return Container(
    margin: EdgeInsets.all(10),
    width: double.infinity,
    height: height,
    color: color,
  );
}