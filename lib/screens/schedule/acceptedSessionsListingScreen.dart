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
      Get.find<RequestController>().getAcceptedTutorRequestList(
          Get.find<AuthController>().getUserToken());
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
          centerTitle: true,
          title: const Text(
            'Schedule',
            style: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 15.0, horizontal: 10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                 /*   TextFormField(
                      controller: searchController,
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                            BorderSide(color: primaryColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12.0)),
                            borderSide:
                            BorderSide(color: primaryColor, width: 1),
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
                    const SizedBox(
                      height: 20,
                    ),*/
                    requestController.isLoading
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : requestController
                        .acceptedTutorRequestList!.isEmpty
                        ? SizedBox(
                      height:
                      MediaQuery.of(context).size.height /
                          1.5,
                      child: const Center(
                          child: Text("No request data found")),
                    )
                        : ListView.separated(
                      shrinkWrap: true,
                      itemCount: requestController
                          .acceptedTutorRequestList!.length,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemBuilder:
                          (BuildContext context, int index) {
                        return itemData(
                            requestController
                                .acceptedTutorRequestList![
                            index],
                            requestController);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  ],
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

  Widget itemData(
      TutorRequestModel model, RequestController requestController) {
    return GestureDetector(
      // onTap: () =>  Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => const SubjectListingScreen(),
      // )),
        child: SizedBox(
          height: 255,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
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
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              mainAxisAlignment: MainAxisAlignment
                                  .end,
                              children: [
                                Text(
                                  model.studentName!,
                                  textAlign: TextAlign
                                      .left,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight
                                        .normal,
                                    color: Colors
                                        .white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Location - ${model.studentAddress!}',
                                  textAlign: TextAlign
                                      .center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight
                                        .normal,
                                    color: Colors
                                        .white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  model.courseName!,
                                  textAlign: TextAlign
                                      .center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight
                                        .bold,
                                    color: Colors
                                        .white,
                                  ),
                                ),

                               /* SizedBox(
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
                                ),*/
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  model.date!,
                                  textAlign: TextAlign
                                      .center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight
                                        .normal,
                                    color: Colors
                                        .white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  model.time!,
                                  textAlign: TextAlign
                                      .center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight
                                        .normal,
                                    color: Colors
                                        .white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
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
                                /*SizedBox(
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
                                ),*/
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    MaterialButton(
                                      elevation: 0,
                                      color: Colors.grey,
                                      onPressed: () {
                                        Get.toNamed(
                                            RouteHelper.getSessionDetailsScreenRoute(model.id!));
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
                                            'View',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (model.status == "1")
                                      MaterialButton(
                                        elevation: 0,
                                        color: kDarkGreyColor,
                                        onPressed: () {
                                          cancelRequest(model.id!, requestController);
                                        },
                                        padding:
                                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadiusDirectional.circular(10),
                                          // side: const BorderSide(color: kRedColor),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Cancel',
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
