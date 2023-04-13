import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<Map<String, dynamic>>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _getUsers();
  }

  Future<List<Map<String, dynamic>>> _getUsers() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE TABLE UsersInfo(UserId INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT)",
        );
      },
      version: 1,
    );

    return await database.query('UsersInfo');
  }

  Future<void> _deleteUser(int userId) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
    );

    await database.delete(
      'UsersInfo',
      where: 'UserId = ?',
      whereArgs: [userId],
    );

    setState(() {
      _usersFuture = _getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data;

            return ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                  title: Text('${user['first_name']} ${user['last_name']}'),
                  subtitle: Text(user['email']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteUser(user['UserId']);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
