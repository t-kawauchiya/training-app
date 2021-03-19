import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/profile_page.dart';
import 'package:training_app/workout_page.dart';

import 'exercise_page.dart';
import 'history_page.dart';
import 'measure_page.dart';

class AppPage extends StatefulWidget {
  AppPage({Key? key, title}) : super(key: key);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _currentIndex = 0;
  String uid = '';

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _pageList = <Widget>[
    ProfilePage(),
    HistoryPage(),
    WorkoutPage(),
    ExercisePage(),
    MeasurePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              color: Colors.black54,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time,
              color: Colors.black54,
            ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_outlined,
              color: Colors.black54,
            ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
              color: Colors.black54,
            ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.business,
              color: Colors.black54,
            ),
            label: 'Business',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
