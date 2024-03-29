import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/route_helper.dart';
import 'package:jeeconnecttutor/controllers/authController.dart';
import 'package:jeeconnecttutor/controllers/requestController.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../model/tutorRequestModel.dart';

class AcceptedSessionsListingScreen extends StatefulWidget {
  static const String name = 'acceptedSessionsListing';

  const AcceptedSessionsListingScreen({super.key});

  @override
  State<StatefulWidget> createState() => AcceptedSessionsListingScreenState();
}

class AcceptedSessionsListingScreenState extends State<AcceptedSessionsListingScreen>
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

    if (mounted) {
      Get.find<RequestController>().getSessionRequestList(
          userid: Get.find<AuthController>().getUserId(), flag: '1');
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
            'Accepted Session',
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
                    userid: Get.find<AuthController>().getUserId(),flag: '1');
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

  _launchCaller(String number) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: number,
    );
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
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
                      text: 'Accepted',
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
/*
              MaterialButton(
                elevation: 0,
                color: Colors.green,
                onPressed: () {
                  acceptRequest(model.packageId!, requestController);
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
*/
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
            ],
          )
        ],
      ),
    );
  }


  void cancelRequest(String id, RequestController requestController) {
    requestController
        .cancelRequest(id, Get.find<AuthController>().getUserToken())
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
