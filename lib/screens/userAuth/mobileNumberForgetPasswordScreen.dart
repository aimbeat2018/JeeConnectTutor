
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/custom_snackbar.dart';
import 'package:jeeconnecttutor/controllers/authController.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';
import 'forgetPasswordOtpScreen.dart';


class MobileNumberForgetPasswordScreen extends StatefulWidget {
  static const String routeName = '/mobileNumberForgetPassword';

  const MobileNumberForgetPasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => MobileNumberForgetPasswordScreenState();
}

class MobileNumberForgetPasswordScreenState extends State<MobileNumberForgetPasswordScreen> {
  GlobalKey<FormState> mobileFormKey = GlobalKey<FormState>();

  final _mobileController = TextEditingController();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  @override
  void initState() {
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
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
                  color: Colors.black),
                const SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15),
                  child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Column(
                          children: [
                            Text(
                              'Forgot Password',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Form(
                                key: mobileFormKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                        focusNode: _focusNodes[0],
                                        controller: _mobileController,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [LengthLimitingTextInputFormatter(
                                            10),],
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
                                            BorderRadius.circular(15.0),
                                            borderSide: const BorderSide(
                                              color: kYellowColor,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            borderSide: const BorderSide(
                                              color: kBlueDarkColor,
                                              // width: 1.0,
                                            ),
                                          ),
                                          border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: const EdgeInsets.only(
                                              top: 12, bottom: 12, left: 15),
                                          labelText: TextConstant.mobile_number,
                                          labelStyle: Theme
                                              .of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(color: Colors.black),
                                        ),
                                        onSaved: (String? value) {
                                          // This optional block of code can be used to run
                                          // code when the user saves the form.
                                        },
                                        validator: validateMobile
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // GestureDetector(
                                    //   onTap: () => _mobileVerification(),
                                    //   child: Align(
                                    //     alignment: Alignment.center,
                                    //     child: Text(
                                    //       TextConstant.proceed,
                                    //       style: Theme
                                    //           .of(context)
                                    //           .textTheme
                                    //           .titleLarge!
                                    //           .copyWith(
                                    //           color: Colors.redAccent),
                                    //     ),
                                    //   ),
                                    // ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(kPrimaryColor),
                                      ),
                                      onPressed: () {
                                        _mobileVerification(_mobileController.text.toString());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'Send OTP',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    // const Padding(
                                    //   padding: EdgeInsets.only(
                                    //       left: 130,
                                    //       top: 5,
                                    //       right: 130,
                                    //       bottom: 5),
                                    //   child: Divider(
                                    //       thickness: 1,
                                    //       height: 0.5,
                                    //       color: Colors.purple),
                                    // )
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

  _mobileVerification(String mobile) {
    if (mobileFormKey.currentState!.validate()) {
      Get.find<AuthController>().forgotsendOtp(mobile: mobile).then((
          model) async {
        if (model!.status == '200') {
          showCustomSnackBar(model.message!);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ForgetPasswordOtpScreen(
                      _mobileController.text.toString(),model!.otp!)));
        }
        else{
          showCustomSnackBar('Mobile number not registered');
        }
      });
    }
   /* if (mobileFormKey.currentState!.validate()) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              ForgetPasswordOtpScreen(
                  _mobileController.text.toString())));
    }*/
  }
}
