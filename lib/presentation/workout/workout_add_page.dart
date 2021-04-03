import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/common_func.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:training_app/domain/exercise.dart';
import 'package:training_app/domain/work.dart';

import 'workout_model.dart';

class WorkoutAddPage extends StatelessWidget {
  final _uid = FirebaseAuth.instance.currentUser!.uid;
  final workoutModel = WorkoutModel(FirebaseAuth.instance.currentUser!.uid);
  final formatter = new DateFormat('yyyy/MM/dd(E) HH:mm');
  final eventControllers =
      List.generate(10, (index) => TextEditingController());
  final weightControllers =
      List.generate(10, (index) => TextEditingController());
  final repsControllers = List.generate(10, (index) => TextEditingController());

  Widget build(BuildContext context) {
    var titleController = TextEditingController();
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
                      _buildEventList(model, context, model.history.exercises),
                      TextButton(
                        onPressed: () {
                          model.showMoreExercise();
                        },
                        child: Text('add event'),
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

  Widget _buildEventList(
      WorkoutModel model, BuildContext context, List<Exercise> exercises) {
    List<Widget> widgets = [];
    for (int i = 0; i < model.visibleExerciseIndex; i++) {
      widgets.add(_buildEvent(model, context, i));
    }

    return Column(
      children: widgets,
    );
  }

  Widget _buildEvent(
      WorkoutModel model, BuildContext context, int exerciseIndex) {
    return Visibility(
      visible: model.visibleExerciseIndex > exerciseIndex,
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'event',
              ),
              controller: eventControllers[exerciseIndex],
              onChanged: (text) {
                model.history.exercises[exerciseIndex].event.name = text;
                print(eventControllers[exerciseIndex].toString());
              },
            ),
          ),
          Column(
            children: model.history.exercises[exerciseIndex].works
                .sublist(0, model.workVisibleIndex[exerciseIndex])
                .map((work) => _buildWorks(work))
                .toList(),
          ),
          TextButton(
            onPressed: () {
              model.showMoreWork(exerciseIndex);
            },
            child: Text('add work'),
          ),
        ],
      ),
    );
  }

  Widget _buildWorks(Work work) {
    var weightController = new TextEditingController();
    var repsController = new TextEditingController();
    return Row(
      children: [
        SizedBox(
          width: 150,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'weight',
            ),
            controller: weightController,
            onChanged: (text) {
              work.weight = int.parse(text);
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
              work.reps = int.parse(text);
            },
          ),
        ),
      ],
    );
  }
}
