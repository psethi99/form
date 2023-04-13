import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';


class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _retrieveUsers();
  }

  Future<void> _retrieveUsers() async {
    // Open the database
    final database = openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );

    // Retrieve all user records from the table
    final List<Map<String, dynamic>> users = await (await database).query('users');

    setState(() {
      _users = users;
    });
  }

  Future<void> _deleteUser(int id) async {
    // Open the database
    final database = openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      version: 1,
    );

    // Delete the user record from the table
    await (await database).delete('users', where: 'id = ?', whereArgs: [id]);

    // Retrieve the updated user records from the table
    await _retrieveUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          final firstName = user['first_name'];
          final lastName = user['last_name'];
          final email = user['email'];
          final mobileNumber = user['mobile_number'];
          final dateTime = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.parse(user['date_time']));

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$firstName $lastName', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                      Text('Email: $email'),
                      Text('Mobile Number: $mobileNumber'),
                      Text('Date Time: $dateTime'),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Navigate to the edit user page
                    // You can pass the user ID as a parameter if necessary
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => EditUserPage()));
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => _deleteUser(user['id']),
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

