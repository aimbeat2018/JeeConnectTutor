import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SessionDetailsScreen extends StatefulWidget {
  static const String name = 'sessionDetails';

  const SessionDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => SessionDetailsScreenState();
}

class SessionDetailsScreenState extends State<SessionDetailsScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  bool clearText = false;
  late List<TextEditingController?> controls;

  @override
  void initState() {
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kYellowColor,
        centerTitle: true,
        title: Text(
          'Session Details',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Container(
                child: Column(
                    children: [
                      Text(
                        'YOUR TODAYS SESSION\nHAS BEEN ENDED',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      GestureDetector(
                        // onTap: () =>  Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => const SubjectListingScreen(),
                        // )),
                          child: SizedBox(
                            height: 350,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: SizedBox(
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(0xff22996c),
                                                  Color(0xff53b058),
                                                  Color(0xff77bf49),
                                                  Color(0xff9ed139)
                                                ]),
                                            // color: const Color(0xff3e4982),
                                            /*image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                    "https://miro.medium.com/max/1400/1*-6WdIcd88w3pfphHOYln3Q.png"),
                                                                colorFilter: new ColorFilter.mode(
                                                                    Colors.black.withOpacity(0.19), BlendMode.dstATop),
                                                              ),*/
                                            borderRadius: BorderRadius
                                                .only(
                                                topLeft: Radius
                                                    .circular(12),
                                                topRight: Radius
                                                    .circular(12),
                                                bottomLeft: Radius
                                                    .circular(12),
                                                bottomRight: Radius
                                                    .circular(12))
                                        ),
                                      ),
                                      Positioned(
                                        child: Padding(
                                          padding: const EdgeInsets
                                              .all(15.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: Text(
                                                  'Tutors Details',
                                                  textAlign: TextAlign
                                                      .center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight
                                                        .bold,
                                                    color: Colors
                                                        .white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Text(
                                                    'Pranjal Deshmukh',
                                                    textAlign: TextAlign
                                                        .left,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Location - Vashi, Navi Mumbai',
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    'FRENCH',
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),

                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '80 Lessons',
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  new LinearPercentIndicator(
                                                    width: 140.0,
                                                    lineHeight: 11.0,
                                                    percent: 0.5,
                                                    trailing: new Text(
                                                      "51%",
                                                      style: new TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors
                                                              .white,
                                                          fontWeight: FontWeight
                                                              .bold),
                                                    ),
                                                    backgroundColor:
                                                    Color(0xff8fca3f),
                                                    progressColor: Colors
                                                        .white,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    '21 June 2023',
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '09:00 AM - 10:00 AM',
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Session Type - Online',
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Session Link - https://www.google.co.in/',
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .normal,
                                                      color: Colors
                                                          .white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            ),
                          )
                      ),
                    ])

            ),


          ),


        ),
      ),
    );
  }


}
