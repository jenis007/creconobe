import 'dart:developer';

import 'package:creconobe_transformation/authentication/login.dart';
import 'package:creconobe_transformation/dashboard/profile.dart';
import 'package:creconobe_transformation/subscription/subscriptionDashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../prefManager.dart';
import 'mainDashboard.dart';

class DashboardBottom extends StatefulWidget {
  String name;
  DashboardBottom(this.name, {super.key});
  @override
  State<DashboardBottom> createState() => _Dashboard();
}

class _Dashboard extends State<DashboardBottom> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    if (index == 2) {
      if (name == "guest") {
        showDialog(
          context: context,
          builder: (context) {
            return Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.height * 0.35,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Please log in or register to access all of these features',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.athiti().fontFamily,
                                color: Colors.black)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                    // margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 5,
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: GoogleFonts.athiti().fontFamily,
                                          color: Colors.green)),
                                )),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Container(
                                    // margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                    child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    elevation: 5,
                                    minimumSize: const Size.fromHeight(50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                                  },
                                  child: Text("LogIn",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: GoogleFonts.athiti().fontFamily,
                                          color: Colors.white)),
                                )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
      } else {
        setState(() {
          _selectedIndex = index;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  late String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullName();


  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      MainDashboard(widget.name),
      const SubscriptionDashboard(),
      const Profile(),
    ];

    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ('Home'), backgroundColor: Colors.green),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_sharp), label: ('Subscription'), backgroundColor: Colors.green),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: ('Profile'),
              backgroundColor: Colors.green,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          iconSize: 20,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }

  Future<void> fullName() async {
    String? token = await PrefManager.getString("name");
    name = token.toString();
    log("full name======${ await PrefManager.getString("token")}");
  }
}
