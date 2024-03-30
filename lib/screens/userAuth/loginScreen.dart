import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/screens/userAuth/forgetPasswordOtpScreen.dart';
import 'package:jeeconnecttutor/screens/userAuth/signUpScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../constant/shared_pref_helper.dart';
import '../../controllers/authController.dart';
import 'mobileNumberForgetPasswordScreen.dart';

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
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg_image_login.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    gradient1,
                                    gradient2,
                                  ],
                                )),
                            padding: const EdgeInsets.symmetric(vertical: 70.0),
                            child: Image.asset(
                              'assets/images/white_logo.png',
                              height: 110,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Positioned(
                            top: 180,
                            left: 0,
                            right: 0,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 40),
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 15),
                                      child: SizedBox(
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
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Form(
                                                key: globalFormKey,
                                                child: Column(
                                                  children: [
                                                    TextFormField(
                                                        focusNode: _focusNodes[0],
                                                        controller: _mobileController,
                                                        keyboardType: TextInputType.phone,
                                                        decoration: InputDecoration(
                                                          // suffixIcon: Icon(
                                                          //   Icons.phone,
                                                          //   size: 20,
                                                          //   color: _focusNodes[0].hasFocus
                                                          //       ? kYellowColor
                                                          //       : kBlueDarkColor,
                                                          // ),
                                                          // hintText: 'What do people call you?',
                                                          // isDense: true,
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                12.0),
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                12.0),
                                                          ),
                                                          border:
                                                          const OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      20))),
                                                          contentPadding:
                                                          const EdgeInsets.only(
                                                              top: 4,
                                                              bottom: 4,
                                                              left: 15),
                                                          labelText:
                                                          TextConstant.mobile_number,
                                                          labelStyle: Theme.of(context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                              color: Colors.grey),
                                                        ),
                                                        style: TextStyle(color: Colors.black),
                                                        onSaved: (String? value) {
                                                          // This optional block of code can be used to run
                                                          // code when the user saves the form.
                                                        },
                                                        validator: validateMobile
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    TextFormField(
                                                      focusNode: _focusNodes[1],
                                                      controller: _passwordController,
                                                      decoration: InputDecoration(
                                                        suffixIcon: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              hidePassword =
                                                              !hidePassword;
                                                            });
                                                          },
                                                          color: Colors.grey,
                                                          icon: Icon(hidePassword
                                                              ? Icons
                                                              .visibility_off_outlined
                                                              : Icons
                                                              .visibility_outlined),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(12.0),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(12.0),
                                                        ),
                                                        border: const OutlineInputBorder(
                                                            borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(20))),
                                                        contentPadding:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8,
                                                            left: 15),
                                                        labelText: TextConstant.password,
                                                        labelStyle: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(color: Colors.grey),

                                                      ),
                                                      style: TextStyle(color: Colors.black),
                                                      onSaved: (String? value) {
                                                        // This optional block of code can be used to run
                                                        // code when the user saves the form.
                                                      },
                                                      validator: (input) => input!
                                                          .length <
                                                          3
                                                          ? "Password should be more than 3 characters"
                                                          : null,
                                                      obscureText: hidePassword,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MobileNumberForgetPasswordScreen()));
                                                      },
                                                      child: Align(
                                                        alignment: Alignment.topRight,
                                                        child: Text(
                                                          TextConstant.forget_password,
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                              color: Colors.red),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    ElevatedButton(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Colors.black),
                                                      ),
                                                      onPressed: () {
                                                        globalFormKey.currentState!
                                                            .validate()
                                                            ? login(
                                                            _mobileController.text
                                                                .toString(),
                                                            _passwordController.text
                                                                .toString(),authController)
                                                            : GlobalFunctions
                                                            .showWarningToast(
                                                            "Enter Valid Credentials!");
                                                      },
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 30.0),
                                                        child: Text(
                                                          TextConstant.login,
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 17.0),
                                  child: Text(
                                    "OR",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                                  ),
                                  onPressed: () {
                                   Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => const SignUpScreen()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      TextConstant.sign_up,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
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
          });
  }

  Future<void> login(
      String? mobile, String? password, AuthController authController) async {
    authController
        .loginUser(
            phone: mobile,
            password: password,
           // role: "tutor",
            deviceToken: await FirebaseMessaging.instance.getToken())
        .then((model) async {
      if (model!.status == "200") {
        showCustomSnackBar(model!.msg!);
        Get.offNamed(RouteHelper.getMainScreenRoute());
      } else if (model!.status == "202") {
        showCustomSnackBar(model!.msg!);
      //  Get.offNamed(RouteHelper.getMainScreenRoute());
      }
      else {
        showCustomSnackBar('Enter valid details');
      }
    });
  }
  String? validateMobile(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return 'Enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter valid mobile number';
    }
    return null;
  }
}
