import 'package:blood_donation/database/add_user_info.dart';
import 'package:blood_donation/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Usertile extends StatefulWidget {
  const Usertile({Key? key}) : super(key: key);

  @override
  State<Usertile> createState() => _UsertileState();
}

class _UsertileState extends State<Usertile> {
  Set<String> userEmails = {};

                                         
  List<bool> checks = [];

  @override
  void initState(){
    for(int i=0; i<100; i++){
      checks.add(false);
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserMod>>(context);
    var sz = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(
                  users[index].name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  users[index].email,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                trailing: Checkbox(
                  onChanged: (value) {
                    setState(() {
                      checks[index] = !checks[index];
                    });
                  },
                  value: checks[index],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: sz.width * .7, bottom: 10),
          child: FloatingActionButton(
            onPressed: () {
              UpdateUser us = UpdateUser('t');
              
              for(int i=0; i<100; i++){
                if(checks[i] == true){
                  us.updateDonatedList(users[i].email);
                }
              }

            },
            backgroundColor: Colors.red,
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}
