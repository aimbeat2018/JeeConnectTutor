import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/controllers/authController.dart';
import 'package:jeeconnecttutor/screens/userAuth/loginScreen.dart';
import 'package:provider/provider.dart';
import '../../constant/colorsConstant.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';
import '../home/mainScreen.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/forgetPassword';
  String? mobile;

  ChangePasswordScreen(this.mobile, {super.key});

  @override
  State<StatefulWidget> createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool hidePassword = true;
  bool hideReEnterPassword = true;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white70),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Text(
                              TextConstant.changepassword,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.black),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Form(
                                key: updatePasswordFormKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      focusNode: _focusNodes[0],
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              hidePassword = !hidePassword;
                                            });
                                          },
                                          color: kPrimaryColor,
                                          icon: Icon(hidePassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined),
                                        ),
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
                                      validator: (input) => input!.length < 3
                                          ? "Password should be more than 3 characters"
                                          : null,
                                      obscureText: hidePassword,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      focusNode: _focusNodes[1],
                                      controller: _confirmPasswordController,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              hideReEnterPassword =
                                                  !hideReEnterPassword;
                                            });
                                          },
                                          color: kPrimaryColor,
                                          icon: Icon(hideReEnterPassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined),
                                        ),
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
                                        labelText: TextConstant.confirmPassword,
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.black),
                                      ),
                                      onSaved: (String? value) {
                                        // This optional block of code can be used to run
                                        // code when the user saves the form.
                                      },
                                      validator: (input) => input!.length < 3
                                          ? "Password should be more than 3 characters"
                                          : input !=
                                                  _passwordController.text
                                                      .toString()
                                              ? "Password didn't match"
                                              : null,
                                      obscureText: hideReEnterPassword,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                kPrimaryColor),
                                      ),
                                      onPressed: () {
                                        if (_passwordController.text.isEmpty ||
                                            _confirmPasswordController
                                                .text.isEmpty) {
                                          GlobalFunctions.showErrorDialog(
                                              "Enter both passwords", context);
                                        } else if (_passwordController.text
                                                .toString() ==
                                            _confirmPasswordController.text
                                                .toString()) {

                                          _changePassword(widget.mobile!,
                                              _passwordController.text);
                                        } else {
                                          GlobalFunctions.showErrorDialog(
                                              "Both passwords didn't match",
                                              context);
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Set Password',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
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

  _changePassword(String? mobile, String password) async {
    if (updatePasswordFormKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        Get.find<AuthController>()
            .changePassword(mobile!, password!)
            .then((model) async {
          if (model!.status == '200') {
            Navigator.pop(context);
            showCustomSnackBar(model!.message!);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
          } else {
            showCustomSnackBar(model!.message!);
          }
        });
      } on HttpException {
        var errorMsg = 'Auth failed';
        GlobalFunctions.showErrorDialog(errorMsg, context);
      } catch (error) {
        print(error);
        String errorMsg = error.toString();

        GlobalFunctions.showErrorDialog(errorMsg, context);
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      GlobalFunctions.showErrorDialog(
          "Enter valid login credentials!", context);
    }
  }
}
