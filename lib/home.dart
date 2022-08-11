// import 'package:blood_donation/Admin.dart';
import 'package:blood_donation/database/add_user_info.dart';
import 'package:blood_donation/login.dart';
import 'package:blood_donation/register.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currIdx = 0, cnt = 0;


  @override
  void initState() {
    UpdateUser('t').listNums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate for cause'),
        backgroundColor: (Colors.red),
        automaticallyImplyLeading: false, // to remove the back arrow of last page
      ),

      body: SingleChildScrollView(
        child: HomePage(sz: sz),
      ),


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
            icon: Icon(Icons.list),
            label: 'About',
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.sz,
  }) : super(key: key);

  final Size sz;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(top:300, right: 1, left: 2, child: Image.asset('assets/home1.jpg')),
        Column(
        children: [
          Container(
            height: sz.height * .4,
            child: Column(
              children: [
                SizedBox(
                  height: sz.height * .03,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const Register())),
                      child: Container(
                        width: sz.width*.8 ,
                        height: sz.height * .15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "Register\nYourself",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset('assets/register.png', height: 100, )),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 83, 144, 250),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(height: sz.height*.02,),
                    FutureBuilder(
                      future: UpdateUser('t').listNums(),
                      builder: (context, snapshot) {
                        switch(snapshot.connectionState){
                          
                          default:
                            if(snapshot.hasError){
                              return const Text('Error');
                            }
                            else if(snapshot.hasData){
                              return Container(
                                  width: sz.width*.8 ,
                                  height: sz.height * .15,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Text(
                                          "Total\nregistrations ${snapshot.data}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ),
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset('assets/count.jpg', height: 100, )
                                      ),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.purple),
                                    color: Colors.purple,
                                    // color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                            }
                            else {
                              return const CircularProgressIndicator();
                            }
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
            ),
          ),
          SizedBox(
            height: sz.height * .3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already registered?',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: ((context) => const Login(person: 'user')))))
                ],
              ),
              TextButton(
                child:
                    const Text('Admin login', style: TextStyle(fontSize: 15)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const Login(person: 'Admin',))));
                },
              ),
            ],
          )
        ],
      ),
      ],
    );
  }
}
