import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeasurePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MeasurePage'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('MeasurePage'),
          ],
        ),
      ),
    );
  }
}
