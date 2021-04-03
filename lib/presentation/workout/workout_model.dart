import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:training_app/domain/exercise.dart';
import 'package:training_app/domain/history.dart';
import 'package:training_app/domain/work.dart';

class WorkoutModel extends ChangeNotifier {
  @override
  WorkoutModel(String uid) {
    this._uid = uid;
  }
  String _uid = '';
  final History history = History.init();
  var visibleExerciseIndex = 1;
  var workVisibleIndex = List.filled(10, 1);
  static const maxExerciseVisibleIndex = 10;
  static const maxWorkVisibleIndex = 10;

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

  void showMoreExercise() {
    if (visibleExerciseIndex < maxExerciseVisibleIndex) {
      visibleExerciseIndex += 1;
      notifyListeners();
    }
  }

  void showMoreWork(int index) {
    if (workVisibleIndex[index] < maxWorkVisibleIndex) {
      workVisibleIndex[index] += 1;
      notifyListeners();
    }
  }

  void addExercise(Exercise exercise) {
    history.exercises.add(exercise);
    notifyListeners();
  }

  void addWork(int index, Work work) {
    history.exercises[index].works.add(work);
    notifyListeners();
  }
}
