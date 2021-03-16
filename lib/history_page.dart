import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryPage extends StatelessWidget {
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    return Scaffold(
      appBar: AppBar(
        title: Text('HistoryPage'),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('histories').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> documents) {
    return ListView(
      children: documents
          .map(
            (doc) => Card(
              child: ListTile(
                title: Text(doc['title']),
                subtitle: Text(timeago.format(doc['date'].toDate())),
              ),
            ),
          )
          .toList(),
    );
  }
}
