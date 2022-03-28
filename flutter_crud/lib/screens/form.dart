import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/screens/list.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'home.dart';

class MyForm extends StatefulWidget {
  final User user;
  const MyForm({Key? key, required this.user}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

Future save(user) async {
  if (user.id == 0) {
    await http.post(Uri.parse('http://localhost:8000'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': user.name,
          'email': user.email,
          'password': user.password,
        }));
  } else {
    await http.put(Uri.parse('http://localhost:8000/' + user.id.toString()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': user.name,
          'email': user.email,
          'password': user.password,
        }));
  }
}

Future delete(id) async {
  await http.delete(Uri.parse('http://localhost:8000/' + id));
}

class _MyFormState extends State<MyForm> {
  //
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _visibility = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      idController.text = widget.user.id.toString();
      nameController.text = widget.user.name;
      emailController.text = widget.user.email;
      passwordController.text = widget.user.password;

      if (widget.user.id != 0) _visibility = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: false,
            child: TextFormField(
              controller: idController,
              decoration: InputDecoration(
                  hintText: 'Enter id',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: 'Enter Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: 'Enter Email',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
                hintText: 'Enter Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              //
              await save(User(
                  id: int.parse(idController.text),
                  name: nameController.text,
                  email: emailController.text,
                  password: passwordController.text));

              print(nameController.text);

              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Home(
                        index: 0,
                        widgetName: MyList(),
                      );
                    },
                  ),
                );
              });
            },
            child: const Text('Submit'),
          ),
          const SizedBox(height: 15),
          Visibility(
            visible: _visibility,
            child: ElevatedButton(
              onPressed: () async {
                //
                await delete(idController.text);

                print(nameController.text);

                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Home(
                          index: 0,
                          widgetName: MyList(),
                        );
                      },
                    ),
                  );
                });
              },
              child: const Text('Delete'),
            ),
          ),
        ],
      )),
    );
  }
}
