import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'history_add_page.dart';

class HistoryPage extends StatelessWidget {
  final String _uid;
  @override
  HistoryPage(this._uid);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HistoryPage'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryAddPage(_uid)),
          );
        },
        tooltip: 'add work histories',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .collection('histories')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return Column(
          children: [
            _buildList(context, snapshot.data!.docs),
          ],
        );
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> histories) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: histories
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
