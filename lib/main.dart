import 'package:flutter/material.dart';
import 'package:motor_engine_displacement_calculator/pages/Addmotor.dart';
import 'package:motor_engine_displacement_calculator/pages/Dashboard.dart';
import 'package:motor_engine_displacement_calculator/pages/ListItems.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Listitems(),
      '/add': (context) => Addmotor()
    },
  ));
}