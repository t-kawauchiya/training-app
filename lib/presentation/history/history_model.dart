import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/domain/history.dart';

class HistoryModel extends ChangeNotifier {
  @override
  HistoryModel(String uid) {
    this._uid = uid;
  }
  var _uid = '';
  var history = History('', DateTime.now());

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
          {
            'title': history.title,
            'date': history.date,
          },
        )
        .then((value) => print("History added"))
        .catchError(
          (error) => print("Failed to add history: $error"),
        );
  }
}
