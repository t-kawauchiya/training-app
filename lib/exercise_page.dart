import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExercisePage'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ExercisePage'),
          ],
        ),
      ),
    );
  }
}
