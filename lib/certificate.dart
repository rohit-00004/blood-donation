// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blood_donation/database/add_user_info.dart';

class Certificate extends StatefulWidget {
  const Certificate({Key? key}) : super(key: key);

  @override
  State<Certificate> createState() => _CertificateState();
}

class _CertificateState extends State<Certificate> {
  bool valid = false;

  Future<bool> futuredata  = Future.value(false);
  @override
  void initState() {
    futuredata = UpdateUser('t').checkStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sz = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          child: Image.asset(
            'assets/thanks.png',
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sz.height * .15,
            ),
            Row(
              children: [
                SizedBox(
                  width: sz.width * .15,
                ),
                ElevatedButton(
                  onPressed: () {
                  showStatus(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Download Certificate',
                        style: TextStyle(fontSize: 20),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.download,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 255, 58, 58),
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget showStatus(context) {
    return FutureBuilder(
        future: UpdateUser('t').checkStatus(),
        builder: (context, snapshot) {

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            
            default:
            // print(snapshot.data.toString());
              if (snapshot.hasData) {
                // print('has data');
                // print("data: ${snapshot.data.toString()}");
                if(snapshot.data == true){
                  // print("Added");
                }
                else{
                  // print("Not yet approved");
                }
                return Center(child: Text(snapshot.data.toString()));
              } 
              else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
        }
          
        });
  }
}
