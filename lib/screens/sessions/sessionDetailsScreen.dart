import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/custom_snackbar.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/model/response/sesssionStartRequestModel.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_allinonesdk/data/models/meeting_options.dart';
import 'package:zoom_allinonesdk/data/models/zoom_options.dart';
import 'package:zoom_allinonesdk/zoom_allinonesdk.dart';

import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../controllers/authController.dart';
import '../../controllers/requestController.dart';
import '../../model/response/ChapterListResponseModel.dart';
import '../../model/response/SessionResponseModel.dart';

class SessionDetailsScreen extends StatefulWidget {
  final String id, packageid, session;

  const SessionDetailsScreen(
      {super.key,
      required this.id,
      required this.packageid,
      required this.session});

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
  String? selectedChapter;
  ChapterListResponseModel? chapterListResponseModel;
  List<ChapterListModel>? chapterlist;

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
          .sessionDetails(widget.id, Get.find<AuthController>().getUserToken())
          .then((value) async => {getChapterList(widget.packageid)});
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
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
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
                      requestController.sessionDetailsModel == null ||
                      requestController.sessionDetailsModel!.data!.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(children: [
                          if (requestController
                                  .sessionDetailsModel!.data![0].status ==
                              "5")
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
                                const SizedBox(
                                  height: 10,
                                ),
                                if (requestController
                                        .sessionDetailsModel!.data![0].status ==
                                    '1')
                                  Text(
                                    'Review from Student side is pending'
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: kYellowColor,
                                    ),
                                  ),
                              ],
                            ),
                          SizedBox(
                            height: 360,
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
                                                    'Student Name : ${requestController.sessionDetailsModel!.data![0].studentName!}',
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
                                                    'Location : ${requestController.sessionDetailsModel!.data![0].studentAdd!}',
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
                                                    'Subject : ${requestController.sessionDetailsModel!.data![0].subject!}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    'No. of chapters : ${requestController.sessionDetailsModel!.data![0].noOfChaoters!}',
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
                                                    'Date : ${requestController.sessionDetailsModel!.data![0].date!}',
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
                                                    'Time : ${requestController.sessionDetailsModel!.data![0].time!}',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Session Type : ${requestController.sessionDetailsModel!.data![0].sessionType!}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  requestController
                                                                  .sessionDetailsModel!
                                                                  .data![0]
                                                                  .sessionType! ==
                                                              'Online' &&
                                                          requestController
                                                                  .sessionDetailsModel!
                                                                  .data![0]
                                                                  .joinUrl !=
                                                              ""
                                                      ? Text(
                                                          // 'Session Link : ${requestController.sessionDetailsModel!.data![0].googleMeetLink}',
                                                          'Session Link : ${requestController.sessionDetailsModel!.data![0].joinUrl!}',
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      : SizedBox(),
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
                          if (requestController
                                  .sessionDetailsModel!.data![0].status ==
                              "4")
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
                                            style: const TextStyle(
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
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: kYellowColor,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                              ratingStr = rating.toString();
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          if (chapterlist != null)
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: kBlueDarkColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        5.0) //                 <--- border radius here
                                                    ),
                                              ),
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 37,
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton(
                                                    dropdownColor:
                                                        CupertinoColors
                                                            .lightBackgroundGray,
                                                    value: selectedChapter,
                                                    icon: const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: kPrimaryColor,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    hint: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4.0),
                                                      child: const Text(
                                                        'Select Chapter',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    items: chapterlist!
                                                        .map((chaptermodel) {
                                                      return DropdownMenuItem(
                                                        value: chaptermodel
                                                            .chapters,
                                                        child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            child: Text(
                                                              chaptermodel
                                                                  .chapters!,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            )),
                                                      );
                                                    }).toList(),
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        selectedChapter =
                                                            newValue!;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          const SizedBox(
                                            height: 10,
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
                                                        .data![0]
                                                        .sessionId!,
                                                    requestController);
                                              }
                                            },
                                            child: const Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: Colors.white),
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
                          if (requestController
                                  .sessionDetailsModel!.data![0].status ==
                              "0")
                            requestController.sessionDetailsModel!.data![0]
                                        .sessionType ==
                                    "Online"
                                ? SizedBox(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: requestController.isLoading
                                            ? const CircularProgressIndicator()
                                            : ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.blue.shade900,
                                                    textStyle: const TextStyle(
                                                        fontSize: 14)),
                                                onPressed: () {
                                                  if (requestController
                                                          .sessionDetailsModel!
                                                          .data![0]
                                                          .joinUrl ==
                                                      "") {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                          'Session Starting',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                                'Are you sure you want to start this session?'),
                                                            Text(
                                                              '${requestController.sessionDetailsModel!.data![0].subject!}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                  color:
                                                                      btnColor),
                                                            ),
                                                            Text(
                                                              '${requestController.sessionDetailsModel!.data![0].date!}-${requestController.sessionDetailsModel!.data![0].time!}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context),
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              startOnlineSessionData(
                                                                  requestController);
                                                            },
                                                            child: const Text(
                                                                'Yes'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    showCustomSnackBar(
                                                        'Meeting already created');
                                                  }
                                                },
                                                child: const Text(
                                                  'Start session',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Card(
                                          elevation: 5,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                                                  'To start session enter the OTP sent on Student Jeeconnect App',
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
                                                  fieldHeight: 40,
                                                  fieldWidth: 40,
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
                                                    ? const CircularProgressIndicator()
                                                    : ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
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
                                                          } else if (requestController
                                                                  .sessionDetailsModel!
                                                                  .data![0]
                                                                  .otpCode! !=
                                                              _otpPinFieldController
                                                                  .currentState!
                                                                  .text) {
                                                            showCustomSnackBar(
                                                                "Enter Valid OTP");
                                                          } else {
                                                            startOfflineSessionData(
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
                          if (requestController
                                  .sessionDetailsModel!.data![0].status ==
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
                                                ? const CircularProgressIndicator()
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
                                                                  'Do you really want to end session?'),
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
                                                                              .data![0]
                                                                              .sessionId!,
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

  void startSession(SesssionStartRequestModel? sesssionStartRequestModel,
      RequestController requestController) {
    requestController
        .startSession(sesssionStartRequestModel!)
        .then((model) async {
      if (model!.status != 403) {
        showCustomSnackBar(model.msg!, isError: false);
        requestController.sessionDetailsModel!.data![0].status = "3";

        Get.find<RequestController>()
            .sessionDetails(
                widget.id, Get.find<AuthController>().getUserToken())
            .then((value) async => {getChapterList(widget.packageid)});

        joinMeeting(context,requestController, model!);
      } else {
        showCustomSnackBar(model.msg!);
      }
    });
  }

  Future<void> joinMeeting(BuildContext context, RequestController requestController, SessionResponseModel sessionResponseModel) async {

    ZoomOptions zoomOptions = ZoomOptions(
      domain: "zoom.us",
      clientId: "5rEF65h8RXzQRQ0RFlnCg",
      clientSecert: "cHJYKybu67WZHWU4VIXoSMpZCXfYffTf",
    );
    var meetingOptions = MeetingOptions(
        displayName:
        await Get.find<AuthController>().getUserName(),
        meetingId: sessionResponseModel.meetingId!.toString(), //Personal meeting id for join meeting required
        meetingPassword: sessionResponseModel.password!, //Personal meeting password for join meeting required
        userType: "1");


    var zoom = ZoomAllInOneSdk();
    zoom.initZoom(zoomOptions: zoomOptions).then((results) {
      if (results[0] == 0) {
        zoom.joinMeting(meetingOptions: meetingOptions).then((loginResult) {});
      }
    }).catchError((error) {
      print("[Error Generated] : " + error);
    });
  }

  getTime(startTime, endTime) {
    bool result = false;
    int startTimeInt = (startTime.hour * 60 + startTime.minute) * 60;
    int EndTimeInt = (endTime.hour * 60 + endTime.minute) * 60;
    int dif = EndTimeInt - startTimeInt;

    if (EndTimeInt == startTimeInt) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  void endSession(String id, RequestController requestController) {
    String currentTime = GlobalFunctions.getCurrentTime();
    requestController
        .endSession(id, Get.find<AuthController>().getUserToken(), currentTime)
        .then((model) async {
      if (model!.status != 403) {
        showCustomSnackBar(model.msg!, isError: false);
        requestController.sessionDetailsModel!.data![0].status = "5";
        setState(() {});
      } else {
        showCustomSnackBar(model.msg!);
      }
    });
  }

  void addReview(String id, RequestController requestController) {
    requestController
        .addReview(id, Get.find<AuthController>().getUserToken(), ratingStr,
            reviewController.text, selectedChapter!)
        .then((model) async {
      if (model!.status != 403) {
        showCustomSnackBar(model.msg!, isError: false);
        requestController.sessionDetailsModel!.data![0].status = "6";
        setState(() {});
      } else {
        showCustomSnackBar(model.msg!);
      }
    });
  }

  getChapterList(String packageid) async {
    chapterListResponseModel =
        await Get.find<RequestController>().getchapterlist(packageid);
    chapterlist = chapterListResponseModel!.data!;
    setState(() {});
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(
        'https://us05web.zoom.us/j/85141654178?pwd=89KOgASoZZHT5lp5oy8jKk36RbpDEi.1');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> startOnlineSessionData(
      RequestController requestController) async {
    SesssionStartRequestModel? sesssionStartRequestModel =
        SesssionStartRequestModel();

    sesssionStartRequestModel!.sessionId =
        requestController.sessionDetailsModel!.data![0].sessionId!;
    sesssionStartRequestModel.otp = "";
    sesssionStartRequestModel.startTime =
        requestController.sessionDetailsModel!.data![0].time!;

    sesssionStartRequestModel.meet = Meet();
    sesssionStartRequestModel.meet!.agenda = widget.session + "th session";
    sesssionStartRequestModel.meet!.defaultPassword = false;
    sesssionStartRequestModel.meet!.duration = "60";
    sesssionStartRequestModel.meet!.password =
        requestController.sessionDetailsModel!.data![0].password!;

    sesssionStartRequestModel.meet!.settings = Settings();
    sesssionStartRequestModel.meet!.settings!.audio = "both";
    sesssionStartRequestModel.meet!.settings!.calendarType = 2;
    sesssionStartRequestModel.meet!.settings!.contactEmail = "";
    sesssionStartRequestModel.meet!.settings!.contactName =
        await Get.find<AuthController>().getUserName();
    sesssionStartRequestModel.meet!.settings!.hostVideo = true;
    sesssionStartRequestModel.meet!.settings!.muteUponEntry = false;
    sesssionStartRequestModel.meet!.settings!.joinBeforeHost = true;
    sesssionStartRequestModel.meet!.startTime =
        requestController.sessionDetailsModel!.data![0].time!;
    sesssionStartRequestModel.meet!.timezone = "Asia/Kolkata";
    sesssionStartRequestModel.meet!.type = 2;

    startSession(sesssionStartRequestModel, requestController);
  }

  Future<void> startOfflineSessionData(
      RequestController requestController) async {
    SesssionStartRequestModel? sesssionStartRequestModel;

    sesssionStartRequestModel!.sessionId =
        requestController.sessionDetailsModel!.data![0].sessionId!;
    sesssionStartRequestModel.otp =
        requestController.sessionDetailsModel!.data![0].otpCode!;
    sesssionStartRequestModel.startTime =
        requestController.sessionDetailsModel!.data![0].time!;
    sesssionStartRequestModel.meet!.agenda = "";
    sesssionStartRequestModel.meet!.defaultPassword = false;
    sesssionStartRequestModel.meet!.duration = "";
    sesssionStartRequestModel.meet!.password = "";
    sesssionStartRequestModel.meet!.settings!.audio = "both";
    sesssionStartRequestModel.meet!.settings!.calendarType = 2;
    sesssionStartRequestModel.meet!.settings!.contactEmail = "";
    sesssionStartRequestModel.meet!.settings!.contactName =
        await Get.find<AuthController>().getUserName();
    sesssionStartRequestModel.meet!.settings!.hostVideo = true;
    sesssionStartRequestModel.meet!.settings!.muteUponEntry = false;
    sesssionStartRequestModel.meet!.settings!.joinBeforeHost = true;
    sesssionStartRequestModel.meet!.startTime = "";
    sesssionStartRequestModel.meet!.timezone = "";
    sesssionStartRequestModel.meet!.type = 2;

    startSession(sesssionStartRequestModel, requestController);
  }
}
