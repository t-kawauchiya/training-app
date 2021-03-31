import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/domain/history.dart';

class WorkoutModel extends ChangeNotifier {
  @override
  WorkoutModel(String uid) {
    this._uid = uid;
    this.history = History.init();
  }
  var _uid = '';
  var history;

  Future addHistory() async {
    CollectionReference histories = FirebaseFirestore.instance
        .collection('users')
        .doc(_uid)
        .collection('histories');
    if (history.title.isEmpty) {
      throw ('titleを入力してください');
    }
    histories
        .add(
          history.toMap(),
        )
        .then((value) => print("History added"))
        .catchError(
          (error) => print("Failed to add history: $error"),
        );
  }
}
