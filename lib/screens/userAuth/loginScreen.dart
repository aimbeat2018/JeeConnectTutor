import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/screens/userAuth/signUpScreen.dart';

import '../home/homeScreen.dart';
import '../home/mainScreen.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    TextConstant.login.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: kRedColor),
                  ),
                  const SizedBox(height: 40),
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  TextConstant.student,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.black),
                                ),
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 20,
                                  color: Colors.black,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                              height: 0.5,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  TextConstant.parents,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.grey.shade800),
                                ),
                                Icon(Icons.check_circle_outline,
                                    size: 20, color: Colors.grey.shade800)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                                thickness: 1,
                                height: 0.5,
                                color: Colors.grey.shade800)
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 10),

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
                                TextConstant.sign_in,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: Colors.black),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Form(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        focusNode: _focusNodes[0],
                                        controller: _mobileController,
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
                                            borderSide: BorderSide(
                                              color: kYellowColor,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: kRedColor,
                                              // width: 1.0,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.only(
                                              top: 12, bottom: 12, left: 15),
                                          labelText: TextConstant.mobile_number,
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
                                      SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        focusNode: _focusNodes[1],
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
                                            borderSide: BorderSide(
                                              color: kYellowColor,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              color: kRedColor,
                                              // width: 1.0,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          contentPadding: EdgeInsets.only(
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
                                        validator: (String? value) {
                                          return (value != null &&
                                              value.contains('@'))
                                              ? 'Do not use the @ char.'
                                              : null;
                                        },
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          TextConstant.forget_password,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: Colors.black),
                                        ),
                                      ),SizedBox(
                                        height: 15,
                                      ),
                                      new InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) =>  MainScreen(),
                                          ));
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            TextConstant.login,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(color: Colors.redAccent),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 100,top:5, right:100, bottom:5),
                                        child: Divider(
                                            thickness: 1,
                                            height: 0.5,
                                            color: Colors.grey.shade800),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      new InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => const SignUpScreen(),
                                          ));
                                        },
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            TextConstant.sign_up,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge!
                                                .copyWith(color: Colors.redAccent),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 100,top: 5, right: 100, bottom:5),
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
      ),
    );
  }
}
