// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_page_application/main.dart';
import 'package:profile_page_application/models/Account.dart';

class EditProfile extends StatefulWidget {
  String user = 'pius';
  EditProfileName(String userFile) {
    user = userFile;
  }

  //Profile(user);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late String _searchName;

  // ignore: non_constant_identifier_names

  TextEditingController displayNameController = TextEditingController();
  TextEditingController occuController = TextEditingController();
  TextEditingController birthController = TextEditingController();
  bool isLoading = false;
  bool _occValid = true;
  bool _usernameValid = true;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
  }

  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            ' Username',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextField(
          onChanged: (String val) => _searchName = val,
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: 'Update Username',
            errorText: _usernameValid ? null : 'Name too short',
          ),
        )
      ],
    );
  }

  Column buildBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            ' Date of Birth',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextField(
          controller: birthController,
          decoration: InputDecoration(
            hintText: 'DD/MM/YY',
          ),
        )
      ],
    );
  }

  Column buildOccuNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            'Occupation Name',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextField(
          controller: occuController,
          decoration: InputDecoration(
            hintText: 'Update Occupation',
            errorText: _occValid ? null : 'too much description',
          ),
        )
      ],
    );
  }

//String username = displayNameController.text;
  updateProfileData() {
    Box db = Hive.box("profile");
    db.put('name', displayNameController.text);
    db.put('work', occuController.text);
    db.put('dob', birthController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${displayNameController.text} added successfully"),
      ),
    );
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Profile()));
  }

  Future pickImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    PickedFile? picked =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (picked == null) {
      return;
    }
    setState(() {
      image = picked as File?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.done,
                size: 30.0,
                color: Colors.green,
              ))
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: CircleAvatar(
                      child: Stack(children: [
                        //   image != null
                        // ? Image.file(image!)
                        //  : Image.asset("assets/splash.jpg"),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.white70,
                            child: IconButton(
                              onPressed: pickImage,
                              iconSize: 20,
                              icon: Icon(Icons.photo_camera),
                            ),
                          ),
                        ),
                      ]),
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                ),
                buildDisplayNameField(),
                buildOccuNameField(),
                buildBirthField(),
              ],
            ),
          ),
          ElevatedButton(
              onPressed: updateProfileData,
              child: Text(
                'Update Profile',
                style: TextStyle(
                  backgroundColor: Colors.blue,
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }
}
