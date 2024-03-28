import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/controllers/paymentController.dart';
import 'package:jeeconnecttutor/model/commonResponseModel.dart';
import 'package:jeeconnecttutor/model/completedSessionsListResponseModel.dart';
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

  List<CompletedSessionsListResponseModel>?
      completedSessionsListResponseModelData;

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

    getPayment();
  }

  Future<void> getPayment() async {
    if (_connectionStatus != AppConstants.connectivityCheck) {
      completedSessionsListResponseModelData =
          await Get.find<PaymentController>().getCompletedSessionsList();

      if (completedSessionsListResponseModelData != null) {
        for (var completedSession in completedSessionsListResponseModelData!) {
          double value = (completedSession.courseCount!).toDouble() *
              double.parse(completedSession.coursePrice!.toString());
          totalAmount += value;
        }
      }
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
                                : paymentController
                                        .completedSessionsListResponseModel!
                                        .isEmpty
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.5,
                                        child: const Center(
                                            child:
                                                Text("No request data found")),
                                      )
                                    : Container(
                                        child: ListView.builder(
                                            itemCount: paymentController
                                                .completedSessionsListResponseModel!
                                                .length,
                                            physics:
                                                const ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Card(
                                                    color: Colors.primaries[
                                                        Random().nextInt(Colors
                                                            .primaries.length)],
                                                    child: ListTile(
                                                      title: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            paymentController
                                                                .completedSessionsListResponseModel![
                                                                    index]
                                                                .courseName!,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            'Total charge : ₹${paymentController.completedSessionsListResponseModel![index].coursePrice! * paymentController.completedSessionsListResponseModel![index].courseCount!}',
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    15.0),
                                                        child: Text(
                                                          'Total no of sessions -> ${paymentController.completedSessionsListResponseModel![index].courseCount!}',
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )),
                                              );
                                            }),
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
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Text(
                                  'Total Payment : ${totalAmount.toString()}',
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
                              requestForPayment(totalAmount.toString());
                            },
                            child: const Text('Request for payment'),
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
      CommonResponseModel? commonResponseModel;
      commonResponseModel =
          await Get.find<PaymentController>().requestPayment(total_Amount);
      if (commonResponseModel!.status == 401) {
        Navigator.pop(context);
        showCustomSnackBar('Payment request placed successfully',
            isError: false);
      }
    }
  }
}
