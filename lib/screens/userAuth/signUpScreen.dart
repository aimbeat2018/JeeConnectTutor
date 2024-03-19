import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../controllers/authController.dart';
import '../other/termsAndConditionScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _refferalCodeController = TextEditingController();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _gradeController = TextEditingController();
  final _addressController = TextEditingController();
  final _adharController = TextEditingController();
  final _panController = TextEditingController();
  final _banknameController = TextEditingController();
  final _holdernameController = TextEditingController();
  final _accountnoontroller = TextEditingController();
  final _ifscController = TextEditingController();

  String _connectionStatus = 'unKnown';
  String _referralcode = "";
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];
  bool termsChecked = false;
  List<String> genderList = ["Male", "Female", "Other"];
  String selectedGender = "Male";

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
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bg_image_login.jpg",),
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
                            padding: const EdgeInsets.only(top: 30.0, bottom: 100.0),
                            child: Image.asset(
                              'assets/images/white_logo.png',
                              height: 90,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 20),
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 15),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Text(
                                          TextConstant.sign_up,
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
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            2.6,
                                                        child: TextFormField(
                                                          focusNode: _focusNodes[0],
                                                          controller:
                                                          _firstNameController,
                                                          keyboardType: TextInputType.name,
                                                          style: TextStyle(
                                                              color: Colors.black),
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
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kYellowColor,
                                                              ),
                                                            ),
                                                            isDense: true,
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kBlueDarkColor,
                                                                // width: 1.0,
                                                              ),
                                                            ),
                                                            border:
                                                            const OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                        6))),
                                                            contentPadding:
                                                            const EdgeInsets.only(
                                                                top: 11,
                                                                bottom: 11,
                                                                left: 15),
                                                            labelText: 'First Name',
                                                            labelStyle: Theme.of(context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                color: Colors.black),
                                                          ),
                                                          onSaved: (String? value) {
                                                            // This optional block of code can be used to run
                                                            // code when the user saves the form.
                                                          },
                                                          validator: (String? value) {
                                                            return (value != null &&
                                                                value == "" &&
                                                                value.length < 3)
                                                                ? 'Enter valid first name'
                                                                : null;
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            2.6,
                                                        child: TextFormField(
                                                          focusNode: _focusNodes[1],
                                                          controller: _lastNameController,
                                                          keyboardType: TextInputType.name,
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                          decoration: InputDecoration(
                                                            isDense: true,
                                                            // suffixIcon: Icon(
                                                            //   Icons.lock,
                                                            //   size: 20,
                                                            //   color:
                                                            //       FocusScope.of(context).isFirstFocus
                                                            //           ? kYellowColor
                                                            //           : kBlueDarkColor,
                                                            // ),
                                                            // hintText: 'What do people call you?',
                                                            // isDense: true,
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kYellowColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kBlueDarkColor,
                                                                // width: 1.0,
                                                              ),
                                                            ),
                                                            border:
                                                            const OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                        6))),
                                                            contentPadding:
                                                            const EdgeInsets.only(
                                                                top: 11,
                                                                bottom: 11,
                                                                left: 15),
                                                            labelText: 'Last Name',
                                                            labelStyle: Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                color: Colors.black),
                                                          ),
                                                          onSaved: (String? value) {
                                                            // This optional block of code can be used to run
                                                            // code when the user saves the form.
                                                          },
                                                          validator: (String? value) {
                                                            return (value != null &&
                                                                value == "" &&
                                                                value.length < 3)
                                                                ? 'Enter valid last Name'
                                                                : null;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            2.6,
                                                        child: TextFormField(
                                                          focusNode: _focusNodes[2],
                                                          controller:
                                                          _mobileController,
                                                          keyboardType: TextInputType.name,
                                                          style: TextStyle(
                                                              color: Colors.black),
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
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kYellowColor,
                                                              ),
                                                            ),
                                                            isDense: true,
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kBlueDarkColor,
                                                                // width: 1.0,
                                                              ),
                                                            ),
                                                            border:
                                                            const OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                        6))),
                                                            contentPadding:
                                                            const EdgeInsets.only(
                                                                top: 11,
                                                                bottom: 11,
                                                                left: 15),
                                                            labelText: 'Mobile No.',
                                                            labelStyle: Theme.of(context)
                                                                .textTheme
                                                                .titleMedium!
                                                                .copyWith(
                                                                color: Colors.black),
                                                          ),
                                                          onSaved: (String? value) {
                                                            // This optional block of code can be used to run
                                                            // code when the user saves the form.
                                                          },
                                                          // validator: (String? value) {
                                                          //   return (value != null &&
                                                          //           value == "" &&
                                                          //           value.length < 3)
                                                          //       ? 'Enter valid father name'
                                                          //       : null;
                                                          // },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            2.6,
                                                        child: TextFormField(
                                                          focusNode: _focusNodes[3],
                                                          controller:
                                                          _emailController,
                                                          keyboardType: TextInputType.name,
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                          decoration: InputDecoration(
                                                            isDense: true,
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kYellowColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kBlueDarkColor,
                                                                // width: 1.0,
                                                              ),
                                                            ),
                                                            border:
                                                            const OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                        6))),
                                                            contentPadding:
                                                            const EdgeInsets.only(
                                                                top: 11,
                                                                bottom: 11,
                                                                left: 15),
                                                            labelText: 'Email',
                                                            labelStyle: Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                color: Colors.black),
                                                          ),
                                                          onSaved: (String? value) {
                                                            // This optional block of code can be used to run
                                                            // code when the user saves the form.
                                                          },
                                                          //   validator: (String? value) {
                                                          //     return (value != null &&
                                                          //             value == "" &&
                                                          //             value.length < 3)
                                                          //         ? 'Enter valid mother Name'
                                                          //         : null;
                                                          //   },
                                                          // ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                    child: TextFormField(
                                                      focusNode: _focusNodes[10],
                                                      controller: _addressController,
                                                      minLines: 3,
                                                      maxLines: 5,
                                                      keyboardType: TextInputType.streetAddress,
                                                      style: TextStyle(color: Colors.black),
                                                      decoration: InputDecoration(
                                                        // suffixIcon: Icon(
                                                        //   Icons.lock,
                                                        //   size: 20,
                                                        //   color:
                                                        //       FocusScope.of(context).isFirstFocus
                                                        //           ? kYellowColor
                                                        //           : kBlueDarkColor,
                                                        // ),
                                                        // hintText: 'What do people call you?',
                                                        // isDense: true,
                                                        focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(8.0),
                                                          borderSide: const BorderSide(
                                                            color: kYellowColor,
                                                          ),
                                                        ),
                                                        enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(8.0),
                                                          borderSide: const BorderSide(
                                                            color: kBlueDarkColor,
                                                            // width: 1.0,
                                                          ),
                                                        ),
                                                        border: const OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(
                                                                Radius.circular(8))),
                                                        contentPadding:
                                                        const EdgeInsets.only(
                                                            top: 11,
                                                            bottom: 11,
                                                            left: 15),
                                                        labelText: TextConstant.address,
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
                                                            value == "" &&
                                                            value.length < 10)
                                                            ? 'Enter valid address'
                                                            : null;
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            2,
                                                        child: TextFormField(
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
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            3.7,
                                                        child: TextFormField(
                                                          focusNode: _focusNodes[9],
                                                          controller: _pincodeController,
                                                          keyboardType: TextInputType.number,
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                          decoration: InputDecoration(
                                                            isDense: true,
                                                            // suffixIcon: Icon(
                                                            //   Icons.lock,
                                                            //   size: 20,
                                                            //   color:
                                                            //       FocusScope.of(context).isFirstFocus
                                                            //           ? kYellowColor
                                                            //           : kBlueDarkColor,
                                                            // ),
                                                            // hintText: 'What do people call you?',
                                                            // isDense: true,
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kYellowColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kBlueDarkColor,
                                                                // width: 1.0,
                                                              ),
                                                            ),
                                                            border:
                                                            const OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                        6))),
                                                            contentPadding:
                                                            const EdgeInsets.only(
                                                                top: 11,
                                                                bottom: 11,
                                                                left: 15),
                                                            labelText: 'Pin Code',
                                                            labelStyle: Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                color: Colors.black),
                                                          ),
                                                          onSaved: (String? value) {
                                                            // This optional block of code can be used to run
                                                            // code when the user saves the form.
                                                          },
                                                          validator: (String? value) {
                                                            return (value != null &&
                                                                value == "" &&
                                                                value.length < 3)
                                                                ? 'Enter valid pincode'
                                                                : null;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            2,
                                                        child: TextFormField(
                                                          focusNode: _focusNodes[9],
                                                          controller: _adharController,
                                                          keyboardType: TextInputType.number,
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                          decoration: InputDecoration(
                                                            isDense: true,
                                                            // suffixIcon: Icon(
                                                            //   Icons.lock,
                                                            //   size: 20,
                                                            //   color:
                                                            //       FocusScope.of(context).isFirstFocus
                                                            //           ? kYellowColor
                                                            //           : kBlueDarkColor,
                                                            // ),
                                                            // hintText: 'What do people call you?',
                                                            // isDense: true,
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kYellowColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kBlueDarkColor,
                                                                // width: 1.0,
                                                              ),
                                                            ),
                                                            border:
                                                            const OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                        6))),
                                                            contentPadding:
                                                            const EdgeInsets.only(
                                                                top: 11,
                                                                bottom: 11,
                                                                left: 15),
                                                            labelText: 'Aadhar Card No.',
                                                            labelStyle: Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                color: Colors.black),
                                                          ),
                                                          onSaved: (String? value) {
                                                            // This optional block of code can be used to run
                                                            // code when the user saves the form.
                                                          },
                                                          validator: (String? value) {
                                                            return (value != null &&
                                                                value == "" &&
                                                                value.length < 12)
                                                                ? 'Aadhar Card No.'
                                                                : null;
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            3.7,
                                                        child: TextFormField(
                                                          focusNode: _focusNodes[9],
                                                          controller: _panController,
                                                          keyboardType: TextInputType.number,
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                          decoration: InputDecoration(
                                                            isDense: true,
                                                            // suffixIcon: Icon(
                                                            //   Icons.lock,
                                                            //   size: 20,
                                                            //   color:
                                                            //       FocusScope.of(context).isFirstFocus
                                                            //           ? kYellowColor
                                                            //           : kBlueDarkColor,
                                                            // ),
                                                            // hintText: 'What do people call you?',
                                                            // isDense: true,
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kYellowColor,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  6.0),
                                                              borderSide:
                                                              const BorderSide(
                                                                color: kBlueDarkColor,
                                                                // width: 1.0,
                                                              ),
                                                            ),
                                                            border:
                                                            const OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                        6))),
                                                            contentPadding:
                                                            const EdgeInsets.only(
                                                                top: 11,
                                                                bottom: 11,
                                                                left: 15),
                                                            labelText: 'Pancard No.',
                                                            labelStyle: Theme.of(context)
                                                                .textTheme
                                                                .titleSmall!
                                                                .copyWith(
                                                                color: Colors.black),
                                                          ),
                                                          onSaved: (String? value) {
                                                            // This optional block of code can be used to run
                                                            // code when the user saves the form.
                                                          },
                                                          validator: (String? value) {
                                                            return (value != null &&
                                                                value == "" &&
                                                                value.length < 10)
                                                                ? 'Enter valid pancard no.'
                                                                : null;
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  TextFormField(
                                                    focusNode: _focusNodes[9],
                                                    controller: _banknameController,
                                                    keyboardType: TextInputType.text,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      // suffixIcon: Icon(
                                                      //   Icons.lock,
                                                      //   size: 20,
                                                      //   color:
                                                      //       FocusScope.of(context).isFirstFocus
                                                      //           ? kYellowColor
                                                      //           : kBlueDarkColor,
                                                      // ),
                                                      // hintText: 'What do people call you?',
                                                      // isDense: true,
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color: kYellowColor,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color: kBlueDarkColor,
                                                          // width: 1.0,
                                                        ),
                                                      ),
                                                      border:
                                                      const OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius
                                                                  .circular(
                                                                  6))),
                                                      contentPadding:
                                                      const EdgeInsets.only(
                                                          top: 11,
                                                          bottom: 11,
                                                          left: 15),
                                                      labelText: 'Enter Bank Name',
                                                      labelStyle: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                          color: Colors.black),
                                                    ),
                                                    onSaved: (String? value) {
                                                      // This optional block of code can be used to run
                                                      // code when the user saves the form.
                                                    },
                                                    validator: (String? value) {
                                                      return (value != null &&
                                                          value == "" &&
                                                          value.length < 12)
                                                          ? 'Bank Name'
                                                          : null;
                                                    },
                                                  ),
                                                  SizedBox(height: 15,),
                                                  TextFormField(
                                                    focusNode: _focusNodes[9],
                                                    controller: _holdernameController,
                                                    keyboardType: TextInputType.text,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      // suffixIcon: Icon(
                                                      //   Icons.lock,
                                                      //   size: 20,
                                                      //   color:
                                                      //       FocusScope.of(context).isFirstFocus
                                                      //           ? kYellowColor
                                                      //           : kBlueDarkColor,
                                                      // ),
                                                      // hintText: 'What do people call you?',
                                                      // isDense: true,
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color: kYellowColor,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color: kBlueDarkColor,
                                                          // width: 1.0,
                                                        ),
                                                      ),
                                                      border:
                                                      const OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius
                                                                  .circular(
                                                                  6))),
                                                      contentPadding:
                                                      const EdgeInsets.only(
                                                          top: 11,
                                                          bottom: 11,
                                                          left: 15),
                                                      labelText: 'Account Holder Name',
                                                      labelStyle: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                          color: Colors.black),
                                                    ),
                                                    onSaved: (String? value) {
                                                      // This optional block of code can be used to run
                                                      // code when the user saves the form.
                                                    },
                                                    validator: (String? value) {
                                                      return (value != null &&
                                                          value == "" &&
                                                          value.length < 10)
                                                          ? 'Enter Account Holder Name'
                                                          : null;
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),TextFormField(
                                                    focusNode: _focusNodes[9],
                                                    controller: _accountnoontroller,
                                                    keyboardType: TextInputType.text,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      // suffixIcon: Icon(
                                                      //   Icons.lock,
                                                      //   size: 20,
                                                      //   color:
                                                      //       FocusScope.of(context).isFirstFocus
                                                      //           ? kYellowColor
                                                      //           : kBlueDarkColor,
                                                      // ),
                                                      // hintText: 'What do people call you?',
                                                      // isDense: true,
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color: kYellowColor,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color: kBlueDarkColor,
                                                          // width: 1.0,
                                                        ),
                                                      ),
                                                      border:
                                                      const OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius
                                                                  .circular(
                                                                  6))),
                                                      contentPadding:
                                                      const EdgeInsets.only(
                                                          top: 11,
                                                          bottom: 11,
                                                          left: 15),
                                                      labelText: 'Account Number',
                                                      labelStyle: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                          color: Colors.black),
                                                    ),
                                                    onSaved: (String? value) {
                                                      // This optional block of code can be used to run
                                                      // code when the user saves the form.
                                                    },
                                                    validator: (String? value) {
                                                      return (value != null &&
                                                          value == "" &&
                                                          value.length < 12)
                                                          ? 'Enter Account Number'
                                                          : null;
                                                    },
                                                  ),
                                                  SizedBox(height: 15,),
                                                  TextFormField(
                                                    focusNode: _focusNodes[9],
                                                    controller: _ifscController,
                                                    keyboardType: TextInputType.text,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      // suffixIcon: Icon(
                                                      //   Icons.lock,
                                                      //   size: 20,
                                                      //   color:
                                                      //       FocusScope.of(context).isFirstFocus
                                                      //           ? kYellowColor
                                                      //           : kBlueDarkColor,
                                                      // ),
                                                      // hintText: 'What do people call you?',
                                                      // isDense: true,
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color: kYellowColor,
                                                        ),
                                                      ),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color: kBlueDarkColor,
                                                          // width: 1.0,
                                                        ),
                                                      ),
                                                      border:
                                                      const OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius
                                                                  .circular(
                                                                  6))),
                                                      contentPadding:
                                                      const EdgeInsets.only(
                                                          top: 11,
                                                          bottom: 11,
                                                          left: 15),
                                                      labelText: 'IFSC Code',
                                                      labelStyle: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall!
                                                          .copyWith(
                                                          color: Colors.black),
                                                    ),
                                                    onSaved: (String? value) {
                                                      // This optional block of code can be used to run
                                                      // code when the user saves the form.
                                                    },
                                                    validator: (String? value) {
                                                      return (value != null &&
                                                          value == "" &&
                                                          value.length < 10)
                                                          ? 'Enter IFSC code'
                                                          : null;
                                                    },
                                                  ),
                                                  SizedBox(height: 15,),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            termsChecked = !termsChecked;
                                                            setState(() {});
                                                          },
                                                          child: termsChecked
                                                              ? Icon(
                                                            Icons.check_box,
                                                            color: kPrimaryColor,
                                                            size: 22,
                                                          )
                                                              : Icon(
                                                            Icons
                                                                .check_box_outline_blank,
                                                            color: kPrimaryColor,
                                                            size: 22,
                                                          )),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                  TermsAndConditionScreen()));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(4.0),
                                                          child: RichText(
                                                            textAlign: TextAlign.center,
                                                            text: TextSpan(
                                                              // style: DefaultTextStyle.of(
                                                              //         context)
                                                              //     .style,
                                                              children: const <TextSpan>[
                                                                TextSpan(
                                                                    text: 'Agree to ',
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.black,
                                                                        fontSize: 11)),
                                                                TextSpan(
                                                                    text:
                                                                    'Terms and Conditions',
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.blue,
                                                                        fontSize: 11)),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
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
                                                      //_signup();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 70.0),
                                                      child: Text(
                                                        TextConstant.sign_up,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                      ],
                                    ),
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

  void sendOtp(AuthController authController) {
    authController
        .sendRegisterOtp(phone: _mobileController.text)
        .then((model) async {
      if (model!.status == 200) {
         Get.toNamed(RouteHelper.getOtpScreenRoute(
              _nameController.text,
              _emailController.text,
              _mobileController.text,
              _passwordController.text,
              _confirmPasswordController.text,
              _pincodeController.text,
             "1",
              model.otp.toString(),
              _referralcode));

      } else {
        showCustomSnackBar('Mobile number already exists');
      }
    });
  }
}
