import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Engine CC Calculator', style: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red
      ),
      body: Center(
          child: Column( mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children:  [ Text('Alam mo ha!!!', style: TextStyle(color: Colors.white ,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            fontStyle: FontStyle.italic,
            background: Paint()
            .. style = PaintingStyle.fill
            .. color = Colors.red
        )), Text('Alam mo ha!!!', style: TextStyle(color: Colors.white ,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            fontStyle: FontStyle.italic,
            background: Paint()
              .. style = PaintingStyle.fill
              .. color = Colors.red
        )), Text('Alam mo ha!!!', style: TextStyle(color: Colors.white ,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            fontStyle: FontStyle.italic,
            background: Paint()
              .. style = PaintingStyle.fill
              .. color = Colors.red
        )),
        ]
          ),
      ),
    ),
  ));
}

