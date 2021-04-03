import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training_app/domain/work.dart';

import 'work_event.dart';

class Exercise {
  WorkEvent event = WorkEvent.init();
  List<Work> works = [Work.init()];
  DocumentReference? reference;

  @override
  Exercise(WorkEvent event, List<Work> works) {
    this.event = event;
    this.works = works;
  }

  Exercise.init() {
    this.event = WorkEvent.init();
    this.works = List.generate(10, (i) => Work.init());
  }

  Exercise.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['event'] != null),
        assert(map['works'] != null),
        event = WorkEvent(
          map['event'],
        ), //WorkEvent.fromMap(map['event']),
        works = (map['works'] as List<dynamic>)
            .map((work) => Work.fromMap(work))
            .toList();

  Exercise.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data()!, reference: snapshot.reference);

  Map<String, dynamic> toMap() {
    return {
      'event': this.event.toString(),
      'works': this.works.map((e) => e.toMap()).toList(),
    };
  }
}
