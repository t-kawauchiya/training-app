import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String title;
  final Timestamp createdAt;
  final DocumentReference? reference;

  User.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['date'] != null),
        title = map['title'],
        createdAt = map['createdAt'];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data()!, reference: snapshot.reference);

  @override
  String toString() => "Record<$title:$createdAt>";
}
