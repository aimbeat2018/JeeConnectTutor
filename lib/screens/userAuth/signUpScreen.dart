import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/model/modeOfTeachingModel.dart';
import 'package:jeeconnecttutor/model/request/gradeRequestModel.dart';
import 'package:jeeconnecttutor/model/response/boardsModel.dart';
import 'package:jeeconnecttutor/model/response/subjectResponseModel.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../controllers/authController.dart';
import '../../controllers/requestController.dart';
import '../../model/response/gradesModel.dart';
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
  final _subjectsController = TextEditingController();
  final _boardController = TextEditingController();
  final _addressController = TextEditingController();
  final _adharController = TextEditingController();
  final _panController = TextEditingController();
  final _banknameController = TextEditingController();
  final _holdernameController = TextEditingController();
  final _accountnoontroller = TextEditingController();
  final _ifscController = TextEditingController();
  final _referralCodeController = TextEditingController();

  String _connectionStatus = 'unKnown';
  String _referralcode = "";
  BoardsModel? boardsModel = BoardsModel();
  GradesModel? gradesModel = GradesModel();
  SubjectResponseModel? subjectResponseModel;
  String? selectedBoard;
  List<String>? gradesList = [];
  List<String>? gradesIdList = [];
  List<String> subjectsList = [];
  List<String> subjectsGradeList = [];
  List<ModeOfTeachingModel>? modeOfTeachingList;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
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
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

  bool termsChecked = false;
  final bool isBoardSelected = true;
  final bool isGradeSelected = false;
  final bool isSubjectSelected = false;
  GradeRequestModel? gradeRequestModel= GradeRequestModel();

  /// This is list of city which will pass to the drop down.
  final List<SelectedListItem> _listOfBoards = [];
  final List<SelectedListItem> _listOfGrades = [];
  final List<SelectedListItem> _listOfSubjects = [];

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
    getBoards();
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
                  child: Column(

                    children: [
                      Column(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                            Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/bg_image_login.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 20),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                    child: SingleChildScrollView(
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
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2.6,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[0],
                                                                controller:
                                                                _firstNameController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .name,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  isDense: true,
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'First Name',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (String?
                                                                value) {
                                                                  return (value !=
                                                                      null &&
                                                                      value ==
                                                                          "" &&
                                                                      value.length <
                                                                          3)
                                                                      ? 'Enter valid first name'
                                                                      : null;
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2.6,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[1],
                                                                controller:
                                                                _lastNameController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .name,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'Last Name',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (String?
                                                                value) {
                                                                  return (value !=
                                                                      null &&
                                                                      value ==
                                                                          "" &&
                                                                      value.length <
                                                                          3)
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
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2.6,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[2],
                                                                controller:
                                                                _mobileController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .name,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  isDense: true,
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'Mobile No.',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
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
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2.6,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[3],
                                                                controller:
                                                                _emailController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .name,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
                                                                  isDense: true,
                                                                  focusedBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'Email',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
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
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 8.0),
                                                          child: TextFormField(
                                                            focusNode:
                                                            _focusNodes[4],
                                                            controller:
                                                            _addressController,
                                                            minLines: 3,
                                                            maxLines: 5,
                                                            keyboardType:
                                                            TextInputType
                                                                .streetAddress,
                                                            style: TextStyle(
                                                                color:
                                                                Colors.black),
                                                            decoration:
                                                            InputDecoration(
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
                                                                BorderRadius
                                                                    .circular(
                                                                    8.0),
                                                                borderSide:
                                                                const BorderSide(
                                                                  color:
                                                                  kYellowColor,
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    8.0),
                                                                borderSide:
                                                                const BorderSide(
                                                                  color:
                                                                  kBlueDarkColor,
                                                                  // width: 1.0,
                                                                ),
                                                              ),
                                                              border: const OutlineInputBorder(
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                      .circular(
                                                                      8))),
                                                              contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 11,
                                                                  bottom: 11,
                                                                  left: 15),
                                                              labelText:
                                                              TextConstant
                                                                  .address,
                                                              labelStyle: Theme.of(
                                                                  context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            onSaved:
                                                                (String? value) {
                                                              // This optional block of code can be used to run
                                                              // code when the user saves the form.
                                                            },
                                                            validator:
                                                                (String? value) {
                                                              return (value !=
                                                                  null &&
                                                                  value == "" &&
                                                                  value.length <
                                                                      10)
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
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[5],
                                                                controller:
                                                                _passwordController,
                                                                decoration:
                                                                InputDecoration(
                                                                  suffixIcon:
                                                                  IconButton(
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        hidePassword =
                                                                        !hidePassword;
                                                                      });
                                                                    },
                                                                    color: Colors
                                                                        .black,
                                                                    icon: Icon(hidePassword
                                                                        ? Icons
                                                                        .visibility_off_outlined
                                                                        : Icons
                                                                        .visibility_outlined),
                                                                  ),
                                                                  focusedBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  TextConstant
                                                                      .password,
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (input) =>
                                                                input!.length <
                                                                    3
                                                                    ? "Password should be more than 3 characters"
                                                                    : null,
                                                                obscureText:
                                                                hidePassword,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  3.7,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[6],
                                                                controller:
                                                                _pincodeController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .number,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'Pin Code',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (String?
                                                                value) {
                                                                  return (value !=
                                                                      null &&
                                                                      value ==
                                                                          "" &&
                                                                      value.length <
                                                                          3)
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
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2.2,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[7],
                                                                controller:
                                                                _adharController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .number,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'Aadhaar Card No.',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (String?
                                                                value) {
                                                                  return (value !=
                                                                      null &&
                                                                      value ==
                                                                          "" &&
                                                                      value.length <
                                                                          12)
                                                                      ? 'Aadhar Card No.'
                                                                      : null;
                                                                },
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  3,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[8],
                                                                controller:
                                                                _panController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .number,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'Pancard No.',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (String?
                                                                value) {
                                                                  return (value !=
                                                                      null &&
                                                                      value ==
                                                                          "" &&
                                                                      value.length <
                                                                          10)
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
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2.55,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[9],
                                                                controller:
                                                                _banknameController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .text,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'Enter Bank Name',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (String?
                                                                value) {
                                                                  return (value !=
                                                                      null &&
                                                                      value ==
                                                                          "" &&
                                                                      value.length <
                                                                          12)
                                                                      ? 'Bank Name'
                                                                      : null;
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2.6,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[10],
                                                                controller:
                                                                _holdernameController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .text,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'Account Holder Name',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (String?
                                                                value) {
                                                                  return (value !=
                                                                      null &&
                                                                      value ==
                                                                          "" &&
                                                                      value.length <
                                                                          10)
                                                                      ? 'Enter Account Holder Name'
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
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2.6,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[11],
                                                                controller:
                                                                _accountnoontroller,
                                                                keyboardType:
                                                                TextInputType
                                                                    .text,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'Account Number',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (String?
                                                                value) {
                                                                  return (value !=
                                                                      null &&
                                                                      value ==
                                                                          "" &&
                                                                      value.length <
                                                                          12)
                                                                      ? 'Enter Account Number'
                                                                      : null;
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  2.6,
                                                              child: TextFormField(
                                                                focusNode:
                                                                _focusNodes[12],
                                                                controller:
                                                                _ifscController,
                                                                keyboardType:
                                                                TextInputType
                                                                    .text,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                                decoration:
                                                                InputDecoration(
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
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kYellowColor,
                                                                    ),
                                                                  ),
                                                                  enabledBorder:
                                                                  OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        6.0),
                                                                    borderSide:
                                                                    const BorderSide(
                                                                      color:
                                                                      kBlueDarkColor,
                                                                      // width: 1.0,
                                                                    ),
                                                                  ),
                                                                  border: const OutlineInputBorder(
                                                                      borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              6))),
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 11,
                                                                      bottom:
                                                                      11,
                                                                      left: 15),
                                                                  labelText:
                                                                  'IFSC Code',
                                                                  labelStyle: Theme
                                                                      .of(
                                                                      context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                onSaved: (String?
                                                                value) {
                                                                  // This optional block of code can be used to run
                                                                  // code when the user saves the form.
                                                                },
                                                                validator: (String?
                                                                value) {
                                                                  return (value !=
                                                                      null &&
                                                                      value ==
                                                                          "" &&
                                                                      value.length <
                                                                          10)
                                                                      ? 'Enter IFSC code'
                                                                      : null;
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                          child: TextFormField(
                                                            focusNode:
                                                            _focusNodes[12],
                                                            controller:
                                                            _referralCodeController,
                                                            keyboardType:
                                                            TextInputType.text,
                                                            style: TextStyle(
                                                                color:
                                                                Colors.black),
                                                            decoration:
                                                            InputDecoration(
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
                                                                BorderRadius
                                                                    .circular(
                                                                    6.0),
                                                                borderSide:
                                                                const BorderSide(
                                                                  color:
                                                                  kYellowColor,
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    6.0),
                                                                borderSide:
                                                                const BorderSide(
                                                                  color:
                                                                  kBlueDarkColor,
                                                                  // width: 1.0,
                                                                ),
                                                              ),
                                                              border: const OutlineInputBorder(
                                                                  borderRadius: BorderRadius
                                                                      .all(Radius
                                                                      .circular(
                                                                      6))),
                                                              contentPadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 11,
                                                                  bottom: 11,
                                                                  left: 15),
                                                              labelText:
                                                              'Referral Code',
                                                              labelStyle: Theme.of(
                                                                  context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            onSaved:
                                                                (String? value) {
                                                              // This optional block of code can be used to run
                                                              // code when the user saves the form.
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 15.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('Boards'),
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Container(
                                                                height: 37,
                                                                child: TextFormField(
                                                                  controller:
                                                                  _boardController,
                                                                  cursorColor:
                                                                  Colors.black,
                                                                  keyboardType:
                                                                  TextInputType
                                                                      .none,
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                        context)
                                                                        .unfocus();
                                                                    onBoardTextFieldTap();
                                                                  },
                                                                  decoration:
                                                                  InputDecoration(
                                                                    filled: true,
                                                                    fillColor: Colors
                                                                        .black12,
                                                                    contentPadding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 8,
                                                                        bottom: 0,
                                                                        top: 0,
                                                                        right:
                                                                        15),
                                                                    hintText:
                                                                    'Select Board',
                                                                    border:
                                                                    const OutlineInputBorder(
                                                                      borderSide:
                                                                      BorderSide(
                                                                        width: 0,
                                                                        style:
                                                                        BorderStyle
                                                                            .none,
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                        Radius
                                                                            .circular(
                                                                            8.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 15.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 15.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('Grades'),
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Container(
                                                                height: 37,
                                                                child: TextFormField(
                                                                  controller:
                                                                  _gradeController,
                                                                  cursorColor:
                                                                  Colors.black,
                                                                  keyboardType:
                                                                  TextInputType
                                                                      .none,
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                        context)
                                                                        .unfocus();
                                                                    onGradeTextFieldTap();
                                                                  },
                                                                  decoration:
                                                                  InputDecoration(
                                                                    filled: true,
                                                                    fillColor: Colors
                                                                        .black12,
                                                                    contentPadding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 8,
                                                                        bottom: 0,
                                                                        top: 0,
                                                                        right:
                                                                        15),
                                                                    hintText:
                                                                    'Select Grades',
                                                                    border:
                                                                    const OutlineInputBorder(
                                                                      borderSide:
                                                                      BorderSide(
                                                                        width: 0,
                                                                        style:
                                                                        BorderStyle
                                                                            .none,
                                                                      ),
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                        Radius
                                                                            .circular(
                                                                            8.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 15.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 15.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text('Subjects'),
                                                              const SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              TextFormField(
                                                                controller:
                                                                _subjectsController,
                                                                cursorColor:
                                                                Colors.black,
                                                                keyboardType:
                                                                TextInputType
                                                                    .none,
                                                                onTap: () {
                                                                  FocusScope.of(
                                                                      context)
                                                                      .unfocus();
                                                                  onSubjectTextFieldTap();
                                                                },
                                                                decoration:
                                                                InputDecoration(
                                                                  filled: true,
                                                                  fillColor: Colors
                                                                      .black12,
                                                                  contentPadding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 8,
                                                                      bottom: 0,
                                                                      top: 0,
                                                                      right:
                                                                      15),
                                                                  hintText:
                                                                  'Select Subjects',
                                                                  border:
                                                                  const OutlineInputBorder(
                                                                    borderSide:
                                                                    BorderSide(
                                                                      width: 0,
                                                                      style:
                                                                      BorderStyle
                                                                          .none,
                                                                    ),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                      Radius
                                                                          .circular(
                                                                          8.0),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 15.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding:EdgeInsets.symmetric(horizontal: 15),
                                                          child: ListView.builder(
                                                            shrinkWrap: true,
                                                            scrollDirection: Axis.horizontal,
                                                            itemCount: modeOfTeachingList!.length,
                                                            itemBuilder: (context, index) => CheckboxListTile(
                                                              value: modeOfTeachingList![index].isChecked,
                                                              onChanged: (value) {
                                                                setState(() {
                                                                    modeOfTeachingList![index].isChecked = value!;
                                                                });
                                                              },
                                                              title: Text(
                                                                modeOfTeachingList![index].title!,
                                                                style: const TextStyle(color: Colors.black87),
                                                              ),
                                                            ),),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  termsChecked =
                                                                  !termsChecked;
                                                                  setState(() {});
                                                                },
                                                                child: termsChecked
                                                                    ? Icon(
                                                                  Icons
                                                                      .check_box,
                                                                  color:
                                                                  kPrimaryColor,
                                                                  size: 22,
                                                                )
                                                                    : Icon(
                                                                  Icons
                                                                      .check_box_outline_blank,
                                                                  color:
                                                                  kPrimaryColor,
                                                                  size: 22,
                                                                )),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                            TermsAndConditionScreen()));
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                                child: RichText(
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                  text: TextSpan(
                                                                    // style: DefaultTextStyle.of(
                                                                    //         context)
                                                                    //     .style,
                                                                    children: const <TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                          'Agree to ',
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .black,
                                                                              fontSize:
                                                                              11)),
                                                                      TextSpan(
                                                                          text:
                                                                          'Terms and Conditions',
                                                                          style: TextStyle(
                                                                              color: Colors
                                                                                  .blue,
                                                                              fontSize:
                                                                              11)),
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
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                .black),
                                                          ),
                                                          onPressed: () {
                                                            //_signup();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                70.0),
                                                            child: Text(
                                                              TextConstant.sign_up,
                                                              style: const TextStyle(
                                                                  color:
                                                                  Colors.white,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold),
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

                            ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
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

  Future<void> getBoards() async {
    boardsModel = await Get.find<AuthController>().getBoards();
    if (boardsModel!.status == "success") {
      _listOfBoards.clear();
      for (var item in boardsModel!.data!) {
        _listOfBoards.add(SelectedListItem(
            name: item.boardName!,
            value: item.boardName!,
            id: item.boardId,
            isSelected: false));
      }
      print(_listOfBoards);
      setState(() {});
    }
  }

  Future<void> getGrades(String boardId) async {
    gradesModel = await Get.find<AuthController>().getGrades(boardId);
    if (gradesModel!.status == "success") {
      _listOfGrades.clear();
      for (var item in gradesModel!.data!) {
        _listOfGrades.add(SelectedListItem(
            name: item.gradeName!, value: item.gradeName!, id: item.gradeId, isSelected: false));
      }
      print(_listOfGrades);
      setState(() {});
    }
  }


  Future<void> subjectListing() async {
    subjectResponseModel = await Get.find<AuthController>().subjectListingGradeWise(GradeRequestModel(gradeId: gradesIdList));
      if (subjectResponseModel!.status == "success") {
        _listOfSubjects.clear();
        for (var item in subjectResponseModel!.data!) {
          _listOfSubjects.add(SelectedListItem(
              name: item.subjectName!+" - "+item.gradeName!, value: item.subjectName!+" - "+item.gradeName!, isSelected: false));
        }
        setState(() {});
      } else {
        showCustomSnackBar(subjectResponseModel!.status!);
      }
  }

  void onBoardTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: const Text(
          'Boards',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        clearButtonChild: const Text(
          'Clear',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: _listOfBoards ?? [],
        selectedItems: (List<dynamic> selectedList) {
          print(selectedList.indexed);
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              selectedBoard = item.id!;
              getGrades(selectedBoard!);
              _boardController.text = item.name;
              print(selectedBoard);
            }
          }
          GlobalFunctions.showSuccessToast(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void onGradeTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: const Text(
          'Grades',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        clearButtonChild: const Text(
          'Clear',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: _listOfGrades ?? [],
        selectedItems: (List<dynamic> selectedList) {
          print(selectedList.indexed);
          gradesList = [];
          gradesIdList = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              gradesList!.add(item.name);
              gradesIdList!.add(item.id!);
            }
          }
          // gradeRequestModel!.gradeId!.addAll(gradesList!);
          _gradeController.text = gradesList!.join(", ");
          GlobalFunctions.showSuccessToast(gradesList.toString());
          subjectListing();
        },
        enableMultipleSelection: true,
      ),
    ).showModal(context);
  }

  void onSubjectTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: const Text(
          'Subjects',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        clearButtonChild: const Text(
          'Clear',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: _listOfSubjects ?? [],
        selectedItems: (List<dynamic> selectedList) {
          print(selectedList.indexed);
          subjectsList = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              subjectsList.add(item.value!);
            }
          }
          _subjectsController.text = subjectsList.join(", ");
          GlobalFunctions.showSuccessToast(subjectsList.toString());
        },
        enableMultipleSelection: true,
      ),
    ).showModal(context);
  }
}
/*

/// This is Common App textfiled class.
class AppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String title;
  final String hint;
  final bool isCitySelected;
  final List<SelectedListItem>? cities;

  const AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isCitySelected,
    this.cities,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  /// This is on text changed method which will display on city text field on changed.
  void onTextFieldTap() {
    DropDownState(
      DropDown(
        isDismissible: true,
        bottomSheetTitle: const Text(
          'Boards',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        clearButtonChild: const Text(
          'Clear',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.cities ?? [],
        selectedItems: (List<dynamic> selectedList) {
          print(selectedList.indexed);
           List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              // selectedBoard = item.id!;

            }
          }
          showSnackBar(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        const SizedBox(
          height: 5.0,
        ),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: Colors.black,
          onTap: widget.isCitySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding:
                const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
            hintText: widget.hint,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
*/
