import 'package:eSacco/data/SaccoInfo/save_sacco_info.dart';
import 'package:eSacco/edit_profile.dart';
import 'package:eSacco/enroll_members.dart';
import 'package:eSacco/facts_and_figures.dart';
import 'package:eSacco/loans.dart';
import 'package:eSacco/payments.dart';
import 'package:eSacco/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_core/firebase_core.dart';
import 'data/ProfileInfo/save_profile_info.dart';
import 'setup_profile.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';
import 'signup_screen.dart';
import 'login_screen.dart';
import 'choose_kibiina.dart';
import 'register_kibiina.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(eSacco());
}

class eSacco extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ProfileInfoDao>(
            lazy: false,
            create: (_) => ProfileInfoDao(),
          ),
          Provider<SaccoInfoDao>(
            lazy: false,
            create: (_) => SaccoInfoDao(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initRoute(),
          routes: {
            'welcome_screen': (context) => const WelcomeScreen(),
            'sign_up_screen': (context) => const SignUpScreen(),
            'login_screen': (context) => const LoginScreen(),
            'home_screen': (context) => const HomeScreen(),
            'choose_kibiina': (context) => const ChooseKibiina(),
            'register_kibiina': (context) => const RegisterKibiina(),
            'setup_profile': (context) => const SetupProfile(),
            'enroll_members': (context) => const EnrollMembers(),
            'payments': (context) => const Payments(),
            'facts_and_figures': (context) => const factsAndFigures(),
            'loans': (context) => const Loans(),
            'verify_email': (context) => const VerifyEmail(),
            'edit_profile': (context) => EditProfile()
          },
        ));
  }
}

String initRoute() {
  var user;
  getCurrentUser(user);

  if (user == null) {
    return 'welcome_screen';
  }

  return 'home_screen';
}

getCurrentUser(user) async {
  final _auth = FirebaseAuth.instance;

  try {
    user = (await _auth.currentUser);
  } catch (e) {
    print(e);
  }
}
