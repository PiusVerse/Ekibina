import 'dart:async';

import 'package:eSacco/custom_button.dart';
import 'package:eSacco/login_screen.dart';
import 'package:eSacco/setup_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 5),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload;

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified = true) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 10));
      setState(() => canResendEmail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email send verification error')));
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? SetupProfile()
      : Scaffold(
          appBar: AppBar(title: Text('Verify email')),
          backgroundColor: Color.fromARGB(255, 28, 49, 76),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'A verification email has been sent to your email.',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Center(
                child: RoundedButton(
                  onPressed: () {
                    /*if (canResendEmail = true)*/ {
                      sendVerificationEmail();
                    }
                  },
                  title: 'Resend Email',
                  colour: Colors.blue,
                  sColor: Colors.white54,
                ),
              ),
              Center(
                  child: TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: Row(
                  children: [
                    Icon(Icons.email),
                    Text(
                      'Cancel',
                      style: TextStyle(fontSize: 20.0, color: Colors.blue),
                    ),
                  ],
                ),
              ))
            ],
          ),
        );
}
