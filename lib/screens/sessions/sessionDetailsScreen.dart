import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/custom_snackbar.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../controllers/authController.dart';
import '../../controllers/requestController.dart';

class SessionDetailsScreen extends StatefulWidget {
  final String id;

  const SessionDetailsScreen({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => SessionDetailsScreenState();
}

class SessionDetailsScreenState extends State<SessionDetailsScreen>
    with TickerProviderStateMixin {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  TextEditingController reviewController = TextEditingController();

  final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
  String ratingStr = "5.0";

  @override
  void initState() {
    super.initState();

    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });

    if (mounted) {
      Get.find<RequestController>()
          .sessionDetails(widget.id, Get.find<AuthController>().getUserToken());
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<RequestController>(builder: (requestController) {
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                backgroundColor: kYellowColor,
                centerTitle: true,
                title: const Text(
                  'Session Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              body: requestController.isDetailsLoading ||
                      requestController.sessionDetailsModel == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(children: [
                          if (requestController.sessionDetailsModel!.status! ==
                              "4")
                            Column(
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
                                SizedBox(
                                  height: 10,
                                ),
                                if (requestController.sessionDetailsModel!
                                            .studReviewStatus ==
                                        "0" &&
                                    requestController.sessionDetailsModel!
                                            .insReviewStatus ==
                                        "1")
                                  Text(
                                    'Review from Student side is pending'
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: kYellowColor,
                                    ),
                                  ),
                              ],
                            ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: SizedBox(
                                child: Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(colors: [
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
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                                bottomLeft: Radius.circular(12),
                                                bottomRight:
                                                    Radius.circular(12))),
                                      ),
                                      Positioned(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Center(
                                                child: Text(
                                                  'Student Details',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    requestController
                                                        .sessionDetailsModel!
                                                        .studentName!,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Location ${requestController.sessionDetailsModel!.studentAddress!}',
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    'Subject : ${requestController.sessionDetailsModel!.courseName!}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),

                                                  // Text(
                                                  //   '80 Lessons',
                                                  //   textAlign: TextAlign.center,
                                                  //   style: TextStyle(
                                                  //     fontSize: 10,
                                                  //     fontWeight:
                                                  //         FontWeight.normal,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //   height: 10,
                                                  // ),
                                                  // new LinearPercentIndicator(
                                                  //   width: 140.0,
                                                  //   lineHeight: 11.0,
                                                  //   percent: 0.5,
                                                  //   trailing: new Text(
                                                  //     "51%",
                                                  //     style: new TextStyle(
                                                  //         fontSize: 12.0,
                                                  //         color: Colors.white,
                                                  //         fontWeight:
                                                  //             FontWeight.bold),
                                                  //   ),
                                                  //   backgroundColor:
                                                  //       Color(0xff8fca3f),
                                                  //   progressColor: Colors.white,
                                                  // ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'Date : ${GlobalFunctions.formatDate(requestController.sessionDetailsModel!.date!)}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Time : ${requestController.sessionDetailsModel!.time!}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  // Text(
                                                  //   'Session Type ${ requestController
                                                  //       .sessionDetailsModel!
                                                  //       .ty!}}',
                                                  //   textAlign: TextAlign.center,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //     fontWeight:
                                                  //         FontWeight.normal,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
                                                  // SizedBox(
                                                  //   height: 5,
                                                  // ),
                                                  // Text(
                                                  //   'Session Link - https://www.google.co.in/',
                                                  //   maxLines: 1,
                                                  //   overflow:
                                                  //       TextOverflow.ellipsis,
                                                  //   style: TextStyle(
                                                  //     fontSize: 12,
                                                  //     fontWeight:
                                                  //         FontWeight.normal,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
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
                          ),
                          if (requestController.sessionDetailsModel!.status ==
                                  "4" &&
                              requestController
                                      .sessionDetailsModel!.insReviewStatus !=
                                  "1")
                            SizedBox(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.white,
                                    shadowColor: Colors.blue.shade900,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0,
                                          bottom: 18,
                                          right: 20,
                                          left: 20),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Image.asset(
                                            'assets/images/reviews.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'Give Review to student'
                                                .toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          RatingBar.builder(
                                            initialRating: 5,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                              ratingStr = rating.toString();
                                            },
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 16),
                                            child: TextFormField(
                                              controller: reviewController,
                                              decoration: const InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelText: 'Enter Review',
                                              ),
                                              minLines: 3,
                                              maxLines: 3,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blue.shade900,
                                                textStyle: const TextStyle(
                                                    fontSize: 14)),
                                            onPressed: () {
                                              if (reviewController
                                                  .text.isEmpty) {
                                                showCustomSnackBar(
                                                    'Enter Review');
                                              } else {
                                                addReview(
                                                    requestController
                                                        .sessionDetailsModel!
                                                        .id!,
                                                    requestController);
                                              }
                                            },
                                            child: const Text('Submit'),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (requestController.sessionDetailsModel!.status ==
                              "1")
                            SizedBox(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadowColor: Colors.blue.shade900,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18.0,
                                          bottom: 18,
                                          right: 20,
                                          left: 20),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Image.asset(
                                            'assets/images/pin.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'To start session enter the OTP sent on Student mobile number',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          OtpPinField(
                                            key: _otpPinFieldController,
                                            autoFillEnable: false,
                                            textInputAction:
                                                TextInputAction.done,
                                            otpPinFieldDecoration:
                                                OtpPinFieldDecoration
                                                    .defaultPinBoxDecoration,
                                            onSubmit: (String otp) {},
                                            onChange: (String otp) {},
                                            otpPinFieldStyle:
                                                const OtpPinFieldStyle(
                                              defaultFieldBorderColor:
                                                  kYellowColor,
                                              activeFieldBorderColor:
                                                  Colors.indigo,
                                            ),
                                            maxLength: 4,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          requestController.isLoading
                                              ? CircularProgressIndicator()
                                              : ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blue
                                                                  .shade900,
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      14)),
                                                  onPressed: () {
                                                    if (_otpPinFieldController
                                                        .currentState!
                                                        .text
                                                        .isEmpty) {
                                                      showCustomSnackBar(
                                                          "Enter OTP");
                                                    } else if (_otpPinFieldController
                                                            .currentState!
                                                            .text
                                                            .length !=
                                                        4) {
                                                      showCustomSnackBar(
                                                          "Enter Valid OTP");
                                                    } else {
                                                      startSession(
                                                          requestController
                                                              .sessionDetailsModel!
                                                              .id!,
                                                          _otpPinFieldController
                                                              .currentState!
                                                              .text,
                                                          requestController);
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Start session',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          if (requestController.sessionDetailsModel!.status ==
                              "3")
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadowColor: Colors.blue.shade900,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0,
                                            bottom: 18,
                                            right: 20,
                                            left: 20),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Image.asset(
                                              'assets/images/pin.png',
                                              height: 50,
                                              width: 50,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              'The session has started',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            requestController.isLoading
                                                ? CircularProgressIndicator()
                                                : ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.blue
                                                                    .shade900,
                                                            textStyle:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14)),
                                                    onPressed: () {
                                                      showDialog(
                                                          builder: (ctxt) {
                                                            return AlertDialog(
                                                              title: const Text(
                                                                'Alert',
                                                                style: TextStyle(
                                                                    color:
                                                                        kYellowColor),
                                                              ),
                                                              content: const Text(
                                                                  'Do you Really want to end session?'),
                                                              actions: [
                                                                // The "Yes" button
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              ctxt)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'Cancel',
                                                                      style: TextStyle(
                                                                          color:
                                                                              kYellowColor,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    )),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      // Close the dialog
                                                                      Navigator.of(
                                                                              ctxt)
                                                                          .pop();

                                                                      endSession(
                                                                          requestController
                                                                              .sessionDetailsModel!
                                                                              .id!,
                                                                          requestController);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'Yes',
                                                                      style: TextStyle(
                                                                          color:
                                                                              kYellowColor,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ))
                                                              ],
                                                            );
                                                          },
                                                          context: context);
                                                    },
                                                    child: const Text(
                                                      'End session',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ]),
                      ),
                    ),
            );
          });
  }

  void startSession(
      String id, String otp, RequestController requestController) {
    String currentTime = GlobalFunctions.getCurrentTime();
    requestController
        .startSession(
            id, Get.find<AuthController>().getUserToken(), otp, currentTime)
        .then((model) async {
      if (model!.status != 403) {
        showCustomSnackBar(model.message!, isError: false);
        requestController.sessionDetailsModel!.status = "3";
        setState(() {});
      } else {
        showCustomSnackBar(model.message!);
      }
    });
  }

  void endSession(String id, RequestController requestController) {
    String currentTime = GlobalFunctions.getCurrentTime();
    requestController
        .endSession(id, Get.find<AuthController>().getUserToken(), currentTime)
        .then((model) async {
      if (model!.status != 403) {
        showCustomSnackBar(model.message!, isError: false);
        requestController.sessionDetailsModel!.status = "4";
        setState(() {});
      } else {
        showCustomSnackBar(model.message!);
      }
    });
  }

  void addReview(String id, RequestController requestController) {
    requestController
        .addReview(id, Get.find<AuthController>().getUserToken(), ratingStr,
            reviewController.text)
        .then((model) async {
      if (model!.status != 403) {
        showCustomSnackBar(model.message!, isError: false);
        requestController.sessionDetailsModel!.status = "5";
        setState(() {});
      } else {
        showCustomSnackBar(model.message!);
      }
    });
  }
}
