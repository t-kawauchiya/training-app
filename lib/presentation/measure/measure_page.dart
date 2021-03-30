import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeasurePage extends StatelessWidget {
  Widget build(BuildContext context) {
    // var titleController = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            // autofocus: false,
            // decoration: InputDecoration(
            //   hintText: 'title',
            // ),
            // controller: titleController,
            onChanged: (text) {
              //model.history.title = text;
            },
          ),
        ],
      ),
    );
  }
}
