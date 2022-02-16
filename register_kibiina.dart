import 'package:eSacco/data/SaccoInfo/save_sacco_info.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'custom_button.dart';
import 'data/ProfileInfo/save_profile_info.dart';
import 'data/SaccoInfo/sacco_info.dart';

//code for designing the UI of our text field where the user writes his email id or password

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
var reqMembers;

class RegisterKibiina extends StatefulWidget {
  const RegisterKibiina({Key? key}) : super(key: key);

  @override
  _RegisterKibiinaState createState() => _RegisterKibiinaState();
}

class _RegisterKibiinaState extends State<RegisterKibiina> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;
  late TextEditingController saccoNameController,
      locationController,
      memNumController;
  Color? buttonColor = Color.fromARGB(255, 28, 49, 76);
  Color confPasswordColor = Colors.white;
  String _selectedYear = DateTime.now().year.toString();

  @override
  void initState() {
    super.initState();
    saccoNameController = TextEditingController();
    locationController = TextEditingController();
    memNumController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final saccoInfoDao = Provider.of<SaccoInfoDao>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 49, 76),
      body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                const Text(
                  'Enter the name of the savings Groups: ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextField(
                    controller: saccoNameController,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      saccoName = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter name of savings Group.')),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                const Text(
                  'Location:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextField(
                    controller: locationController,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      location = locationController.text;
                      print('location is' + location);
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter location of savings group')),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                const Text(
                  'Number of Members:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: memNumController,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter the number of members'),
                  onChanged: (value) {
                    print(memNumController.value);
                    reqMembers = int.parse(memNumController.text);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                const Text(
                  'Year of establishment:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                DropdownButtonFormField(
                    dropdownColor: Color.fromARGB(255, 28, 49, 76),
                    value: _selectedYear,
                    hint: const Text(
                      'Enter the date of establishment.',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    items: <String>[
                      '2022',
                      '2021',
                      '2020',
                      '2019',
                      '2018',
                      '2017',
                      '2016',
                      '2015',
                      '2013',
                      '2012',
                      '2011',
                      '2010',
                      '2009',
                      '2008',
                      '2007',
                      '2006',
                      '2005',
                      '2004',
                      '2003',
                      '2002',
                      '2001',
                      '2000',
                      '1999',
                      '1998',
                      '1997',
                      '1996',
                      '1995',
                      '1994',
                      '1993',
                      '1992',
                      '1991',
                      '1990',
                      '1989',
                      '1988',
                      '1987',
                      '1986',
                      '1985',
                      '1984',
                      '1983',
                      '1982',
                      '1981',
                      '1980',
                      '1979',
                      '1978',
                      '1977',
                      '1976',
                      '1975',
                      '1974',
                      '1973',
                      '1972',
                      '1971',
                      '1970',
                      '1969',
                      '1968',
                      '1967',
                      '1966',
                      '1965',
                      '1964',
                      '1963',
                      '1962',
                      '1961',
                      '1960',
                      '1959',
                      '1958',
                      '1957',
                      '1956',
                      '1955',
                      '1954',
                      '1953',
                      '1952',
                      '1951',
                      '1950',
                      '1949',
                      '1948',
                      '1947',
                      '1946',
                      '1945',
                      '1944',
                      '1943',
                      '1942',
                      '1941',
                      '1940',
                      '1939',
                      '1938',
                      '1937',
                      '1936',
                      '1935',
                      '1934',
                      '1933',
                      '1932',
                      '1931',
                      '1930',
                      '1929',
                      '1928',
                      '1927',
                      '1926',
                      '1925',
                      '1924',
                      '1923',
                      '1922',
                      '1921',
                      '1920',
                      '1919',
                      '1918',
                      '1917',
                      '1916',
                      '1915',
                      '1914',
                      '1913',
                      '1912',
                      '1911',
                      '1910',
                      '1909',
                      '1908',
                      '1907',
                      '1906',
                      '1905',
                      '1904',
                      '1903',
                      '1902',
                      '1901',
                      '1900',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(growable: true),
                    onChanged: (value) {
                      yearOfEst = value.toString();
                      setState(() {
                        _selectedYear = value.toString();
                      });
                      print(yearOfEst);
                    }),
                Center(
                    child: RoundedButton(
                  colour: buttonColor,
                  title: 'Register Group',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      print(/*'required members: ' +*/ reqMembers);
                      saveSaccoInfo(saccoInfoDao);
                      Navigator.pushNamed(context, 'enroll_members');
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                )),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void saveSaccoInfo(SaccoInfoDao saccoInfoDao) {
    final info = SaccoInfo(
      saccoName: saccoNameController.text,
      location: locationController.text,
      noOfMembers: int.parse(memNumController.text),
      year: _selectedYear,
    );
    print('saved sacco info');
    saccoInfoDao.saveInfo(info, saccoNameController.text);
    saccoName = saccoNameController.text;
  }
}
