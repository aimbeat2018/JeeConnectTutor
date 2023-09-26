import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/screens/home/acceptListScreen.dart';
import 'package:jeeconnecttutor/screens/home/completedScreen.dart';
import 'package:jeeconnecttutor/screens/home/homeScreen.dart';

import '../../constant/route_helper.dart';
import '../../controllers/authController.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  static const routeName = '/mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kYellowColor,
          automaticallyImplyLeading: false,
          centerTitle: false,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Accepted',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
          ),
          title: Text(
            'Jeeconnect'.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  Get.toNamed(RouteHelper.getProfileScreenRoute());
                },
                child: const Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: InkWell(
                onTap: () {
                  showDialog(
                      builder: (ctxt) {
                        return AlertDialog(
                          title: const Text(
                            'Logout',
                            style: TextStyle(color: kYellowColor),
                          ),
                          content: const Text('Do you Really want to logout?'),
                          actions: [
                            // The "Yes" button
                            TextButton(
                                onPressed: () {
                                  Navigator.of(ctxt).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: kYellowColor,
                                      fontWeight: FontWeight.bold),
                                )),
                            TextButton(
                                onPressed: () {
                                  // Close the dialog
                                  Navigator.of(ctxt).pop();
                                  Get.find<AuthController>().clearSharedData();

                                  Get.offAllNamed(RouteHelper.getLoginRoute());
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(
                                      color: kYellowColor,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        );
                      },
                      context: context);
                },
                child: const Icon(
                  Icons.logout,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
        body: TabBarView(
          children: [
            HomeScreen(),
            const AcceptListScreen(),
            const CompletedScreen(),
          ],
        ),
      ),
    );
  }
}
