import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../controllers/authController.dart';

class OtpScreen extends StatefulWidget {
  final String? email;
  final String? phone;
  final String? password;
  final String? pincode;
  final String? firstName;
  final String? lastName;
  final String? grade;
  final String? subjects;
  final String? board;
  final String? address;
  final String? adhar;
  final String? pan;
  final String? bankname;
  final String? holdername;
  final String? accountNo;
  final String? ifsc;
  final String? referralCode;
  final String? otp;
  final String? modeOfTeachingSelected;
  final XFile? resume;

  const OtpScreen(
      {super.key,
      this.email,
      this.phone,
      this.password,
      this.pincode,
      this.firstName,
      this.lastName,
      this.grade,
      this.subjects,
      this.board,
      this.address,
      this.adhar,
      this.pan,
      this.bankname,
      this.holdername,
      this.accountNo,
      this.ifsc,
      this.referralCode,
      this.otp,
  this.modeOfTeachingSelected,
      this.resume});

  @override
  State<StatefulWidget> createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool _isLoading = false;
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> controls;
  int numberOfFields = 4;
  bool clearText = false;

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
              backgroundColor: otpColor,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
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
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: 25,
                                  color: Colors.white,
                                )),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              TextConstant.otp_verification.toUpperCase(),
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 0),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Column(children: [
                                Image.asset(
                                  'assets/images/otp.png',
                                  height: 250,
                                  width: 250,
                                ),
                                Text(
                                  'Dear customer, use this One Time Password\n${widget.phone!} to log in to your account.\nThis OTP will be valid for the next 5 mins.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                OtpTextField(
                                  numberOfFields: numberOfFields,
                                  borderColor: Colors.white,
                                  focusedBorderColor: primaryColor,
                                  clearText: clearText,
                                  showFieldAsBox: true,
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  cursorColor: Colors.white,
                                  onCodeChanged: (String value) {
                                    //Handle each value
                                  },
                                  handleControllers: (controllers) {
                                    //get all textFields controller, if needed
                                    controls = controllers;
                                  },
                                  onSubmit: (String verificationCode) {
                                    if (verificationCode == "") {
                                      showCustomSnackBar("Enter OTP");
                                    } else if (verificationCode != widget.otp) {
                                      showCustomSnackBar("Enter valid OTP");
                                    } else {
                                      registerUser(authController);
                                    }

                                    //set clear text to clear text from all fields56
                                    // setState(() {
                                    //   clearText = true;
                                    // });
                                    // //navigate to different screen code goes here
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return AlertDialog(
                                    //       title: Text("Verification Code"),
                                    //       content: Text(
                                    //           'Code entered is $verificationCode'),
                                    //     );
                                    //   },
                                    // );
                                  }, // end onSubmit
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: authController.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              left: 80.0,
                                              top: 35.0,
                                              right: 80.0,
                                              bottom: 15.0),
                                          child: MaterialButton(
                                            elevation: 0,
                                            color: Colors.white,
                                            onPressed: () {
                                              String userEnterCode = "";
                                              for (var string in controls) {
                                                userEnterCode += string!.text;
                                              }

                                              if (userEnterCode == "") {
                                                showCustomSnackBar("Enter OTP");
                                              } else if (userEnterCode !=
                                                  widget.otp) {
                                                showCustomSnackBar(
                                                    "Enter valid OTP");
                                              } else {
                                                registerUser(authController);
                                              }
                                            },
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(20),
                                              // side: const BorderSide(color: kRedColor),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Text(
                                                  'Verify',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.blueAccent,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ),
                                const SizedBox(height: 20),
                              ]),
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

  void registerUser(AuthController authController) {
    authController
        .registerUser(
            firstName: widget.firstName,
            lastName: widget.lastName,
        phone: widget.phone,
        email: widget.email,
        address: widget.address,
        password: widget.password,
        pincode: widget.pincode,
        adhar: widget.adhar,
        pan: widget.pan,
        bankname: widget.bankname,
      holdername: widget.holdername,
        accountNo: widget.accountNo,
        ifsc: widget.ifsc,
        referralCode: widget.referralCode,
        board: widget.board,
        grade: widget.grade,
        subjects: widget.subjects,
      resume: widget.resume,
        modeOfTeachingSelected: widget.modeOfTeachingSelected,
    )
        .then((model) async {
      if (model!.status == "200") {
        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Add Your Details'),
            content: const Text(
                'Registration successful!, Please wait, We are verifying your profile...'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Get.offNamed(RouteHelper.getLoginRoute());
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showCustomSnackBar('Error while registration');
      }
    });
  }
}
