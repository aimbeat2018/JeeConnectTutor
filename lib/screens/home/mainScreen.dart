import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/screens/home/homeScreen.dart';
import 'package:jeeconnecttutor/screens/schedule/scheduleListingScreen.dart';

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
  Widget _screen1 = HomeScreen();
  Widget _screen2 = ScheduleListingScreen();
  Widget _screen3 = HomeScreen();
  Widget _screen4 = ProfileScreen();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      // appBar: AppBar(
      //   title: const Text('Moony navigation bar'),
      // ),
      body: getBody(),
      // bottomNavigationBar: MoonyNavigationBar(
      //   items: <NavigationBarItem>[
      //     NavigationBarItem(
      //         icon: Icons.home_outlined,
      //         activeIcon: Icons.home,
      //         color: Colors.pink,
      //         indicatorColor: Colors.pink,
      //         onTap: () {
      //           onTapHandler(0);
      //         }),
      //     NavigationBarItem(
      //         icon: Icons.calendar_month_outlined,
      //         activeIcon: Icons.calendar_month,
      //         color: Colors.pink,
      //         indicatorColor: Colors.pink,
      //         onTap: () {
      //           onTapHandler(1);
      //         }),
      //     NavigationBarItem(
      //         icon: Icons.chat_outlined,
      //         activeIcon: Icons.chat,
      //         color: Colors.pink,
      //         indicatorColor: Colors.pink,
      //         onTap: () {
      //           onTapHandler(2);
      //         }),
      //     NavigationBarItem(
      //         icon: Icons.person_outline,
      //         activeIcon: Icons.person,
      //         color: Colors.pink,
      //         indicatorColor: Colors.pink,
      //         onTap: () {
      //           onTapHandler(3);
      //         })
      //   ],
      //   style: MoonyNavStyle(
      //     activeColor: Theme.of(context).primaryColor,
      //     indicatorPosition: IndicatorPosition.TOP,
      //     indicatorType: IndicatorType.LINE,
      //     indicatorColor: Colors.yellow,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(25),
      //       topRight: Radius.circular(25),
      //     ),
      //   ),
      // ),
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
