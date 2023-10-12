import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../controllers/authController.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _refferalCodeController = TextEditingController();

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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 25,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            TextConstant.registration.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: kRedColor),
                          ),
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
                                      TextConstant.register,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(color: Colors.black),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Form(
                                        child: Column(
                                      children: [
                                        TextFormField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                            // suffixIcon: Icon(
                                            //   Icons.phone,
                                            //   size: 20,
                                            //   color: _focusNodes[0].hasFocus
                                            //       ? kYellowColor
                                            //       : kRedColor,
                                            // ),

                                            // hintText: 'What do people call you?',
                                            // isDense: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kYellowColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kRedColor,
                                                // width: 1.0,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                            labelText: TextConstant.name,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                          onSaved: (String? value) {
                                            // This optional block of code can be used to run
                                            // code when the user saves the form.
                                          },
                                          validator: (String? value) {
                                            return (value != null &&
                                                    value == "")
                                                ? 'Enter name'
                                                : null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: _emailController,
                                          decoration: InputDecoration(
                                            // suffixIcon: Icon(
                                            //   Icons.lock,
                                            //   size: 20,
                                            //   color:
                                            //       FocusScope.of(context).isFirstFocus
                                            //           ? kYellowColor
                                            //           : kRedColor,
                                            // ),
                                            // hintText: 'What do people call you?',
                                            // isDense: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kYellowColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kRedColor,
                                                // width: 1.0,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                            labelText: TextConstant.email,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                          onSaved: (String? value) {
                                            // This optional block of code can be used to run
                                            // code when the user saves the form.
                                          },
                                          validator: (String? value) {
                                            return (value != null &&
                                                    value == "")
                                                ? 'Enter mobile'
                                                : null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: _mobileController,
                                          decoration: InputDecoration(
                                            // suffixIcon: Icon(
                                            //   Icons.lock,
                                            //   size: 20,
                                            //   color:
                                            //       FocusScope.of(context).isFirstFocus
                                            //           ? kYellowColor
                                            //           : kRedColor,
                                            // ),
                                            // hintText: 'What do people call you?',
                                            // isDense: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kYellowColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kRedColor,
                                                // width: 1.0,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                            labelText:
                                                TextConstant.mobile_number,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                          onSaved: (String? value) {
                                            // This optional block of code can be used to run
                                            // code when the user saves the form.
                                          },
                                          validator: (String? value) {
                                            return (value != null &&
                                                    value == "")
                                                ? 'Enter mobile'
                                                : null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                            // suffixIcon: Icon(
                                            //   Icons.lock,
                                            //   size: 20,
                                            //   color:
                                            //       FocusScope.of(context).isFirstFocus
                                            //           ? kYellowColor
                                            //           : kRedColor,
                                            // ),
                                            // hintText: 'What do people call you?',
                                            // isDense: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kYellowColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kRedColor,
                                                // width: 1.0,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                            labelText: TextConstant.password,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                          onSaved: (String? value) {
                                            // This optional block of code can be used to run
                                            // code when the user saves the form.
                                          },
                                          validator: (String? value) {
                                            return (value != null &&
                                                    value.contains('@'))
                                                ? 'Do not use the @ char.'
                                                : null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          controller:
                                              _confirmPasswordController,
                                          decoration: InputDecoration(
                                            // suffixIcon: Icon(
                                            //   Icons.lock,
                                            //   size: 20,
                                            //   color:
                                            //       FocusScope.of(context).isFirstFocus
                                            //           ? kYellowColor
                                            //           : kRedColor,
                                            // ),
                                            // hintText: 'What do people call you?',
                                            // isDense: true,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kYellowColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kRedColor,
                                                // width: 1.0,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                            labelText:
                                                TextConstant.confirmPassword,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: _pincodeController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kYellowColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kRedColor,
                                                // width: 1.0,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                            labelText: TextConstant.pincode,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          controller: _refferalCodeController,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kYellowColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                color: kRedColor,
                                                // width: 1.0,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    top: 12,
                                                    bottom: 12,
                                                    left: 15),
                                            labelText: TextConstant.referralCode,
                                            labelStyle: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(color: Colors.black),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        authController.isLoading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  if (_nameController
                                                      .text.isEmpty) {
                                                    showCustomSnackBar(
                                                        "Enter name");
                                                  } else if (_emailController
                                                      .text.isEmpty) {
                                                    showCustomSnackBar(
                                                        ("Enter email Id"));
                                                  } else if (!GetUtils.isEmail(
                                                      _emailController.text)) {
                                                    showCustomSnackBar(
                                                        ("Enter valid email Id"));
                                                  } else if (_mobileController
                                                      .text.isEmpty) {
                                                    showCustomSnackBar(
                                                        ("Enter mobile number"));
                                                  } else if (_mobileController
                                                          .text.length !=
                                                      10) {
                                                    showCustomSnackBar(
                                                        ("Enter valid mobile number"));
                                                  } else if (_passwordController
                                                      .text.isEmpty) {
                                                    showCustomSnackBar(
                                                        ("Enter password"));
                                                  } else if (_passwordController
                                                          .text !=
                                                      _confirmPasswordController
                                                          .text) {
                                                    showCustomSnackBar(
                                                        ("Password and confirm password should be same"));
                                                  } else if (_pincodeController
                                                      .text.isEmpty) {
                                                    showCustomSnackBar(
                                                        ("Enter pincode"));
                                                  } else if (_pincodeController
                                                          .text.length !=
                                                      6) {
                                                    showCustomSnackBar(
                                                        ("Enter valid pin code"));
                                                  } else {
                                                    sendOtp(authController);
                                                  }
                                                },
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    TextConstant.sign_up,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge!
                                                        .copyWith(
                                                            color: Colors
                                                                .redAccent),
                                                  ),
                                                ),
                                              ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 130,
                                              top: 5,
                                              right: 130,
                                              bottom: 5),
                                          child: Divider(
                                              thickness: 1,
                                              height: 0.5,
                                              color: Colors.purple),
                                        )
                                      ],
                                    ))
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
            );
          });
  }

  void sendOtp(AuthController authController) {
    authController
        .sendRegisterOtp(phone: _mobileController.text)
        .then((model) async {
      if (model!.status == 200) {
        if(_refferalCodeController.text.isEmpty) {
          Get.toNamed(RouteHelper.getOtpScreenRoute(
              _nameController.text,
              _emailController.text,
              _mobileController.text,
              _passwordController.text,
              _confirmPasswordController.text,
              _pincodeController.text,
              model.otp.toString(),
              ""));
        }else if(_refferalCodeController.text.isNotEmpty||_refferalCodeController.text.trim()=="") {
          Get.toNamed(RouteHelper.getOtpScreenRoute(
              _nameController.text,
              _emailController.text,
              _mobileController.text,
              _passwordController.text,
              _confirmPasswordController.text,
              _pincodeController.text,
              model.otp.toString(),
              _refferalCodeController.text));
        }
      } else {
        showCustomSnackBar('Mobile number already exists');
      }
    });
  }
}
