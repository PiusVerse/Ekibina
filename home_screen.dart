import 'package:eSacco/choose_kibiina.dart';
import 'package:eSacco/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Profile(),
      payments(),
      factsAndFigures(),
      loans()
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(currSacco),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar:
          // ignore: prefer_const_literals_to_create_immutables
          BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Payments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_graph_rounded),
            label: 'Facts and Figures',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money_off_rounded),
            label: 'Loans',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        backgroundColor: Colors.blue,
        unselectedItemColor: Color.fromARGB(255, 28, 49, 76),
        selectedFontSize: 15.0,
      ),
    );
  }

  Widget payments() {
    return Scaffold(backgroundColor: Color.fromARGB(255, 28, 49, 76));
  }

  Widget factsAndFigures() {
    return Scaffold(backgroundColor: Color.fromARGB(255, 28, 49, 76));
  }

  Widget loans() {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 49, 76),
      body: ListView(children: [
        Padding(padding: EdgeInsets.only(top: 20.0)),
        Text(
          'You do not have any loans running currently.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
        Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
              child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'loans');
            },
            child: Text(
              'Apply for Loan now.',
              style: TextStyle(color: Colors.blueAccent),
            ),
          )),
        ),
      ]),
    );
  }
}
