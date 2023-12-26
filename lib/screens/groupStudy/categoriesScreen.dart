import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/screens/groupStudy/completedPackageHistoryListScreen.dart';
import 'package:jeeconnecttutor/screens/groupStudy/ongoingPackageListScreen.dart';
import 'package:jeeconnecttutor/screens/groupStudy/packageDetailsScreen.dart';
import 'package:jeeconnecttutor/screens/groupStudy/packageRequestsListScreen.dart';

import '../../constant/colorsConstant.dart';

class CategoriesScreen extends StatefulWidget {
  static const String name = 'categoriesScreen';

  const CategoriesScreen({super.key});

  @override
  State<StatefulWidget> createState() => CategoriesScreenState();

}

class CategoriesScreenState extends State<CategoriesScreen> with TickerProviderStateMixin {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kYellowColor,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) =>
                      PackageRequestListScreen(),
                ));
              },
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/meeting.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Package\nRequests',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) =>
                  const OngoingPackagesListScreen(),
                ));
              },
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/schedule.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Ongoing\nPackage',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) =>
                  const CompletedPackagesHistoryListScreen(),
                ));
              },
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/history.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Package\nHistory',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),),
      ),
    );
  }
}