import 'package:blood_donation/certificate.dart';
import 'package:blood_donation/database/add_user_info.dart';
import 'package:blood_donation/guidelines.dart';
import 'package:blood_donation/home.dart';
import 'package:blood_donation/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Usage extends StatefulWidget {
  const Usage({Key? key}) : super(key: key);

  @override
  State<Usage> createState() => _UsageState();
}

class _UsageState extends State<Usage> {
  final _auth = FirebaseAuth.instance;
  String? userName = "";

  late Future<String> allTime, allBed;

  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      userName = _auth.currentUser!.displayName;
    }

    allTime = UpdateUser(_auth.currentUser!.uid).allotedTime();
    allBed = UpdateUser(_auth.currentUser!.uid).allotedBed();
  }

  int currIdx = 0;
  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    final tabs = [
      LoginPage(sz: sz, userName: userName, allTime: allTime, allBed: allBed),
      const Certificate()
    ];
    return Scaffold(
      drawer: SafeArea(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: sz.width * .7,
          child: Drawer(
            child: Material(
              color: Colors.red[400],
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(
                              Icons.account_box_sharp,
                              size: 30,
                            ),
                            title: const Text(
                              'Your profile',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            iconColor: Colors.white,
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const Profile())));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const Icon(
                              Icons.rule_sharp,
                              size: 30,
                            ),
                            title: const Text(
                              'Before donation',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            iconColor: Colors.white,
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: ((context) => const Guidelines())));
                            },
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 2,
                          height: 0,
                        ),
                      ],
                    ),
                    Expanded(
                      // take all available size and start from end(main-axis-align)
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: const Icon(
                                Icons.logout,
                                size: 30,
                              ),
                              title: const Text(
                                'Sign Out',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              iconColor: Colors.white,
                              onTap: () {
                                signOut(context);
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Donate for cause'),
        backgroundColor: (Colors.red),
      ),


      body: tabs[currIdx],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currIdx,
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.white54,
        showSelectedLabels: true,
        unselectedFontSize: 14,
        backgroundColor: Colors.red,
        onTap: (idx) => setState(() => currIdx = idx),
        // changing screen on tap

        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card),
            label: 'Certificate',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      // push with replacement
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => const Home())));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    required this.sz,
    required this.userName,
    required this.allTime,
    required this.allBed,
  }) : super(key: key);

  final Size sz;
  final String? userName;
  final Future<String> allTime;
  final Future<String> allBed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 130,
            right: 1,
            left: 1,
            child: Image.asset('assets/donation.png'),
          ),
          Column(
            children: [
              Column(
                children: [
                  Container(
                    // height: sz.height * .4,
                    child: Column(
                      children: [
                        SizedBox(
                          height: sz.height * .03,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () => {},
                              child: Container(
                                width: sz.width * .8,
                                // height: sz.height * .2,
                                child: Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Hello,",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      Text(
                                        userName!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 83, 144, 250),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: sz.height * .03,
                            ),
                          ],
                        )
                      ],
                    ),
                    width: sz.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      // borderRadius: BorderRadius.all(Radius.circular(50)),
                      // color: Color.fromARGB(255, 225, 17, 17),
                    ),
                  ),
                  SizedBox(
                    height: sz.height * .3,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: sz.height * .1),
                    padding: const EdgeInsets.all(15),
                    width: sz.width * .8,
                    // height: sz.height*.2,
                    child: Column(
                      children: [
                        const Text(
                          'Your alloted time slot:',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '25/07/2022 at',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        FutureBuilder(
                            future: allTime,
                            builder: ((context, snapshot) {
                              switch (snapshot.connectionState) {
                                default:
                                  if (snapshot.hasData) {
                                    return Text('${snapshot.data}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold));
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                              }
                            })),
                        FutureBuilder(
                            future: allBed,
                            builder: ((context, snapshot) {
                              switch (snapshot.connectionState) {
                                default:
                                  if (snapshot.hasData) {
                                    return Text('Bed number- ${snapshot.data}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold));
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                              }
                            })),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      // backgroundBlendMode:
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30.0)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(6, 1.0), //(x,y)
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
