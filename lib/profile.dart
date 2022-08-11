import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), backgroundColor: Colors.red,),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:const [
              //adding image
              CircleAvatar(
              radius: 80.0,
              backgroundImage:
                  NetworkImage('https://via.placeholder.com/150'),
              backgroundColor: Colors.transparent,
              )
            ],),
          ),
            const Divider(thickness: 1, color: Colors.black,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Name', style: TextStyle(fontFamily: 'RaleWay', fontSize: 20),),
                  SizedBox(width: sz.width*.3,),
                  Flexible(child: Text('${_auth.currentUser!.displayName}', style: const TextStyle(fontFamily: 'Raleway', fontSize: 20),)),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Row(
                children: [
                  const Text('E-mail', style: TextStyle(fontFamily: 'RaleWay', fontSize: 20, ),),
                  SizedBox(width: sz.width*.1,),
                  Flexible(child: Text('${_auth.currentUser!.email}', style: const TextStyle(fontFamily: 'Raleway', fontSize: 18, fontWeight: FontWeight.w400),)),
                ],
              ),
            ),

        ]),
      ),
    );   
  }
}