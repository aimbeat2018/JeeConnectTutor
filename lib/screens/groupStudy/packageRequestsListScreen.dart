import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/screens/groupStudy/packageDetailsScreen.dart';
import 'package:readmore/readmore.dart';

import '../../constant/colorsConstant.dart';

class PackageRequestListScreen extends StatefulWidget {
  static const String routeName = '/packageRequestList';

  const PackageRequestListScreen({super.key});

  @override
  State<StatefulWidget> createState() => PackageRequestListScreenState();
}

class PackageRequestListScreenState
    extends State<PackageRequestListScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kYellowColor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Package Requests',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PackageDetailScreen(packageid: '',),
                        ));
                      },
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 300,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 79,
                                      width: 400,
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            'assets/images/blue_package_header.png',
                                            fit: BoxFit.cover,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 15.0, bottom: 25.0),
                                                child: Text(
                                                  '7th Std',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: kYellowColor,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w900),
                                                ),
                                              ),
                                              const Align(
                                                alignment: Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: 20.0),
                                                  child: Text(
                                                    'BASIC',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 23,
                                                        fontWeight: FontWeight.w900),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'No. of Students: 02',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'No. of Sessions: 15',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'Course duration: 10 Months',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'Batch Start From: DD/MM/YYYY',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 15),
                                      child: Flexible(
                                        child: ReadMoreText(
                                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit,Lorem ipsum dolor sit amet, consectetur adipiscing elit,Lorem ipsum dolor sit amet, consectetur adipiscing eliet, consectetur adipiscing elit,Lorem ipsum dolor sit amet, consectetur adipiscing eliet, consectetur adipiscing elit,Lorem ipsum dolor sit amet, consectetur adipiscing eli',
                                          trimLines: 5,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 12),
                                          colorClickableText: Colors.pink,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'view details',
                                          trimExpandedText: 'show less',
                                          moreStyle: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.blue),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Center(
                                      child: Text(
                                        'Rs. 49,999/-',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: kBlueDarkColor),
                                      ),
                                    ),
SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // selectImages();
                                              // Navigator.of(context).push(MaterialPageRoute(
                                              //   builder: (context) =>
                                              //       GroupStudyConfirmedPageScreen(),
                                              // ));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                            ),
                                            child: const Text('ACCEPT',
                                                style:
                                                TextStyle(fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // selectImages();
                                              // Navigator.of(context).push(MaterialPageRoute(
                                              //   builder: (context) =>
                                              //       GroupStudyConfirmedPageScreen(),
                                              // ));
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.redAccent,
                                            ),
                                            child: const Text('DECLINE',
                                                style:
                                                TextStyle(fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    )
                                  ],
                                )),
                          )),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
