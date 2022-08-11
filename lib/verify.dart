import 'dart:async';

import 'package:blood_donation/usage_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class Verifyit extends StatefulWidget {
  const Verifyit({ Key? key }) : super(key: key);

  @override
  State<Verifyit> createState() => _VerifyitState();
}

class _VerifyitState extends State<Verifyit> {
  
  final _auth = FirebaseAuth.instance;
  User? user ;
  Timer? timer;
  AlertDialog? alert;
  @override
  void initState() {
    user = _auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
     });
    alert =  AlertDialog(
    title: const Text("Verify Email"),
    content: Text("An email has been sent to ${user!.email}, please verify"),
    
  );
    super.initState();
  }
  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: alert,
    );
  }

  Future<void> checkEmailVerified() async{
    user = _auth.currentUser;
    await user!.reload();
    if(user!.emailVerified){
      timer!.cancel();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: ((context) => const Usage())));
    }
  }
}