import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/controllers/paymentController.dart';
import 'package:jeeconnecttutor/model/commonResponseModel.dart';
import 'package:jeeconnecttutor/model/completedSessionsListResponseModel.dart';
import 'package:jeeconnecttutor/model/updateProfileResponseModel.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';

class PaymentScreen extends StatefulWidget {
  static const String name = 'paymentScreen';

  const PaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen>
    with TickerProviderStateMixin {
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  double totalAmount = 0.0;

  CompletedSessionsListResponseModel?
  completedSessionsListResponseModelData;

  @override
  void initState() {
    super.initState();
    CheckInternet.initConnectivity().then((value) =>
        setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          CheckInternet.updateConnectionStatus(result).then((value) =>
              setState(() {
                _connectionStatus = value;
              }));
        });

    getPayment();
  }

  Future<void> getPayment() async {
    if (_connectionStatus != AppConstants.connectivityCheck) {
      completedSessionsListResponseModelData =
      await Get.find<PaymentController>().getCompletedSessionsList();

      /*  if (completedSessionsListResponseModelData != null) {
        for (var completedSession in completedSessionsListResponseModelData!) {
          double value = (completedSession.courseCount!).toDouble() *
              double.parse(completedSession.coursePrice!.toString());
          totalAmount += value;
        }
      }*/
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = "";

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<PaymentController>(builder: (paymentController) {
      return Scaffold(
          key: _scaffoldKey,
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: kYellowColor,
            iconTheme: IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: const Text(
              'Payment',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                tooltip: 'Notifications',
                onPressed: () {},
              ),
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: 'weekly',
                      child: Text(
                        'Weekly',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'Monthly',
                      child: Text(
                        'Monthly',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'custom',
                      child: Text(
                        'Custom',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    )
                  ];
                },
                color: Colors.white,
                onSelected: (String value) async {
                  /* if (value == "extraSessions") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExtraSessionsScreen(),
                    ));
              } else if (value == "history") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TutorListingScreen(),
                    ));
              } else if (value == "scheduleContent") {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TodaysSessionScreen(),
                ));
              } */
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Completed Session's",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      paymentController.isLoading
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : paymentController.completedSessionsListResponseModel!.data==null || paymentController
                          .completedSessionsListResponseModel!
                          .data!.isEmpty
                          ? Container(
                        height:
                        MediaQuery
                            .of(context)
                            .size
                            .height /
                            1.5,
                        child: const Center(
                            child:
                            Text("No request data found")),
                      )
                          : Container(
                        child: ListView.separated(
                          itemCount: paymentController
                              .completedSessionsListResponseModel!
                              .data!.length,
                          physics:
                          const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context,
                              int index) {
                            return itemData(paymentController.completedSessionsListResponseModel!.data![index],paymentController);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment:Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0),
                          child: Text(
                            'Total Payment : Rs. ${paymentController.completedSessionsListResponseModel!.walletdetails![0].wallet!}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0),
                          child: Text(
                            'Completed Payment : Rs. ${paymentController.completedSessionsListResponseModel!.walletdetails![0].useWallet!}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0),
                          child: Text(
                            'Pending Payment : Rs. ${paymentController.completedSessionsListResponseModel!.walletdetails![0].pendingWallet!}',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          textStyle: const TextStyle(fontSize: 14)),
                      onPressed: () {
                        requestForPayment(paymentController.completedSessionsListResponseModel!.walletdetails![0].pendingWallet!);
                      },
                      child: const Text('Request for payment',style: TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }

  Future<void> requestForPayment(String total_Amount) async {
    if (_connectionStatus != AppConstants.connectivityCheck) {
      UpdateProfileResponseModel? updateProfileResponseModel;
      updateProfileResponseModel = await Get.find<PaymentController>().requestPayment(total_Amount);
      if (updateProfileResponseModel!.status == 401) {
        Navigator.pop(context);
        showCustomSnackBar('Payment request placed successfully',
            isError: false);
      }
    }
  }

  Widget itemData(Data model, PaymentController paymentController) {
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
                          text: 'Date : ',
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: model.day!+ ' '+model.date!,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ])),
            ),
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
                        text: 'Start Time : ',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: '${model.startTime}',
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
                    text: 'End Time : ',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    // text: '${model.purchaseDate} ${model.purchaseDate}',
                    text: '${model.endTime}',
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
                    text: 'Subject name : ',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    /* text: 'Board: ${model.boardName}' +
                      ' Grade: ${model.gradeName}' +
                      ' Subject: ${model.subjectName!}',*/
                    text: model.subject,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ])),
        const SizedBox(
          height: 3,
        ),

        // RichText(
        //     text: TextSpan(
        //         style: const TextStyle(
        //             color: Colors.black,
        //             fontSize: 14,
        //             fontWeight: FontWeight.w500),
        //         children: <TextSpan>[
        //           TextSpan(
        //             text: 'No.of chapters : ',
        //             style: const TextStyle(
        //                 fontSize: 14, fontWeight: FontWeight.bold),
        //           ),
        //           TextSpan(
        //             // text: '${model.purchaseDate} ${model.purchaseDate}',
        //             text: '${model.noOfChapters}',
        //             style: const TextStyle(
        //                 fontSize: 14, fontWeight: FontWeight.w500),
        //           ),
        //         ])),
        // const SizedBox(
        //   height: 3,
        // ),
        // if(model!.session!.isNotEmpty)
        //   RichText(
        //       text: TextSpan(
        //           style: const TextStyle(
        //               color: Colors.black,
        //               fontSize: 14,
        //               fontWeight: FontWeight.w500),
        //           children: <TextSpan>[
        //             TextSpan(
        //               text: 'Start Date & Time : ',
        //               style: const TextStyle(
        //                   fontSize: 14, fontWeight: FontWeight.bold),
        //             ),
        //             TextSpan(
        //               // text: '${model.purchaseDate} ${model.purchaseDate}',
        //               text: '${model.session![0].date!} ${model.session![0].time!}',
        //               style: const TextStyle(
        //                   fontSize: 14, fontWeight: FontWeight.w500),
        //             ),
        //           ])),
        // const SizedBox(
        //   height: 3,
        // ),
        // RichText(
        //     text: TextSpan(
        //         style: const TextStyle(
        //             color: Colors.black,
        //             fontSize: 14,
        //             fontWeight: FontWeight.w500),
        //         children: <TextSpan>[
        //           TextSpan(
        //             text: 'Duration : ',
        //             style: const TextStyle(
        //                 fontSize: 14, fontWeight: FontWeight.bold),
        //           ),
        //           TextSpan(
        //             // text: '${model.purchaseDate} ${model.purchaseDate}',
        //             text: '${model.duration}',
        //             style: const TextStyle(
        //                 fontSize: 14, fontWeight: FontWeight.w500),
        //           ),
        //         ])),
        // const SizedBox(
        //   height: 3,
        // ),
        // RichText(
        //     text: TextSpan(
        //         style: const TextStyle(
        //             color: Colors.black,
        //             fontSize: 14,
        //             fontWeight: FontWeight.w500),
        //         children: <TextSpan>[
        //           TextSpan(
        //             text: 'Mode of teaching : ',
        //             style: const TextStyle(
        //                 fontSize: 14, fontWeight: FontWeight.bold),
        //           ),
        //           TextSpan(
        //             text: '${model.modeOfTeaching}',
        //             style: const TextStyle(
        //                 fontSize: 14, fontWeight: FontWeight.w500),
        //           ),
        //         ])),
        // const SizedBox(
        //   height: 3,
        // ),
        // RichText(
        //     text: TextSpan(
        //         style: const TextStyle(
        //             color: Colors.black,
        //             fontSize: 14,
        //             fontWeight: FontWeight.w500),
        //         children: <TextSpan>[
        //           TextSpan(
        //             text: 'Status :  ',
        //             style: const TextStyle(
        //                 fontSize: 14, fontWeight: FontWeight.bold),
        //           ),
        //           TextSpan(
        //             text: 'Pending',
        //             style: const TextStyle(
        //                 fontSize: 14, fontWeight: FontWeight.w500),
        //           ),
        //         ])),
        // SizedBox(
        //   height: 10,
        // ),

      ],
    ),
    );
  }
}
