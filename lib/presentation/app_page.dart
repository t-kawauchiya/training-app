import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profile/profile_page.dart';
import 'workout/workout_page.dart';
import 'exercise/exercise_page.dart';
import 'history/history_page.dart';
import 'measure/measure_page.dart';

class AppPage extends StatefulWidget {
  final String uid;
  AppPage(this.uid);

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  int _currentIndex = 0;
  String _uid = '';

  void _onItemTapped(int index) {
    setState(() {
      _uid = widget.uid;
      _currentIndex = index;
    });
  }

  List<Widget> buildPageList() {
    return <Widget>[
      ProfilePage(),
      HistoryPage(_uid),
      WorkoutPage(),
      ExercisePage(),
      MeasurePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pageList = buildPageList();
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
