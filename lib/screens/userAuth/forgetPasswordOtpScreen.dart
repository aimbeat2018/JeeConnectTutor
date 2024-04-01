import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';
import '../../controllers/authController.dart';
import '../home/mainScreen.dart';
import 'changePasswordScreen.dart';

class ForgetPasswordOtpScreen extends StatefulWidget {
  static const String routeName = '/forgetPasswordOtp';
  String? mobile, otp;

  ForgetPasswordOtpScreen(this.mobile, this.otp, {super.key});

  @override
  State<StatefulWidget> createState() => ForgetPasswordOtpScreenState();
}

class ForgetPasswordOtpScreenState extends State<ForgetPasswordOtpScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String? v_otp = "", verificationOtp = "";
  final bool _isLoading = false;
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> controls;
  int numberOfFields = 4;
  bool clearText = false;

  @override
  void initState() {
    super.initState();
    getOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: otpColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_outlined),
                      color: Colors.white),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(children: [
                        Text(
                          TextConstant.verification_code.toUpperCase(),
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headlineSmall!
                              .copyWith(color: Colors.white),
                        ),
                        Image.asset(
                          'assets/images/otp.png',
                          height: 230,
                          width: 250,
                        ),
                        Text(
                          'Dear customer, use this One Time Password\n(+91 ) ${widget.mobile} to log in to your account.\nThis OTP will be valid for the next 5 mins.',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        OtpTextField(
                          numberOfFields: numberOfFields,
                          borderColor: Colors.white,
                          focusedBorderColor: kStarColor,
                          clearText: clearText,
                          showFieldAsBox: true,
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          cursorColor: Colors.white,
                          onCodeChanged: (String value) {
                            verificationOtp = value;
                            //Handle each value
                          },
                          handleControllers: (controllers) {
                            //get all textFields controller, if needed
                            controls = controllers;
                          },
                          onSubmit: (String verificationCode) {
                            //set clear text to clear text from all fields56
                            // clearText = true;
                            verificationOtp = verificationCode;
                            /* setState(() {

                            });*/
                          }, // end onSubmit
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 80.0,
                                      top: 35.0,
                                      right: 80.0,
                                      bottom: 15.0),
                                  child: MaterialButton(
                                    elevation: 0,
                                    color: Colors.white,
                                    onPressed: _submit,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(20),
                                      // side: const BorderSide(color: kBlueDarkColor),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
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
                        const Text(
                          'Didnt received a Verifcation Code?',
                          style: TextStyle(color: Colors.white),
                        ),
                        InkWell(
                            onTap: () {
                              _mobileVerification(widget.mobile!);
                            },
                            child: Text(
                              'Resend again',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            )),
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
  }

  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.displaySmall?.copyWith(color: color);
  }

  void _submit() {
    if (widget.otp == verificationOtp) {
      showCustomSnackBar('OTP Verified!');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChangePasswordScreen(widget.mobile)));
    } else {
      GlobalFunctions.showErrorDialog("Enter valid OTP", context);
    }
  }

  _mobileVerification(String mobile) {
    Get.find<AuthController>()
        .forgotsendOtp(mobile: mobile)
        .then((model) async {
      if (model!.status == '200') {
        showCustomSnackBar(model.message!);
        // showCustomSnackBar('Otp send to your registered mobile number');
        widget.otp = model!.otp;
        setState(() {});
      } else {
        showCustomSnackBar('Mobile number not registered');
      }
    });
    /* if (mobileFormKey.currentState!.validate()) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ForgetPasswordOtpScreen(
                  _mobileController.text.toString())));
    }*/
  }

  void getOtp() async {
    //  v_otp = await _otp(widget.mobile!);
    if (v_otp == "0") {
      GlobalFunctions.showWarningToast(
          "Account with this mobile number doesn't exists");
      Navigator.pop(context);
    }
    // print(v_otp!.toString());
    // GlobalFunctions.showSuccessToast(v_otp!);
  }
}
