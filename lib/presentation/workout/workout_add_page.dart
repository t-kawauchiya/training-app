import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/common_func.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import 'workout_model.dart';

class WorkoutAddPage extends StatelessWidget {
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final formatter = new DateFormat('yyyy/MM/dd(E) HH:mm');

  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    var eventController = TextEditingController();
    var weightController = TextEditingController();
    var repsController = TextEditingController();
    return ChangeNotifierProvider<WorkoutModel>(
      create: (_) => WorkoutModel(_uid),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Let`s Workout!'),
        ),
        body: Consumer<WorkoutModel>(
          builder: (context, model, child) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'title',
                        ),
                        controller: titleController,
                        onChanged: (text) {
                          model.history.title = text;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'date: ' + formatter.format(model.history.date),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(
                                context,
                                showTitleActions: true,
                                onChanged: (date) {
                                  print('change $date');
                                },
                                onConfirm: (date) {
                                  model.history.date = date;
                                },
                                // Datepickerのデフォルトで表示する日時
                                currentTime: DateTime.now(),
                                // localによって色々な言語に対応
                                //  locale: LocaleType.en
                              );
                            },
                            child: Icon(Icons.access_time),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 300,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'workout event',
                              ),
                              controller: eventController,
                              onChanged: (text) {
                                model.history.exercises[0].event.name = text;
                              },
                            ),
                          ),
                          Row(children: [
                            SizedBox(
                              width: 150,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'weight',
                                ),
                                controller: weightController,
                                onChanged: (text) {
                                  model.history.exercises[0].works[0].weight =
                                      int.parse(text);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'reps',
                                ),
                                controller: repsController,
                                onChanged: (text) {
                                  model.history.exercises[0].works[0].reps =
                                      int.parse(text);
                                },
                              ),
                            ),
                          ])
                        ],
                      ),
                      ElevatedButton(
                        child: Text('finish!!'),
                        onPressed: () async {
                          try {
                            await model.addHistory();
                            await CommonFunc.cShowDialog(context, '記録しました');
                            Navigator.pop(context);
                          } catch (e) {
                            CommonFunc.cShowDialog(context, e.toString());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
