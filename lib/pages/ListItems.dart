import 'package:flutter/material.dart';
import 'package:motor_engine_displacement_calculator/pages/Calcu.dart';
import 'package:motor_engine_displacement_calculator/pages/Itemcard.dart';

class Listitems extends StatefulWidget {
  const Listitems({super.key});

  @override
  State<Listitems> createState() => _ListitemsState();
}

class _ListitemsState extends State<Listitems> {
  List<Calcu> calculator = [
    Calcu(name: 'gian', type: '1', bone: 6.0),
    Calcu(name: 'nico', type: '2', bone: 100.0),
    Calcu(name: 'lai', type: '3', bone: 7.0),
    Calcu(name: 'si', type: '4', bone: 8.0),
    Calcu(name: 'nag', type: '5', bone: 9.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue,
            padding: const EdgeInsets.all(20),
            child: const Text(
              'BROOM_BROOM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: const Text(
              'Testing',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView(
              children: calculator.map((calcus) {
                return Itemcard(calculator: calcus);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}