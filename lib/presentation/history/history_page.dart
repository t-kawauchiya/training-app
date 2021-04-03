import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:training_app/domain/history.dart';

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

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshots) {
    var _histories = snapshots.map((e) => History.fromMap(e.data()!)).toList();
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: _histories
          .map(
            (_history) => Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(_history.title),
                    subtitle: Text(timeago.format(_history.date)),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: (_history.exercises)
                            .map((e) => Text(e.event.toString()))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
