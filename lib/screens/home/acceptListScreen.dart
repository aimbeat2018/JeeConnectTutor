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

class AcceptListScreen extends StatefulWidget {
  static const String name = 'home';

  const AcceptListScreen({super.key});

  @override
  State<StatefulWidget> createState() => AcceptListScreenState();
}

class AcceptListScreenState extends State<AcceptListScreen>
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
                          TextFormField(
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
                          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    const TextSpan(
                      text: 'Student name : ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: model.studentName,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ])),
              InkWell(
                onTap: () {
                  _launchCaller(model.studentPhone!);
                },
                child: const Icon(
                  Icons.phone,
                ),
              )
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
                const TextSpan(
                  text: 'Student Address : ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: model.studentAddress,
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
                const TextSpan(
                  text: 'Subject : ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: model.courseName,
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
                const TextSpan(
                  text: 'Date & Time : ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${model.date} ${model.time}',
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
                const TextSpan(
                  text: 'Day & Shift : ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${model.day} ${model.shift}',
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
                const TextSpan(
                  text: 'Status :  ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: model.status == "1"
                      ? 'Accepted'
                      : model.status == "3"
                          ? 'Started'
                          : model.status == "4"
                              ? 'Ended'
                              : 'Completed',
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ])),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                elevation: 0,
                color: kYellowColor,
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
                  color: Colors.red,
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
