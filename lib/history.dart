import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String title;
  final Timestamp date;
  final DocumentReference? reference;

  History.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['date'] != null),
        title = map['title'],
        date = map['date'];

  History.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data()!, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$date>";
}
