import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_app/common_func.dart';
import 'package:training_app/presentation/history/history_model.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class HistoryAddPage extends StatelessWidget {
  late final _uid;
  @override
  HistoryAddPage(uid) {
    this._uid = uid;
  }
  final formatter = new DateFormat('yyyy/MM/dd(E) HH:mm');

  Widget build(BuildContext context) {
    var titleController = TextEditingController();
    return ChangeNotifierProvider<HistoryModel>(
      create: (_) => HistoryModel(_uid),
      child: Scaffold(
        appBar: AppBar(
          title: Text('add work history'),
        ),
        body: Consumer<HistoryModel>(
          builder: (context, model, child) {
            return Column(
              children: <Widget>[
                TextField(
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'title',
                  ),
                  controller: titleController,
                  onChanged: (text) {
                    model.history.title = text;
                  },
                ),
                Row(
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
                ElevatedButton(
                  child: Text('追加'),
                  onPressed: () async {
                    try {
                      await model.addHistory();
                      await CommonFunc.cShowDialog(context, '追加しました');
                      Navigator.pop(context);
                    } catch (e) {
                      CommonFunc.cShowDialog(context, e.toString());
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
