import 'package:cloud_firestore/cloud_firestore.dart';

class Work {
  int weight = 0;
  int reps = 0;

  DocumentReference? reference;

  @override
  Work(int weight, int reps) {
    this.weight = weight;
    this.reps = reps;
  }

  Work.init();

  Work.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['weight'] != null),
        assert(map['reps'] != null),
        weight = map['weight'],
        reps = map['reps'];

  Work.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data()!, reference: snapshot.reference);

  Map<String, dynamic> toMap() {
    return {
      'weight': this.weight,
      'reps': this.reps,
    };
  }
}
