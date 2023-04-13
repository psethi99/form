import 'package:flutter/material.dart';
import 'user_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Form',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Form sqlite'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
          child: UserForm(),
        ),
      ),
    );
  }
}
