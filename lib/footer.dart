import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_app/history_page.dart';

import 'profile_page.dart';
import 'main.dart';

class Footer extends StatefulWidget {
  const Footer();

  @override
  _Footer createState() => _Footer();
}

class _Footer extends State<Footer> {
  void _onItemTapped(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => _pageList[index]),
    );
  }

  List<Widget> _pageList = <Widget>[
    MyHomePage(),
    ProfilePage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
        ),
      ],
      onTap: _onItemTapped,
    );
  }
}
