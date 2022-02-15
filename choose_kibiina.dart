// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eSacco/data/ProfileInfo/save_profile_info.dart';
import 'package:eSacco/custom_button.dart';
import 'package:eSacco/data/SaccoInfo/save_sacco_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var currSacco = '';

class ChooseKibiina extends StatefulWidget {
  const ChooseKibiina({Key? key}) : super(key: key);

  @override
  _ChooseKibiinaState createState() => _ChooseKibiinaState();
}

/*Widget widgetTemplate() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      ElevatedButton(
          onPressed: () {},
          child: Row(
            children: <Widget>[
              Text(
                'group number one',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          )),
    ],
  );
}*/

class _ChooseKibiinaState extends State<ChooseKibiina> {
  int subscribedSaccos = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  List<String> groupName = [];

  checkSubsciption(
      ProfileInfoDao profileInfoDao, SaccoInfoDao saccoInfoDao) async {
    String? uid = await _auth.currentUser?.uid;

    DocumentSnapshot userSnapshot =
        await profileInfoDao.collection.doc(uid).get();
    var currentUserNIN = userSnapshot.get('nin');
    try {
      await saccoInfoDao.collection
          .where('memberNINs', arrayContains: currentUserNIN)
          .get()
          .then((value) {
        subscribedSaccos = value.docs.length;
        int i = 0;
        groupName = List.filled(subscribedSaccos, '');
        print(subscribedSaccos);
        value.docs.forEach((element) {
          try {
            print('inside.........................................');
            groupName[i] = element.get('saccoName');
            i++;
            print(groupName);
          } catch (e) {
            print(e);
          }
        });
        i = 0; //reset counter.
      });
    } catch (error) {
      return Text('Error retrieving document:' + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var dWidth = MediaQuery.of(context).size.width;
    var dHeight = MediaQuery.of(context).size.height;
    final profileInfoDao = Provider.of<ProfileInfoDao>(context, listen: false);
    final saccoInfoDao = Provider.of<SaccoInfoDao>(context, listen: false);
    checkSubsciption(profileInfoDao, saccoInfoDao);

    return Scaffold(
        appBar: AppBar(
          title: Text('Affiliated Groups'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    groupName;
                  });
                  print('Groups list is' + groupName.toString());
                },
                icon: Icon(Icons.refresh_rounded)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'register_kibiina');
          },
          backgroundColor: Colors.purple,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 49, 76),
        body: Builder(builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10.0)),
              Text(
                'Groups you are a part of:',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: subscribedSaccos,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                            onPressed: () {
                              currSacco = groupName[index];
                              Navigator.pushNamed(context, 'home_screen');
                            },
                            child: Row(
                              children: <Widget>[
                                Text(
                                  groupName[index],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ));
                      })),
            ],
          );
        }));
  } //build

}//Class
