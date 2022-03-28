import 'package:flutter/material.dart';

import '../models/user.dart';
import 'form.dart';
import 'list.dart';

class Home extends StatefulWidget {
  final Widget widgetName;
  final index;
  const Home({Key? key, required this.widgetName, required this.index})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget _currentWidget = MyList();
  var _titles = ['List', 'Form'];
  var _widgets = [
    const MyList(),
    MyForm(
      user: User(id: 0, name: '', email: '', password: ''),
    )
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentWidget = widget.widgetName;
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      body: _currentWidget,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.table_chart), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Form'),
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            _currentWidget = _widgets[_currentIndex];
          });
        },
      ),
    );
  }
}
