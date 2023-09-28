import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../controllers/authController.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'login';

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool _isLoading = false;
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  List<FocusNode> _focusNodes = [
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
  }

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<AuthController>(builder: (authController) {
            return Scaffold(
              backgroundColor: kBackgroundColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            TextConstant.login.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: kRedColor),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15),
                            child: Card(
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    children: [
                                      Text(
                                        TextConstant.sign_in,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Column(
                                        children: [
                                          TextFormField(
                                            controller: _mobileController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                  color: kYellowColor,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                  color: kRedColor,
                                                  // width: 1.0,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
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
                                            obscureText: true,
                                            controller: _passwordController,
                                            decoration: InputDecoration(
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                  color: kYellowColor,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                  color: kRedColor,
                                                  // width: 1.0,
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20))),
                                              contentPadding: EdgeInsets.only(
                                                  top: 12,
                                                  bottom: 12,
                                                  left: 15),
                                              labelText: TextConstant.password,
                                              labelStyle: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: Colors.black),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              TextConstant.forget_password,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      color: Colors.blueAccent),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          authController.isLoading
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    if (_mobileController
                                                            .text.isEmpty ||
                                                        _mobileController
                                                                .text.length !=
                                                            10) {
                                                      showCustomSnackBar(
                                                          TextConstant
                                                              .mobile_number,
                                                          isError: true);
                                                    } else if (_passwordController
                                                        .text.isEmpty) {
                                                      showCustomSnackBar(
                                                          TextConstant.password,
                                                          isError: true);
                                                    } else {
                                                      login(
                                                          _mobileController
                                                              .text,
                                                          _passwordController
                                                              .text,
                                                          authController);
                                                    }

                                                    // Navigator.of(context)
                                                    //     .push(MaterialPageRoute(
                                                    //   builder: (context) =>
                                                    //       MainScreen(),
                                                    // ));
                                                  },
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      TextConstant.login,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge!
                                                          .copyWith(
                                                              color: Colors
                                                                  .redAccent),
                                                    ),
                                                  ),
                                                ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 100,
                                                top: 5,
                                                right: 100,
                                                bottom: 5),
                                            child: Divider(
                                                thickness: 1,
                                                height: 0.5,
                                                color: Colors.grey.shade800),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.toNamed(RouteHelper
                                                  .getRegisterScreenRoute());
                                            },
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                TextConstant.sign_up,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge!
                                                    .copyWith(
                                                        color:
                                                            Colors.redAccent),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 100,
                                                top: 5,
                                                right: 100,
                                                bottom: 5),
                                            child: Divider(
                                                thickness: 1,
                                                height: 0.5,
                                                color: Colors.purple),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
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

  void login(String? mobile, String? password, AuthController authController) {
    authController
        .loginUser(phone: mobile, password: password)
        .then((model) async {
      if (model!.validity == 1) {
        if (model.profileUpdated == "1") {
          Get.offNamed(RouteHelper.getUpdateProfileScreenRoute(
              model.token!, model.userId!, "add"));
        } else if (model.profileUpdated == "2") {
          GlobalFunctions.showErrorDialog(
              "Your profile is in process please wait or login after some time",
              context);
        } else if (model.profileUpdated == "3") {
          Get.offNamed(RouteHelper.getMainScreenRoute());
        } else if (model.profileUpdated == "4") {
          GlobalFunctions.showErrorDialog(
              "Your profile is rejected please contact to customer care number",
              context);
        }
      } else {
        showCustomSnackBar('Enter valid details');
      }
    });
  }
}
