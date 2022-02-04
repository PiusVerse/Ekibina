import './editProfile.dart';
import 'dart:html';
import 'package:flutter/material.dart';

//import 'package:fluttershare/widgets/header.dart';
void main() {
  runApp(Profile());
}

class Profile extends StatefulWidget {
  String userID = 'pius';
  @override
  MyProfile createState() => MyProfile();
}

class MyProfile extends State<Profile> {
  var username = 'Usernmae';
  var myBirthday = 'DATE-of-Birth';
  buildCountColumn(String label, count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  //editProfile() {
  // var userId = 'pius';
  //Navigator.push(context,
  //  MaterialPageRoute(builder: (context) => EditProfile(user: userId)));
  //}

  Container buildButton({required String word}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8.0),
      // ignore: deprecated_member_use
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfile('pius')),
          );
        },
        child: Container(
          width: 250.0,
          height: 27.0,
          child: Text(
            word,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }

  buildProfileButton() {
    return buildButton(
      word: 'Edit Profile',
    );
  }

  buildProfileHeader() {
    return FutureBuilder(
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey,
                    // backgroundImage: CachedNetworkImageProvider(user.photoUrl),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildCountColumn('Days in', 0),
                              buildCountColumn('Days Remaining', 0),
                              buildCountColumn('Debt Status', 0),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildProfileButton(),
                            ],
                          )
                        ],
                      ))
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 12.0),
                child: Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  myBirthday,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 2.0),
                child: Text('Occupation'),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: <Widget>[buildProfileHeader()],
      ),
    ));
  }

  circularProgress() {}
}
