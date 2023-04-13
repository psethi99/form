import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqlite_app/Users/users_list.dart';
import 'Users/users_list.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileNumberController = TextEditingController();

  Future<void> _submitForm() async {
    // Open the database
    final database = openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        // Create the user table
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, mobile_number TEXT, date_time TEXT)',
        );
      },
      version: 1,
    );

    // Insert the user data into the table
    final user = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'email': _emailController.text,
      'mobile_number': _mobileNumberController.text,
      'date_time': DateTime.now().toString(),
    };
    await (await database).insert('users', user);

    // Clear the form
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _mobileNumberController.clear();
  }

  Future<void> _showAllRecords() async {
    // Open the database
    final database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );

    // Get all the user records from the table
    final List<Map<String, dynamic>> users = await (await database).query('users');

    // Show a dialog with the user records
    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('All Records'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: users.map((user) {
                return Text(
                  'ID: ${user['id']}\nFirst Name: ${user['first_name']}\nLast Name: ${user['last_name']}\nEmail: ${user['email']}\nMobile Number: ${user['mobile_number']}\nDate Time: ${user['date_time']}',
                  style: const TextStyle(fontSize: 16.0),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Form(
        //child: Padding(
          //padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                            ),
          ),
          SizedBox(height: 16.0),
          TextFormField(
            controller: _mobileNumberController,
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Submit'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed:() {
              Navigator.push(context, MaterialPageRoute(builder:(context) => UserListPage()),
          );},
            child: Text('Show all records'),
          ),
        ],
      ),
      ),
    //),
    //);
  );}
}


