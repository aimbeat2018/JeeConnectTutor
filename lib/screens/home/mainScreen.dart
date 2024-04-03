import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/screens/home/homeScreen.dart';
import 'package:jeeconnecttutor/screens/schedule/acceptedSessionsListingScreen.dart';
import 'package:jeeconnecttutor/screens/userAuth/instructorProfileScreen.dart';
import 'package:moony_nav_bar/moony_nav_bar.dart';

import '../userAuth/profileScreen.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  static const routeName = '/mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final Widget _screen1 = HomeScreen();
  final Widget _screen2 = const AcceptedSessionsListingScreen();
  final Widget _screen3 = HomeScreen();
  final Widget _screen4 = const InstructorProfileScreen();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: getBody(),
        bottomNavigationBar:   MoonyNavigationBar(
          items: <NavigationBarItem>[
            NavigationBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                color: Colors.white,
                indicatorColor: Colors.white,
                onTap: () {
                  onTapHandler(0);
                }),
            NavigationBarItem(
                icon: Icons.calendar_month_outlined,
                activeIcon: Icons.calendar_month,
                color: Colors.white,
                indicatorColor: Colors.white,
                onTap: () {
                  onTapHandler(1);
                }),
            NavigationBarItem(
                icon: Icons.chat_outlined,
                activeIcon: Icons.chat,
                color: Colors.white,
                indicatorColor: Colors.white,
                onTap: () {
                  onTapHandler(2);
                }),
            NavigationBarItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                color: Colors.white,
                indicatorColor: Colors.white,
                onTap: () {
                  onTapHandler(3);
                })
          ],
          style: MoonyNavStyle(
            activeColor: Colors.white,
            indicatorPosition: IndicatorPosition.BOTTOM,
            indicatorType: IndicatorType.LINE,
            indicatorColor: kComplimentaryBackgroundColor,
            backgroundColor: kPrimaryColor,
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }


  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._screen1;
    } else if (this.selectedIndex == 1) {
      return this._screen2;
    } else if (this.selectedIndex == 2) {
      return this._screen3;
    } else {
      return this._screen4;
    }
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}
