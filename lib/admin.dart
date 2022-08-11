import 'package:blood_donation/database/add_user_info.dart';
import 'package:blood_donation/usermodel.dart';
import 'package:blood_donation/users_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserMod>>.value(
        initialData: const [],
        value: UpdateUser('t').users,
        child: MaterialApp(
            home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Admin page'),
              backgroundColor: Colors.red,
              bottom: const TabBar(tabs: [
                Tab(
                    child: Text(
                  'Approve users',
                  style: TextStyle(fontSize: 16),
                )),
                Tab(
                  child: Text(
                    'Donated users',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ]),
            ),
            body: const Usertile(),
          ),
        )));
  }
}
