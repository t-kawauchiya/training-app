import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  late String title;
  late DateTime date;
  DocumentReference? reference;

  @override
  History(String title, DateTime date) {
    this.title = title;
    this.date = date;
  }

  History.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['date'] != null),
        title = map['title'],
        date = map['date'].toDate();

  History.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data()!, reference: snapshot.reference);

  Map<String, dynamic> toMap() {
    return {
      'title': this.title,
      'date': Timestamp.fromDate(this.date),
    };
  }

  @override
  String toString() => "Record<$title:$date>";
}
