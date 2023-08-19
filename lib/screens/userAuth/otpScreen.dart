import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/screens/userAuth/updateProfileScreen.dart';

import '../home/mainScreen.dart';

Color accentPurpleColor = Color(0xFF6A53A1);
Color primaryColor = Color(0xFF121212);
Color accentPinkColor = Color(0xFFF99BBD);
Color accentDarkGreenColor = Color(0xFF115C49);
Color accentYellowColor = Color(0xFFFFB612);
Color accentOrangeColor = Color(0xFFEA7A3B);

class OtpScreen extends StatefulWidget {
  static const String name = 'otp';

  const OtpScreen({super.key});

  @override
  State<StatefulWidget> createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool _isLoading = false;
  late List<TextStyle?> otpTextStyles;
  late List<TextEditingController?> controls;
  int numberOfFields = 5;
  bool clearText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: otpColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    TextConstant.otp_verification.toUpperCase(),
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headlineSmall!
                        .copyWith(color: Colors.white),
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
                          'Dear customer, use this One Time Password\n'
                          '(+91 7208 602 603) to log in to your account.\n'
                          'This OTP will be valid for the next 5 mins.',
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
                            //set clear text to clear text from all fields56
                            setState(() {
                              clearText = true;
                            });
                            //navigate to different screen code goes here
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Verification Code"),
                                  content:
                                      Text('Code entered is $verificationCode'),
                                );
                              },
                            );
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
  }

  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.headline3?.copyWith(color: color);
  }

  void _submit() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UpdateProfileScreen(),
    ));
  }
}
