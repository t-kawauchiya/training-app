import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/domain/exercise.dart';

class History {
  String title = '';
  DateTime date = DateTime.now();
  List<Exercise> exercises = [Exercise.init()];
  DocumentReference? reference;

  @override
  History(String title, DateTime date, List<Exercise> exercises) {
    this.title = title;
    this.date = date;
    this.exercises = exercises;
  }

  History.init();

  History.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['date'] != null),
        title = map['title'],
        date = map['date'].toDate(),
        exercises = (map['exercises'] as List<Map<String, dynamic>>)
            .map((exercise) => Exercise.fromMap(exercise))
            .toList();

  History.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data()!, reference: snapshot.reference);

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'date': Timestamp.fromDate(this.date),
      'exercises': this.exercises.map((e) => e.toMap()).toList(),
    };
  }

  @override
  String toString() => "Record<$title:$date>";
}
