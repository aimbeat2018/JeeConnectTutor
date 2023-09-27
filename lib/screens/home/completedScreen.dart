import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/controllers/authController.dart';
import 'package:jeeconnecttutor/controllers/requestController.dart';
import 'package:jeeconnecttutor/screens/home/requestListWidget.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';

class CompletedScreen extends StatefulWidget {
  static const String name = 'home';

  const CompletedScreen({super.key});

  @override
  State<StatefulWidget> createState() => CompletedScreenState();
}

class CompletedScreenState extends State<CompletedScreen>
    with TickerProviderStateMixin {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
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
    Get.find<RequestController>().getCompletedTutorRequestList(
        Get.find<AuthController>().getUserToken());
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
                          SizedBox(
                            height: 20,
                          ),
                          requestController.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : requestController.completedTutorRequestList ==
                                      null
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.5,
                                      child: Center(
                                          child: Text("No request data found")),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: requestController
                                          .completedTutorRequestList!.length,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return RequestListWidget(
                                            model: requestController
                                                    .completedTutorRequestList![
                                                index]);
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
            );
          });
  }
}
