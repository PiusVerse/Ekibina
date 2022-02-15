import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eSacco/custom_button.dart';
import 'package:eSacco/register_kibiina.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/SaccoInfo/sacco_info.dart';
import 'data/SaccoInfo/save_sacco_info.dart';

Color borderColor = Colors.white;

var kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: borderColor, width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

class EnrollMembers extends StatefulWidget {
  const EnrollMembers({Key? key}) : super(key: key);

  @override
  _EnrollMembersState createState() => _EnrollMembersState();
}

class _EnrollMembersState extends State<EnrollMembers> {
  bool isEnabled = true;
  var _count = 1;
  var members = List.filled(reqMembers,
      ''); //Required members[reqMembers] is from register_kibiina route
  TextEditingController membController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _currUserNin = '';

  @override
  Widget build(BuildContext context) {
    SaccoInfoDao saccoInfoDao =
        Provider.of<SaccoInfoDao>(context, listen: false);
    print(members);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 49, 76),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30.0),
          ),
          const Text(
            'You are automatically added to groups you create as:',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
              fontSize: 16.0,
            ),
          ),
          const Text(
            'member number 1.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
              fontSize: 16.0,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              'Enter NINs of each member:',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          Expanded(child: ListView(children: fieldTemplate())),
          Center(
            child: RoundedButton(
                colour: Colors.purpleAccent,
                title: ('Register ' + reqMembers.toString() + ' members'),
                onPressed: () {
                  saveSaccoInfo(saccoInfoDao);
                  Navigator.pushNamed(context, 'choose_kibiina');
                }),
          )
        ],
      ),
    );
  }

  void saveSaccoInfo(SaccoInfoDao saccoInfoDao) {
    final info = SaccoInfo(
        saccoName: saccoName,
        location: location,
        noOfMembers: reqMembers,
        year: yearOfEst,
        memberNINs: members);
    print('saved sacco info');
    saccoInfoDao.updateInfo(info, saccoName);
  }

  getNIN() async {
    final uid = _auth.currentUser?.uid;
    CollectionReference collection =
        FirebaseFirestore.instance.collection('Profile Info');
    DocumentSnapshot userProfSnapshot = await collection.doc(uid).get();
    _currUserNin = userProfSnapshot.get('nin');
    members[0] = _currUserNin;
    return userProfSnapshot.get('nin');
  }

  List<Widget> fieldTemplate() {
    List<Widget> mRegWidget = [];

    for (int i = 1; i < reqMembers; i++) {
      mRegWidget.add(Container(
          padding: const EdgeInsets.only(top: 10),
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
            ),
            enabled: isEnabled,
            decoration: kTextFieldDecoration.copyWith(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                hintText:
                    'Enter member number ' + (i + 1).toString() + '\'s NIN.'),
            onChanged: (value) {
              if (value.toString().length != 14) {
                setState(() {
                  borderColor = Colors.red;
                });
              } else {
                setState(() {
                  borderColor = Colors.green;
                });
              }

              print('controller is' + value + 'i is ' + i.toString());
              members[i] = value;
            },
          )));
    }
    return mRegWidget;
  }
}
