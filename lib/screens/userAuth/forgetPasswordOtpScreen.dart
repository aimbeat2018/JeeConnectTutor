import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';
import '../home/mainScreen.dart';
import 'changePasswordScreen.dart';

class ForgetPasswordOtpScreen extends StatefulWidget {
  static const String routeName = '/forgetPasswordOtp';
  String? mobile,otp;

  ForgetPasswordOtpScreen(this.mobile,this.otp,{super.key});

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
                  const SizedBox(height: 40),
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
                          height: 250,
                          width: 250,
                        ),
                        Text(
                          'Dear customer, use this One Time Password\n(+91 )${widget.mobile} to log in to your account.\nThis OTP will be valid for the next 5 mins.',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 50,
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
                            verificationOtp=value;
                            //Handle each value
                          },
                          handleControllers: (controllers) {
                            //get all textFields controller, if needed
                            controls = controllers;
                          },
                          onSubmit: (String verificationCode) {
                            //set clear text to clear text from all fields56
                           // clearText = true;
                            verificationOtp=verificationCode;
                           /* setState(() {

                            });*/
                          }, // end onSubmit
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
     if (widget.otp==verificationOtp) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ChangePasswordScreen(
                widget.mobile)));
    } else {
      GlobalFunctions.showErrorDialog("Enter valid OTP", context);
    }
   /* Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MainScreen(),
    ));*/
  }

  // Future<String?> _otp(String mobile) async {
  //   // setState(() {
  //   //   _isLoading = true;
  //   // });
  //   try {
  //     v_otp =
  //         await Provider.of<AuthProvider>(context, listen: false).forgetPasswordotp(mobile);
  //     verificationOtp = v_otp;
  //     print("OTP$mobile");
  //
  //     return v_otp;
  //   } on HttpException {
  //     return null;
  //   } catch (error) {
  //     // print(error);
  //     return null;
  //   }
  // }
  void getOtp() async {
  //  v_otp = await _otp(widget.mobile!);
    if (v_otp == "0") {
      GlobalFunctions.showWarningToast("Account with this mobile number doesn't exists");
      Navigator.pop(context);
    }
    // print(v_otp!.toString());
    // GlobalFunctions.showSuccessToast(v_otp!);
  }
}
