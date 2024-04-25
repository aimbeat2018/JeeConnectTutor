import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/custom_snackbar.dart';
import 'package:jeeconnecttutor/constant/route_helper.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../constant/app_constants.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../controllers/authController.dart';
import '../../controllers/requestController.dart';

class PackageDetailScreen extends StatefulWidget {
  static const String routeName = '/packageDetail';
  final String? packageid;

  const PackageDetailScreen({super.key, required this.packageid});

  @override
  State<StatefulWidget> createState() => PackageDetailScreenState();
}

class PackageDetailScreenState extends State<PackageDetailScreen>
    with TickerProviderStateMixin {
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
    if (_connectionStatus != AppConstants.connectivityCheck) {
      Get.find<RequestController>()
          .getPackageDetails(packageid: widget.packageid);
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<RequestController>(builder: (requestController) {
            return Scaffold(
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                backgroundColor: kYellowColor,
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                centerTitle: true,
                title: Text(
                  '${requestController.tutorRequestModel!.data![0].subjectName!}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              body: requestController.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : requestController.tutorRequestModel!.data!.isEmpty
                      ? Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: Center(child: Text("No request data found")),
                        )
                      : SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* const Center(
                                  child: Text(
                                    'Package Details',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),*/
                                /*  Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 15),
                                  child: Center(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: Stack(
                                        children: [
                                        */ /*  Image.asset(
                                            'assets/images/blue_rectangle.png',
                                            fit: BoxFit.cover,
                                            height: 70,
                                            width: 380,
                                          ),*/ /*
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              */ /* Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 25),
                                                child: Text(
                                                  'Rs. 49,999/-',
                                                  style: TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),*/ /*
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 25),
                                                child: Text(
                                                  '${requestController.tutorRequestModel!.data![0].subjectName!}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),*/
                                requestController.tutorRequestModel!.data![0].session!.isNotEmpty?
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Text(
                                    'Session List :' /*.toUpperCase()*/,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ):SizedBox(),
/*
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                        children: [
                                          Text(
                                            'Subject Name',
                                            maxLines: 3,
                                            style: TextStyle(
                                                color:
                                                kTextLowBlackColor,
                                                fontSize: 14,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),
                                          Text(
                                            'Date & Time',
                                            maxLines: 3,
                                            style: TextStyle(
                                                color:
                                                kTextLowBlackColor,
                                                fontSize: 14,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),

                                        ],
                                      ),
*/
                                requestController.tutorRequestModel!.data![0].session!.isNotEmpty?
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 25),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: requestController
                                        .tutorRequestModel!
                                        .data![0]
                                        .session!
                                        .length,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.toNamed(RouteHelper.getSessionDetailsScreenRoute(
                                              requestController
                                                  .tutorRequestModel!
                                                  .data![0]
                                                  .session![
                                              index]
                                                  .sessionId!,
                                              requestController
                                                  .tutorRequestModel!
                                                  .data![0]
                                                  .packageId!,
                                              requestController
                                                  .tutorRequestModel!
                                                  .data![0]
                                                  .session![index].toString()!));
                                        },
                                        child: Card(
                                          semanticContainer: true,
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                //I assumed you want to occupy the entire space of the card
                                                image: AssetImage(
                                                  'assets/images/blue_rectangle.png',
                                                ),
                                              ),
                                            ),
                                            child: ListTile(
                                              title: IntrinsicHeight(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          requestController
                                                              .tutorRequestModel!
                                                              .data![0]
                                                              .session![index]
                                                              .subject!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        const SizedBox(
                                                          height: 1,
                                                        ),
                                                        Text(
                                                          requestController
                                                              .tutorRequestModel!
                                                              .data![0]
                                                              .session![index]
                                                              .date!,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 60.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: <Widget>[
                                                          Text(
                                                            requestController
                                                                .tutorRequestModel!
                                                                .data![0]
                                                                .session![index]
                                                                .time!,
                                                            softWrap: true,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .yellow),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ):SizedBox(),
                                 SizedBox(
                                  height: requestController.tutorRequestModel!.data![0].session!.isNotEmpty?
                                  20:0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /*Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Text(
                                              'Subject Name : ${requestController.tutorRequestModel!.data![0].subjectName!}' */ /*.toUpperCase()*/ /*,
                                              style: TextStyle(
                                                  color: kBlueDarkColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ),*/
                                      Text(
                                        'No. of Chapters : ${requestController.tutorRequestModel!.data![0].noOfChapters!}' /*.toUpperCase()*/,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: requestController
                                              .tutorRequestModel!
                                              .data![0]
                                              .chapterlist!
                                              .length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 1.0),
                                                    child: Row(
                                                      children: [
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Container(
                                                              width: 5.0,
                                                              height: 5.0,
                                                              decoration: const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .black54),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 6,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            requestController
                                                                .tutorRequestModel!
                                                                .data![0]
                                                                .chapterlist![
                                                                    index]
                                                                .chapters!,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color:
                                                                    kTextLowBlackColor,
                                                                fontSize: 14,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Course Duration :${requestController.tutorRequestModel!.data![0].duration!} ' /*.toUpperCase()*/,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        'No. of Sessions : ${requestController.tutorRequestModel!.data![0].noOfSession!}' /*.toUpperCase()*/,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      requestController.tutorRequestModel!.data![0].session!.isNotEmpty?
                                      Text(
                                        'Session Start Date : ${requestController.tutorRequestModel!.data![0].session![0].date!}' /*.toUpperCase()*/,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ):Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                                        child: Text(
                                          'Session has not been created by student - ${requestController.tutorRequestModel!.data![0].studentName!}' /*.toUpperCase()*/,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),

                                      // Text(
                                      //   'Requirements :' /*.toUpperCase()*/,
                                      //   style: TextStyle(
                                      //       color: Colors.black,
                                      //       fontSize: 15,
                                      //       fontWeight: FontWeight.w700),
                                      // ),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      // Html(
                                      //   data: 'Notebook\nPen\nMobile',
                                      // ),
                                      // Container(
                                      //   height: 100,
                                      //   child: Flexible(
                                      //     child: ReadMoreText(
                                      //       'Lorem ipsum dolor sit amet, consectetur adipiscing e'
                                      //       'lit,Lorem ipsum dolor sit amet, consectetur adipi'
                                      //       'scing elit,Lorem ipsum dolor sit amet, consectetur.'
                                      //       ' adipiscing eliet, consectetur adipiscing elit,'
                                      //       'Lorem ipsum dolor sit amet, consectetur adipiscing eli'
                                      //       'et, consectetur adipiscing elit,Lorem ipsum dolo'
                                      //       'r sit amet, consectetur adipiscing eliLorem '
                                      //       'ipsum dolor sit amet, consectetur adipiscing eli'
                                      //       't,Lorem ipsum dolor sit amet, consectetur adipis'
                                      //       'cing elit,Lorem ipsum dolor sit amet, consectetu'
                                      //       'r adipiscing eliet, consectetur adipiscing elit,'
                                      //       'Lorem ipsum dolor sit amet, consectetur adipiscing'
                                      //       ' eliet, co'
                                      //       'nsectetur adipiscing elit,Lorem ipsum dolor sit ame'
                                      //       't, consectetur adipiscing eliLorem '
                                      //       'ipsum dolor sit amet, consectetur adipiscing e'
                                      //       'lit,Lorem ipsum dolor sit amet, consectetur adipi'
                                      //       'scing elit,Lorem ipsum dolor sit amet, consectetur.'
                                      //       ' adipiscing eliet, consectetur adipiscing elit,'
                                      //       'Lorem ipsum dolor sit amet, consectetur adipiscing eli'
                                      //       'et, consectetur adipiscing elit,Lorem ipsum dolo'
                                      //       'r sit amet, consectetur adipiscing eliLorem '
                                      //       'ipsum dolor sit amet, consectetur adipiscing eli'
                                      //       't,Lorem ipsum dolor sit amet, consectetur adipis'
                                      //       'cing elit,Lorem ipsum dolor sit amet, consectetu'
                                      //       'r adipiscing eliet, consectetur adipiscing elit,'
                                      //       'Lorem ipsum dolor sit amet, consectetur adipiscing'
                                      //       ' eliet, co'
                                      //       'nsectetur adipiscing elit,Lorem ipsum dolor sit ame'
                                      //       't, consectetur adipiscing eli',
                                      //       trimLines: 10,
                                      //       style: TextStyle(
                                      //           color: Colors.black54,
                                      //           fontStyle: FontStyle.normal,
                                      //           fontWeight: FontWeight.normal,
                                      //           fontSize: 12),
                                      //       colorClickableText: Colors.pink,
                                      //       trimMode: TrimMode.Line,
                                      //       trimCollapsedText: ' view details',
                                      //       trimExpandedText: ' show less',
                                      //       moreStyle: TextStyle(
                                      //           fontSize: 12,
                                      //           fontWeight: FontWeight.normal,
                                      //           color: Colors.blue),
                                      //       textAlign: TextAlign.center,
                                      //     ),
                                      //   ),
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceAround,
                                      //   children: [
                                      //     Center(
                                      //       child: ElevatedButton(
                                      //         onPressed: () {
                                      //           // selectImages();
                                      //           // Navigator.of(context).push(MaterialPageRoute(
                                      //           //   builder: (context) =>
                                      //           //       GroupStudyConfirmedPageScreen(),
                                      //           // ));
                                      //         },
                                      //         style: ElevatedButton.styleFrom(
                                      //           backgroundColor: Colors.green,
                                      //         ),
                                      //         child: const Text('ACCEPT',
                                      //             style: TextStyle(
                                      //                 fontWeight:
                                      //                     FontWeight.bold)),
                                      //       ),
                                      //     ),
                                      //     Center(
                                      //       child: ElevatedButton(
                                      //         onPressed: () {
                                      //           // selectImages();
                                      //           // Navigator.of(context).push(MaterialPageRoute(
                                      //           //   builder: (context) =>
                                      //           //       GroupStudyConfirmedPageScreen(),
                                      //           // ));
                                      //         },
                                      //         style: ElevatedButton.styleFrom(
                                      //           backgroundColor:
                                      //               Colors.redAccent,
                                      //         ),
                                      //         child: const Text('DECLINE',
                                      //             style: TextStyle(
                                      //                 fontWeight:
                                      //                     FontWeight.bold)),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      // const SizedBox(
                                      //   height: 5,
                                      // )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
            );
          });
  }
}
