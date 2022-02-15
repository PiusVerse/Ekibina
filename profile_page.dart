import 'package:hive_flutter/hive_flutter.dart';
import 'Account.dart';

import './edit_profile.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  String username = 'pius';
  // _Profile({required this.username});
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

  Container buildButton(String word, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8.0),
      // ignore: deprecated_member_use
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            'edit_profile',
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

  buildProfileButton(BuildContext context) {
    return buildButton('Edit Profile', context);
  }

  buildProfileHeader() {
    Box store = Hive.box('profile');
    return FutureBuilder(
      // future: usersRef,
      builder: (context, snapshot) {
        String userID = username;
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
                              //buildCountColumn('Days in', 0),
                              buildCountColumn('Days Remaining', 0),
                              buildCountColumn('Debt Status', 0),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
              store.isNotEmpty
                  ? Card(
                      child: ListTile(
                        title: Text(store.get('name')),
                        subtitle: Text(store.get('dob')),
                        trailing: Text(store.get('work')),
                      ),
                    )
                  : Text("No data"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildProfileButton(context),
                ],
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
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[buildProfileHeader()],
      ),
    ));
  }
}
