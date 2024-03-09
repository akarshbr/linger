import 'package:flutter/material.dart';

import '../../controller/sql_helper.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  void getAllUsers() async {
    var usersFromDB = await SQLFunction.getALLUsers();
    setState(() {
      users = usersFromDB;
    });
  }

  void deleteUser(int id) async {
    await SQLFunction.deleteUser(id);
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Admin Panel", style: TextStyle(color: Colors.purple)),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return Container(
              height: 77,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.all(Radius.circular(5))),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    "${users[index]["id"]}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text("Name: ${users[index]["name"]}"),
                subtitle: Text("Email: ${users[index]["email"]}"),
                trailing: IconButton(
                    onPressed: () {
                      deleteUser(users[index]["id"]);
                    },
                    icon: Icon(Icons.delete)),
              ),
            );
          }),
    );
  }
}
