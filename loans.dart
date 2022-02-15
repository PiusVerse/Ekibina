import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eSacco/choose_kibiina.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'custom_button.dart';

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
        BorderSide(color: Color.fromARGB(255, 51, 153, 255), width: 3.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
int noOfFields = 0; //Fields to be used in member registration form.
var saccoName = '', location = '', yearOfEst = '';

class Loans extends StatefulWidget {
  const Loans({Key? key}) : super(key: key);

  @override
  _LoansState createState() => _LoansState();
}

class _LoansState extends State<Loans> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  late TextEditingController saccoNameController,
      locationController,
      _ninController;
  Color? buttonColor = Color.fromARGB(255, 28, 49, 76);
  Color okayColor = Colors.white;
  Color confPasswordColor = Colors.white;
  String _selectedIncome = '----';

  @override
  void initState() {
    super.initState();
    saccoNameController = TextEditingController();
    locationController = TextEditingController();
    _ninController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 49, 76),
        appBar: AppBar(
            title: Text(
          'Loan Application',
        )),
        body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Scaffold(
              backgroundColor: Color.fromARGB(255, 28, 49, 76),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Text(
                    'Confirm your NIN to receive Loan Application Form.',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                      controller: _ninController,
                      onChanged: (value) {
                        if (value.toString().length == 14) {
                          setState(() {
                            buttonColor = Colors.red;
                          });
                        } else {
                          setState(() {
                            buttonColor = Colors.green;
                          });
                        }
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Enter your NIN.')),
                  RoundedButton(
                      colour: buttonColor,
                      title: 'Send Loan Application Form',
                      onPressed: () async {
                        if (_ninController.text.length == 14) {
                          setState(() {
                            showSpinner = true;
                          });

                          if ((_ninController.text == checkUserEmail())) {
                            List loanApprovals = [];
                            CollectionReference saccoRef = FirebaseFirestore
                                .instance
                                .collection('Sacco Info');
                            await saccoRef.doc(currSacco).get().then((value) {
                              loanApprovals = value.get('loanApprovals');
                            });

                            loanApprovals.add(_ninController.text);

                            await saccoRef.doc(currSacco).set(
                                {'loanApprovals': loanApprovals},
                                SetOptions(merge: true));

                            //TODO:add userNIN to pending loan approval list.
                          }
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'NIN must be 14 characters long.',
                                  )));
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      })
                ],
              ),
            )));
  }

  checkUserEmail() async {
    var uid = await FirebaseAuth.instance.currentUser!.uid;
    try {
      var collection = FirebaseFirestore.instance.collection('Profile Info');

      await collection.doc(uid).get().then((value) {
        return value.get('nin');
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Error retrieving credentials',
          )));
    }
  }
}
