import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/controllers/authController.dart';
import 'package:jeeconnecttutor/screens/userAuth/updatePasswordScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../constant/textConstant.dart';

class ProfileScreen extends StatefulWidget {
  static const String name = 'profile';

  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool hidePassword = true;
  final _nameController = TextEditingController();
  final userIdController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _kycController = TextEditingController();

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
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

    Get.find<AuthController>()
        .getProfile(Get.find<AuthController>().getUserToken());
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<AuthController>(builder: (authController) {
            if (authController.profileViewModel != null) {
              _nameController.text = authController.profileViewModel!.name!;
              _mobileController.text = authController.profileViewModel!.phone!;
              _emailController.text = authController.profileViewModel!.email!;
              userIdController.text =
                  authController.profileViewModel!.uniqueCode!;
            }
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                backgroundColor: kYellowColor,
                automaticallyImplyLeading: true,
                centerTitle: true,
                title: const Text(
                  'Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              body: authController.isLoading ||
                      authController.profileViewModel == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            TextFormField(
                                              focusNode: _focusNodes[0],
                                              enabled: false,
                                              controller: _nameController,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                    color: kYellowColor,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                    color: kRedColor,
                                                    // width: 1.0,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                contentPadding: EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                                labelText: TextConstant.name,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              focusNode: _focusNodes[1],
                                              controller: userIdController,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                    color: kYellowColor,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                    color: kRedColor,
                                                    // width: 1.0,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                contentPadding: EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                                labelText: TextConstant.userId,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              focusNode: _focusNodes[2],
                                              controller: _mobileController,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                    color: kYellowColor,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                    color: kRedColor,
                                                    // width: 1.0,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                contentPadding: EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                                labelText:
                                                    TextConstant.mobile_number,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            TextFormField(
                                              focusNode: _focusNodes[3],
                                              enabled: false,
                                              controller: _emailController,
                                              decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                    color: kYellowColor,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                    color: kRedColor,
                                                    // width: 1.0,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20))),
                                                contentPadding: EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                                labelText: TextConstant.email,
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                        MaterialButton(
                                          elevation: 0,
                                          color: kYellowColor,
                                          onPressed: () {
                                            Get.toNamed(RouteHelper
                                                .getUpdateProfileScreenRoute(
                                                    authController
                                                        .getUserToken(),
                                                    authController.getUserId(),
                                                    "update"));
                                          },
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10),
                                            // side: const BorderSide(color: kRedColor),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'View Other Details',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        MaterialButton(
                                          elevation: 0,
                                          color: kYellowColor,
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => const UpdatePasswordScreen(),
                                            ));
                                          },
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10),
                                            // side: const BorderSide(color: kRedColor),
                                          ),
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Change Password',
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
                                    ),
                                  ),
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
