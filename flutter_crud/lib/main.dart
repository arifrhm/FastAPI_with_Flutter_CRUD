import 'package:flutter/material.dart';
import 'package:flutter_crud/screens/list.dart';

import 'screens/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Home(widgetName: MyList(), index: 0),
    );
  }
}
