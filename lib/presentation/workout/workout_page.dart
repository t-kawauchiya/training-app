import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkoutPage'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('WorkoutPage'),
          ],
        ),
      ),
    );
  }
}
