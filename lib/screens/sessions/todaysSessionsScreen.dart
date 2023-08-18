import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/screens/sessions/sessionDetailsScreen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TodaysSessionScreen extends StatefulWidget {
  static const String name = 'todaysSession';

  const TodaysSessionScreen({super.key});

  @override
  State<StatefulWidget> createState() => TodaysSessionScreenState();
}

class TodaysSessionScreenState extends State<TodaysSessionScreen>
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
          'Todays Session',
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
                                  SizedBox(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Card(
                                          elevation: 15,
                                          color: Colors.white,
                                          shadowColor: Colors.blue.shade900,
                                          child: Padding(
                                            padding: const EdgeInsets.only(top:18.0,bottom: 18,right:20,left: 20),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Image.asset(
                                                  'assets/images/pin.png',
                                                  height: 65,
                                                  width: 65,
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  'Sessions Begin Once You\nSubmits The Otp.',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                OtpTextField(
                                                  numberOfFields: 4,
                                                  borderColor: Colors.white,
                                                  focusedBorderColor: Colors.blue
                                                      .shade900,
                                                  fillColor: Colors.blue.shade900,
                                                  clearText: clearText,
                                                  showFieldAsBox: true,
                                                  textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10),
                                                  cursorColor: Colors.white,
                                                  onCodeChanged: (String value) {
                                                    //Handle each value
                                                  },
                                                  handleControllers: (
                                                      controllers) {
                                                    //get all textFields controller, if needed
                                                    controls = controllers;
                                                  },
                                                  onSubmit: (
                                                      String verificationCode) {
                                                    //set clear text to clear text from all fields56
                                                    setState(() {
                                                      clearText = true;
                                                    });
                                                    //navigate to different screen code goes here
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Verification Code"),
                                                          content: Text(
                                                              'Code entered is $verificationCode'),
                                                        );
                                                      },
                                                    );
                                                  }, // end onSubmit
                                                ),
                                                SizedBox(height: 25,),
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.blue.shade900,
                                                      textStyle: const TextStyle(fontSize: 14)),
                                                  onPressed: () {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => const SessionDetailsScreen(),
                                                    ));
                                                  },
                                                  child: const Text('Submit'),
                                                ), SizedBox( height: 10,),
                                                Text(
                                                  'Resend otp?',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.blue.shade900,
                                                  ),
                                                ),
                                                SizedBox(height: 15,),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ])

                      ),


              ),


        ),
      ),
    );
  }


}
