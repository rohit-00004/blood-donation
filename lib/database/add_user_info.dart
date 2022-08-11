import 'package:blood_donation/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class UpdateUser{
  String usid;
  UpdateUser(this.usid); //

  CollectionReference user = FirebaseFirestore.instance.collection('users');
  Future updateuserdata(String name, String email, String bgroup) async{
    try{
    await user.doc(usid).set(
      { 
        'Name': name,
        'Email': email,
        'Bgroup' : bgroup 
      }
    );
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

  List<UserMod> _userlistfromSnapshots(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return UserMod(
      name: doc['Name'], 
      email: doc['Email'], 
      bgroup: doc['Bgroup'],
      );
    }).toList();
  }

  // get users 
  Stream<List<UserMod>> get users => user.snapshots().map((event) => _userlistfromSnapshots(event));


  CollectionReference donatedColl = FirebaseFirestore.instance.collection('Donated list');

  Future<int> listNums() async{
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users").get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData.length;
  }

  Future updateAllocation() async{
    try{
    int hrs = 0, mins = 0, bed = 0;
    int n = await listNums();
    if(n <= 120){
      hrs = 10 + (n ~/60);
      mins = (n ~/ 20) * 20;
    }
    else if(n > 120 && n <= 360){
      hrs = 1 + (n ~/60);
      mins = (n ~/ 20) * 20;
    }  
     if(n % 20 == 0){
      bed = 20;
    }
    else{
      bed = (n-1) % 20;
    }
    String tmp = "";
    tmp += hrs.toString();
    tmp += ":";
    if(mins ~/ 10 == 0){
      tmp += "0";
    }
    tmp += mins.toString();
    if(n <= 120){
      tmp += " AM";
    }
    else{
      tmp += " PM";
    }
    await user.doc(usid).update(
      { 
        'Time': tmp,
        'Bed' : bed,
      }
    );
    }catch(e){
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

  Future<String> allotedTime() async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(usid).get();
    
    return doc['Time'];
  }

  Future<String> allotedBed() async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(usid).get();
    
    return doc['Bed'].toString();
  }

  Future updateDonatedList(String email) async{
    try{
    await donatedColl.doc().set({
      'Email' : email
      }
    );
    Fluttertoast.showToast(msg: 'User added successfully!', gravity: ToastGravity.TOP);
    }
    catch(e){
      Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }


 Future<bool> checkStatus() async{
  final _auth = FirebaseAuth.instance;
  bool valid = false;

  QuerySnapshot qs = await FirebaseFirestore.instance.collection('Donated list').get();

  List list = qs.docs.map((doc) => doc.data() ).toList();
  // print(list);

  for(var v in list){
    if(v['Email'] == _auth.currentUser!.email){
      valid = true;
    }
  }
  
  // print('valid: $valid');
    return valid;
    // FirebaseFirestore.instance
    //     .collection('Donated list')
    //     .get()
    //     .then((QuerySnapshot snapshot) {
    //   snapshot.docs.forEach((doc) {
    //     if(doc['Email'] == _auth.currentUser!.email){
    //       ok = true;
    //       setState(() {
    //       valid = true;
    //       });
    //     }
    //   }
    //   );  
    //   if(!ok){
    //         valid = false;
    //   }
    // });

 }

}