import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

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
              child: Column(
                children: [
                  ListTile(
                    title: Text(doc['title']),
                    subtitle: Text(timeago.format(doc['date'].toDate())),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
