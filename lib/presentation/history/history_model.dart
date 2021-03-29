import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/domain/history.dart';

class HistoryModel extends ChangeNotifier {
  final uid = '';
  var history = History('', DateTime.now());
  CollectionReference histories =
      FirebaseFirestore.instance.collection('history');

  Future addHistory() async {
    if (history.title.isEmpty) {
      throw ('titleを入力してください');
    }
    return histories
        .add(
          {
            'title': history.title,
            'date': history.date,
          },
        )
        .then((value) => print("History added"))
        .catchError((error) => print("Failed to add history: $error"));
  }
}
