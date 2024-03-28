import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/custom_snackbar.dart';
import 'package:jeeconnecttutor/repository/authRepo.dart';
import 'package:provider/provider.dart';

import '../../constant/app_constants.dart';
import '../../constant/globalFunction.dart';
import '../../constant/textConstant.dart';
import '../../controllers/authController.dart';
import '../../model/updateProfileResponseModel.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static const String routeName = '/updatePassword';

  const UpdatePasswordScreen({super.key});

  @override
  State<StatefulWidget> createState() => UpdatePasswordScreenState();
}

class UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  GlobalKey<FormState> updatePasswordFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  UpdateProfileResponseModel? updateProfileResponseModel;
  bool hidePassword = true;
  bool hideReEnterPassword = true;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    _focusNodes.forEach((node) {
      node.addListener(() {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      appBar: AppBar(
        backgroundColor: kYellowColor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: const Text(
          'Change Password',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      child: Container(
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
                                            color: kRedColor,
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
                                            color: kRedColor,
                                            // width: 1.0,
                                          ),
                                        ),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        contentPadding: const EdgeInsets.only(
                                            top: 12, bottom: 12, left: 15),
                                        labelText:
                                        TextConstant.confirmPassword,
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
                                    GestureDetector(
                                      onTap: () async {
                                        if (_passwordController.text
                                            .toString() ==
                                            _confirmPasswordController.text
                                                .toString()) {
                                          _changePassword(Get.find<AuthController>().getUserMobile(),
                                              _passwordController.text);
                                        }else{
                                          GlobalFunctions.showErrorDialog("Both passwords didn't match", context);

                                        }
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          TextConstant.changepassword,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                              color: Colors.redAccent),
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
  }

  String? validateMobile(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value!.length == 0) {
      return 'Enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter valid mobile number';
    }
    return null;
  }

  Future<void> _changePassword(String mobile, String password) async {
    if (_connectionStatus != AppConstants.connectivityCheck) {
      updateProfileResponseModel= await Get.find<AuthController>()
          .changePassword(mobile, password);
      if(updateProfileResponseModel!.status==200){
        Navigator.pop(context);

        showCustomSnackBar(
            'Password changed successfully!');
      }else{
        showCustomSnackBar(
            'Something went wrong!', isError: true);

      }
    }
  }
}
