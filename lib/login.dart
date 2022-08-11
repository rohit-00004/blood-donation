import 'package:blood_donation/admin.dart';
import 'package:blood_donation/usage_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  final String person;
  const Login({Key? key, required this.person}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _emailcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
  var touse = widget.person;
    var sz = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
          child: Container(
        height: sz.height*.9,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/logo1.jpg',
          ),
          opacity: .6,
          fit: BoxFit.cover,
        )
            // borderRadius: BorderRadius.circular(8),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sz.height * .1,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: sz.width * .1),
              width: sz.width * .8,
              child: TextField(
                controller: _emailcontroller,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.3),
                decoration: InputDecoration(
                  hintText: 'email',
                  label: const Text('Registered email'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: sz.height * .05,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: sz.width * .1),
              width: sz.width * .8,
              child: TextField(
                obscureText: true,
                controller: _passcontroller,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.3),
                decoration: InputDecoration(
                  hintText: 'password',
                  label: const Text('Password'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: sz.height * .2,
            ),
            SizedBox(
              height: sz.height * 0.055,
              width: sz.width * .5,
              child: ElevatedButton(
                onPressed: () {
                  signIn(touse, _emailcontroller.text.trim(),
                      _passcontroller.text.trim());
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 245, 60, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
    // );
  }

  signIn(String person, String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      //Navigator.of(context).popUntil((route) => route.isFirst);

      if(person == 'Admin'){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Admin()));
      }
      else{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const Usage()));
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error signing in $e");
    }
  }
}
