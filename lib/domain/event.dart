import 'package:cloud_firestore/cloud_firestore.dart';

class WorkEvent {
  String name = '';
  DocumentReference? reference;

  @override
  WorkEvent(String name, DateTime date) {
    this.name = name;
  }

  WorkEvent.init();

  WorkEvent.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'];

  WorkEvent.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data()!, reference: snapshot.reference);

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
    };
  }

  @override
  String toString() {
    return this.name;
  }
}
