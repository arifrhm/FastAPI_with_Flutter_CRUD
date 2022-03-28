import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/screens/form.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'home.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

Future fetch_users() async {
  var response = await http.get(Uri.parse('http://localhost:8000'));

  var users = [];

  for (var u in jsonDecode(response.body)) {
    users.add(User(
        id: u['id'],
        name: u['name'],
        email: u['email'],
        password: u['password']));
  }

  print(users);

  return users;
}

class _MyListState extends State<MyList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch_users();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetch_users(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator();
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data[index].name),
                subtitle: Text(snapshot.data[index].email),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Home(
                          index: 1,
                          widgetName: MyForm(
                            user: snapshot.data[index],
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
