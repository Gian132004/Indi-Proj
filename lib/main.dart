import 'package:flutter/material.dart';
import 'package:motor_engine_displacement_calculator/WorldTime/pages/home.dart';
import 'package:motor_engine_displacement_calculator/WorldTime/pages/choose_location.dart';
import 'package:motor_engine_displacement_calculator/WorldTime/pages/loading.dart';
import 'package:motor_engine_displacement_calculator/pages/Addmotor.dart';
import 'package:motor_engine_displacement_calculator/pages/Dashboard.dart';
import 'package:motor_engine_displacement_calculator/pages/ListItems.dart';
import 'package:motor_engine_displacement_calculator/WorldTime/services/world_time.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/loading',
    routes: {
      '/': (context) => Listitems(),
      '/add': (context) => Addmotor(),
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    },
  ));
}