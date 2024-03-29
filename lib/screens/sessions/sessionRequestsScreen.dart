import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/route_helper.dart';
import 'package:jeeconnecttutor/controllers/authController.dart';
import 'package:jeeconnecttutor/controllers/requestController.dart';
import 'package:jeeconnecttutor/screens/groupStudy/packageDetailsScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../model/tutorRequestModel.dart';

class SessionRequestsScreen extends StatefulWidget {
  static const String name = 'sessionRequests';

  SessionRequestsScreen({super.key});

  @override
  State<StatefulWidget> createState() => SessionRequestsScreenState();
}

class SessionRequestsScreenState extends State<SessionRequestsScreen>
    with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

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
    if (_connectionStatus != AppConstants.connectivityCheck) {
      Get.find<RequestController>().getSessionRequestList(
          userid: Get.find<AuthController>().getUserId(), flag: '0');
    }
  }

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
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                centerTitle: true,
                title: Text(
                  'Session Requests',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              body: SafeArea(
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  onRefresh: () async {
                    if (_connectionStatus != AppConstants.connectivityCheck) {
                      Get.find<RequestController>().getSessionRequestList(
                          userid: Get.find<AuthController>().getUserId(),flag: '0');
                    }
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /* TextFormField(
                        controller: searchController,
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                  color: primaryColor, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                  color: primaryColor, width: 1),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            hintText: 'Search',
                            suffixIcon: Icon(
                              CupertinoIcons.search,
                              size: 28,
                            )),
                        keyboardType: TextInputType.text,
                        // onChanged: (value) {
                        //   onSearchTextChanged(value);
                        // },
                        // onChanged: onSearchTextChanged,
                      ),
                      SizedBox(
                        height: 0,
                      ),*/
                            requestController.isLoading
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : requestController
                                .tutorRequestModel!.data==null || requestController
                                        .tutorRequestModel!.data!.isEmpty
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.5,
                                        child: Center(
                                            child:
                                                Text("No request data found")),
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        itemCount: requestController
                                            .tutorRequestModel!.data!.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return itemData(
                                              requestController
                                                  .tutorRequestModel!
                                                  .data![index],
                                              requestController);
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider();
                                        },
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
  }

  Widget itemData(Data model, RequestController requestController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Student name : ',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: model.studentName,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ])),
              ),
              RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                    TextSpan(
                      text: model.purchaseDate,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ])),
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                    TextSpan(
                      text: 'Board : ',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: model.boardName,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ])),
              RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                    TextSpan(
                      text: 'Grade : ',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: model.gradeName,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ])),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Subject name : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  /* text: 'Board: ${model.boardName}' +
                      ' Grade: ${model.gradeName}' +
                      ' Subject: ${model.subjectName!}',*/
                  text: model.subjectName,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'No. of sessions : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  // text: '${model.purchaseDate} ${model.purchaseDate}',
                  text: '${model.noOfSession}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'No.of chapters : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  // text: '${model.purchaseDate} ${model.purchaseDate}',
                  text: '${model.noOfChapters}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          if(model!.session!.isNotEmpty)
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Start Date & Time : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  // text: '${model.purchaseDate} ${model.purchaseDate}',
                  text: '${model.session![0].date!} ${model.session![0].time!}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Duration : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  // text: '${model.purchaseDate} ${model.purchaseDate}',
                  text: '${model.duration}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Mode of teaching : ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${model.modeOfTeaching}',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 3,
          ),
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                TextSpan(
                  text: 'Status :  ',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Pending',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                elevation: 0,
                color: Colors.green,
                onPressed: () {
                  acceptRequest(model.packagePurchaseId!, requestController);
                },
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  // side: const BorderSide(color: kRedColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    requestController.isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Accept',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ),
/*
              MaterialButton(
                elevation: 0,
                color: accentCanvasColor,
                onPressed: () {
                  //  declineRequest(model.packageId!, requestController);
                  // Navigator.of(context).push(MaterialPageRoute(builder:(context)=> PackageDetailScreen()));
                  Get.toNamed(
                      RouteHelper.getPackageDetailsRoute(model.packageId!));
                },
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  // side: const BorderSide(color: kRedColor),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
*/
            ],
          )
        ],
      ),
    );
  }

  void acceptRequest(String id, RequestController requestController) {
    requestController
        .acceptRequest(id, Get.find<AuthController>().getUserId())
        .then((model) async {
      if (model!.status != '403') {
        showCustomSnackBar(model.message!);
        requestController.getSessionRequestList(
            userid: Get.find<AuthController>().getUserId(), flag: '0');
        setState(() {});
      } else {
        showCustomSnackBar(model.message!);
      }
    });
  }

  void declineRequest(String id, RequestController requestController) {
    requestController
        .declineRequest(id, Get.find<AuthController>().getUserToken())
        .then((model) async {
      if (model!.status != 403) {
        showCustomSnackBar(model.message!);
        requestController
            .getTutorRequestList(Get.find<AuthController>().getUserToken());
        setState(() {});
      } else {
        showCustomSnackBar(model.message!);
      }
    });
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class SessionRequestsScreen extends StatefulWidget {
  static const String name = 'sessionRequests';

  const SessionRequestsScreen({super.key});

  @override
  State<StatefulWidget> createState() => SessionRequestsScreenState();
}

class SessionRequestsScreenState extends State<SessionRequestsScreen>
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
        title: const Text(
          'Session Requests',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Container(
                child: Column(children: [
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
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xff22996c),
                                  Color(0xff53b058),
                                  Color(0xff77bf49),
                                  Color(0xff9ed139)
                                ]),
                                // color: const Color(0xff3e4982),
                                */
/*image: DecorationImage(
                                                                fit: BoxFit.cover,
                                                                image: NetworkImage(
                                                                    "https://miro.medium.com/max/1400/1*-6WdIcd88w3pfphHOYln3Q.png"),
                                                                colorFilter: new ColorFilter.mode(
                                                                    Colors.black.withOpacity(0.19), BlendMode.dstATop),
                                                              ),*/
/*

                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12))),
                          ),
                          Positioned(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Center(
                                    child: Text(
                                      'Tutors Details',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text(
                                        'Pranjal Deshmukh',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'Location - Vashi, Navi Mumbai',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        'FRENCH',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        '80 Lessons',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      new LinearPercentIndicator(
                                        width: 140.0,
                                        lineHeight: 11.0,
                                        percent: 0.5,
                                        trailing: new Text(
                                          "51%",
                                          style: const TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        backgroundColor: const Color(0xff8fca3f),
                                        progressColor: Colors.white,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        '21 June 2023',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        '09:00 AM - 10:00 AM',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'Session Type - Online',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text(
                                        'Session Link - https://www.google.co.in/',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
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
              )),
              SizedBox(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 15,
                      color: Colors.white,
                      shadowColor: Colors.blue.shade900,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, bottom: 18, right: 20, left: 20),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              'assets/images/pin.png',
                              height: 65,
                              width: 65,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Sessions Begin Once You\nSubmits The Otp.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            OtpTextField(
                              numberOfFields: 4,
                              borderColor: Colors.white,
                              focusedBorderColor: Colors.blue.shade900,
                              fillColor: Colors.blue.shade900,
                              clearText: clearText,
                              showFieldAsBox: true,
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                              cursorColor: Colors.white,
                              onCodeChanged: (String value) {
                                //Handle each value
                              },
                              handleControllers: (controllers) {
                                //get all textFields controller, if needed
                                controls = controllers;
                              },
                              onSubmit: (String verificationCode) {
                                //set clear text to clear text from all fields56
                                setState(() {
                                  clearText = true;
                                });
                                //navigate to different screen code goes here
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Verification Code"),
                                      content: Text(
                                          'Code entered is $verificationCode'),
                                    );
                                  },
                                );
                              }, // end onSubmit
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade900,
                                  textStyle: const TextStyle(fontSize: 14)),
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => const SessionDetailsScreen(),
                                // ));
                              },
                              child: const Text('Submit'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Resend otp?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color: Colors.blue.shade900,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ])),
          ),
        ),
      ),
    );
  }
}
*/
