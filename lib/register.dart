import 'package:blood_donation/database/add_user_info.dart';
// import 'package:blood_donation/home.dart';
// import 'package:blood_donation/usage_page.dart';
import 'package:blood_donation/verify.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _namecontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  // final _bgcontroller = TextEditingController();

  List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String selectedGroup = 'O+';
  List<String> yesno = ['Yes', 'No'];
  String choice = 'No';

  List<bool> checks = [false, false, false, false];
  String bloodgroup = "";
  List<String> diseases = [
    'Unexplained Weight Loss', 'Repeared Diarrhoea', 'Swollen Glands',
    'Continuous Low-Grade Fever'
  ];

  final _auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 215, 215),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: sz.height * .15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Registration',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: sz.height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: sz.width * .8,
                      child: TextField(
                        controller: _namecontroller,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1.3),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          label: const Text('Donor\'s Name'),
                          hintText: 'Your name',
                          errorText: _namecontroller.text.isEmpty == true
                              ? 'Required field'
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sz.height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: sz.width * .8,
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                label: const Text('Age'),
                                hintText: 'Age',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: sz.width * .03,
                          ),
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                label: const Text('Gender'),
                                hintText: 'Male',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: sz.width * .8,
                      child: TextField(
                        controller: _emailcontroller,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1.3),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          label: const Text('Email'),
                          hintText: 'abc@email.com',
                          errorText: _emailcontroller.text.isEmpty == true
                              ? 'Required field'
                              : null,
                        ),
                      ),
                    ),
                  ),
      
                  SizedBox(
                    height: sz.height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: sz.width * .8,
                      child: TextField(
                        controller: _passcontroller,
                        obscureText: true,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1.3),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          label: const Text('Password'),
                          hintText: 'Create a password',
                          errorText: _passcontroller.text.isEmpty == true
                              ? 'Required field'
                              : null,
                        ),
                      ),
                    ),
                  ),
      
                  SizedBox(
                    height: sz.height * .02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: sz.width * .8,
                      child: const Text(
                        'Blood Group',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1.3),
                      ),
                    ),
                  ),
      
                  Container(
                    width: sz.width * .8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: selectedGroup,
                          onChanged: (newValue) {
                            setState(() {
                              selectedGroup = newValue.toString();
                              bloodgroup = selectedGroup;
                            });
                          },
                          iconSize: 40,
                          items: bloodGroups.map((bg) {
                            return DropdownMenuItem(
                              child: Text(bg),
                              value: bg,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 21, 215, 215),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
      
                  SizedBox(
                    height: sz.height * .02,
                  ),
      
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    // ignore: sized_box_for_whitespace
                    child: Text(
                      'Have you donated previously',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          letterSpacing: 1.3),
                    ),
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: choice,
                      onChanged: (newValue) {
                        setState(() {
                          choice = newValue.toString();
                        });
                      },
                      iconSize: 40,
                      items: yesno.map((bg) {
                        return DropdownMenuItem(
                          child: Text(bg),
                          value: bg,
                        );
                      }).toList(),
                    ),
                  ),
      
                  SizedBox(height: sz.height*.02,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: sz.width * .8,
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                label: const Text('Haemoglobin count'),
                                hintText: 'in grams',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          SizedBox(
                            width: sz.width * .03,
                          ),
                          Flexible(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                label: const Text('Weight'),
                                hintText: 'in kg',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
      
                  SizedBox(height: sz.height*.02,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // ignore: sized_box_for_whitespace
                    child: Container(
                      width: sz.width * .8,
                      child: const Text(
                        'In the last 6 Months have you had any history of the following:',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            letterSpacing: 1.3),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(diseases[index]),
                          trailing: Checkbox(
                             onChanged: (value) {
                              setState(() {
                                checks[index] = !checks[index];
                              });
                            },
                            value: checks[index],
                          ),
                        );
                      }),
                    ),
                  ),
      
                  SizedBox(
                    height: sz.height * .065,
                  ),
      
                  //ignore: sized_box_for_whitespace
                  Container(
                    height: sz.height * 0.055,
                    width: sz.width * .5,
                    child: ElevatedButton(
                      onPressed: () {
                        signUp(
                            _emailcontroller.text.trim(),
                            _passcontroller.text.trim(),
                            bloodgroup);
                      },
                      child: const Text(
                        'Proceed',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sz.height * .2,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  signUp(String _email, String _password, String _bgroup) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      user = _auth.currentUser;

      user!.updateDisplayName(_namecontroller.text.trim());

      await UpdateUser(user!.uid).updateuserdata(_namecontroller.text.trim(),
          _emailcontroller.text.trim(), _bgroup);
      await UpdateUser(user!.uid).updateAllocation();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => const Verifyit())));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error signing up $e", gravity: ToastGravity.TOP);
    }
  }
}
