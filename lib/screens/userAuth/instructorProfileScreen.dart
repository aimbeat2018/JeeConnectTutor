import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/model/modeOfTeachingModel.dart';
import 'package:jeeconnecttutor/model/request/gradeRequestModel.dart';
import 'package:jeeconnecttutor/model/response/boardsModel.dart';
import 'package:jeeconnecttutor/model/response/subjectResponseModel.dart';
import 'package:jeeconnecttutor/screens/userAuth/otpScreen.dart';
import 'package:jeeconnecttutor/screens/userAuth/viewPdfScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../controllers/authController.dart';
import '../../controllers/requestController.dart';
import '../../model/pincodeList.dart';
import '../../model/profileViewModel.dart';
import '../../model/response/gradesModel.dart';
import '../other/termsAndConditionScreen.dart';

class InstructorProfileScreen extends StatefulWidget {
  const InstructorProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => InstructorProfileScreenState();
}

class InstructorProfileScreenState extends State<InstructorProfileScreen> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool hideConfirmPassword = true;
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _pincodeController = TextEditingController();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
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

  String _connectionStatus = 'unKnown';
  BoardsModel? boardsModel = BoardsModel();
  GradesModel? gradesModel = GradesModel();
  SubjectResponseModel? subjectResponseModel;
  ProfileViewModel? profileViewModel;
  String? selectedBoard;
  List<String>? gradesList = [];
  List<String>? gradesIdList = [];
  List<String> subjectsList = [];
  List<String> subjectsIDList = [];
  List<String> boardsIDList = [];
  List multipleSelected = [];
  XFile? _pickedFile;
  int? totalPincodeCount = 1;

  List checkListItems = [
    {
      "id": 1,
      "value": false,
      "title": "Online",
    },
    {
      "id": 2,
      "value": false,
      "title": "Offline",
    },
    {
      "id": 3,
      "value": false,
      "title": "Group Study",
    },
  ];

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

  List<PincodeList> pincodeList = [];
  bool termsChecked = false;
  final bool isBoardSelected = true;
  final bool isGradeSelected = false;
  final bool isSubjectSelected = false;
  GradeRequestModel? gradeRequestModel = GradeRequestModel();

  final List<SelectedListItem> _listOfBoards = [];
  final List<SelectedListItem> _listOfGrades = [];
  final List<SelectedListItem> _listOfSubjects = [];
  bool newFlag = false;

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

    Get.find<AuthController>().getProfile().then((value) {
      setState(() {
        if (value != null) {
          profileViewModel = value;
          if (profileViewModel != null) {
            String? grades, subject, boards, pincode, modeOfTeaching;

            boardsIDList = [];
            boardsIDList.add(profileViewModel!.boardId!);
            gradesIdList = [];
            gradesList = [];
            for (var item in profileViewModel!.gradeDetails!) {
              if (grades == null || grades == "") {
                grades = item.gradeName;
              } else {
                grades = grades! + "," + item.gradeName!;
              }
              gradesIdList!.add(item.gradeId!);
              gradesList!.add(item.gradeName!);
            }

            subjectsIDList = [];
            subjectsList = [];
            for (var item in profileViewModel!.subjectDetails!) {
              if (subject == null || subject == "") {
                subject = item.subjectName;
              } else {
                subject = subject! + "," + item.subjectName!;
              }
              subjectsIDList.add(item.subjectId!);
              subjectsList.add(item.subjectName!);
            }

            for (var item in profileViewModel!.techingDetails!) {
              if (modeOfTeaching == null || modeOfTeaching == "") {
                modeOfTeaching = item.modeOfTeching;
              } else {
                modeOfTeaching = modeOfTeaching! + "," + item.modeOfTeching!;
              }
            }

            totalPincodeCount = profileViewModel!.pincode!.length;

            if (newFlag == false)
              for (int i = 0; i < profileViewModel!.pincode!.length; i++) {
                pincodeList.add(PincodeList(
                    name: profileViewModel!.pincode![i].pincode, index: i));
              }

            for (int i = 0; i < profileViewModel!.techingDetails!.length; i++) {
              if (profileViewModel!.techingDetails![i].modeOfTeching!.trim() ==
                  "Online") {
                checkListItems[0]["value"] = true;
              }
              if (profileViewModel!.techingDetails![i].modeOfTeching!.trim() ==
                  "Offline") {
                checkListItems[1]["value"] = true;
              }
              if (profileViewModel!.techingDetails![i].modeOfTeching!.trim() ==
                  "Group Study") {
                checkListItems[2]["value"] = true;
              }
            }
            _firstNameController.text = profileViewModel!.firstName!;
            _lastNameController.text = profileViewModel!.lastName!;
            _mobileController.text = profileViewModel!.mobileNo!;
            _gradeController.text = grades!;
            _subjectsController.text = subjectsList!.join(",");
            _boardController.text = profileViewModel!.boardName!;
            _emailController.text = profileViewModel!.email!;
            _addressController.text = profileViewModel!.address!;
            _panController.text = profileViewModel!.panNo!;
            _banknameController.text = profileViewModel!.bankName!;
            _holdernameController.text = profileViewModel!.accountHolderName!;
            _accountnoontroller.text = profileViewModel!.accountNo!;
            _ifscController.text = profileViewModel!.ifscCode!;
            _adharController.text = profileViewModel!.aadharNo!;

            newFlag = true;
          }

          selectedBoard = profileViewModel!.boardId!;
          getGrades(selectedBoard!);
          subjectListing();
        }
      });
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
              appBar: AppBar(
                backgroundColor: kYellowColor,
                automaticallyImplyLeading: true,
                iconTheme: IconThemeData(
                  color: Colors.white, //change your color here
                ),
                centerTitle: true,
                title: const Text(
                  'Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 20),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
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
                                                          style:
                                                              const TextStyle(
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
                                                                'First Name',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                          style:
                                                              const TextStyle(
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
                                                                'Last Name',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                                  .number,
                                                          enabled: false,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly,
                                                            LengthLimitingTextInputFormatter(
                                                                10),
                                                          ],
                                                          style:
                                                              const TextStyle(
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
                                                                'Mobile No.',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                          style:
                                                              const TextStyle(
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
                                                            labelText: 'Email',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                      focusNode: _focusNodes[4],
                                                      controller:
                                                          _addressController,
                                                      minLines: 3,
                                                      maxLines: 5,
                                                      keyboardType:
                                                          TextInputType
                                                              .streetAddress,
                                                      style: const TextStyle(
                                                          color: Colors.black),
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
                                                            color: kYellowColor,
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
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8))),
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 11,
                                                                bottom: 11,
                                                                left: 15),
                                                        labelText: TextConstant
                                                            .address,
                                                        labelStyle: Theme.of(
                                                                context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      onSaved: (String? value) {
                                                        // This optional block of code can be used to run
                                                        // code when the user saves the form.
                                                      },
                                                      validator:
                                                          (String? value) {
                                                        return (value != null &&
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
                                                            2.2,
                                                        child: TextFormField(
                                                          focusNode:
                                                              _focusNodes[7],
                                                          controller:
                                                              _adharController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          inputFormatters: [
                                                            FilteringTextInputFormatter
                                                                .digitsOnly,
                                                            LengthLimitingTextInputFormatter(
                                                                12),
                                                          ],
                                                          style:
                                                              const TextStyle(
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
                                                                'Aadhaar Card No.',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                                  .text,
                                                          inputFormatters: [
                                                            LengthLimitingTextInputFormatter(
                                                                10),
                                                          ],
                                                          style:
                                                              const TextStyle(
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
                                                                'Pancard No.',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                                  .name,
                                                          style:
                                                              const TextStyle(
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
                                                                'Enter Bank Name',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                                  .name,
                                                          style:
                                                              const TextStyle(
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
                                                                'Account Holder Name',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                                  .number,
                                                          style:
                                                              const TextStyle(
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
                                                                'Account Number',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                          style:
                                                              const TextStyle(
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
                                                                'IFSC Code',
                                                            labelStyle: Theme
                                                                    .of(context)
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
                                                  const SizedBox(
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
                                                        const Text('Boards'),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        SizedBox(
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
                                                                const InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .black12,
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 8,
                                                                      bottom: 0,
                                                                      top: 0,
                                                                      right:
                                                                          15),
                                                              hintText:
                                                                  'Select Board',
                                                              border:
                                                                  OutlineInputBorder(
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
                                                        const Text('Grades'),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        SizedBox(
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
                                                                const InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .black12,
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 8,
                                                                      bottom: 0,
                                                                      top: 0,
                                                                      right:
                                                                          15),
                                                              hintText:
                                                                  'Select Grades',
                                                              border:
                                                                  OutlineInputBorder(
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
                                                        const Text('Subjects'),
                                                        const SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        SizedBox(
                                                          height: 37,
                                                          child: TextFormField(
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
                                                                const InputDecoration(
                                                              filled: true,
                                                              fillColor: Colors
                                                                  .black12,
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 8,
                                                                      bottom: 0,
                                                                      top: 0,
                                                                      right:
                                                                          15),
                                                              hintText:
                                                                  'Select Subjects',
                                                              border:
                                                                  OutlineInputBorder(
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
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    18.0),
                                                        child: const Text(
                                                            'Mode of Teaching'),
                                                      )),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15),
                                                    child: Column(
                                                      children: List.generate(
                                                        checkListItems.length,
                                                        (index) =>
                                                            CheckboxListTile(
                                                          controlAffinity:
                                                              ListTileControlAffinity
                                                                  .leading,
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          dense: true,
                                                          title: Text(
                                                            checkListItems[
                                                                index]["title"],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          value: checkListItems[
                                                              index]["value"],
                                                          onChanged: (value) {
                                                            setState(() {
                                                              checkListItems[
                                                                          index]
                                                                      [
                                                                      "value"] =
                                                                  value;
                                                              if (multipleSelected
                                                                  .contains(
                                                                      checkListItems[
                                                                          index])) {
                                                                multipleSelected.remove(
                                                                    checkListItems[
                                                                        index]);
                                                              } else {
                                                                multipleSelected.add(
                                                                    checkListItems[
                                                                            index]
                                                                        [
                                                                        "title"]);
                                                              }
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    8.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10.0),
                                                              child: Text(
                                                                'Pincode',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  textStyle:
                                                                      const TextStyle(
                                                                          fontSize:
                                                                              14)),
                                                              onPressed: () {
                                                                totalPincodeCount =
                                                                    totalPincodeCount! +
                                                                        1;

                                                                pincodeList.add(
                                                                    PincodeList(
                                                                        name:
                                                                            "",
                                                                        index:
                                                                            totalPincodeCount));
                                                                setState(() {});
                                                                for (var item
                                                                    in pincodeList) {
                                                                  debugPrint(item
                                                                      .name!);
                                                                }
                                                              },
                                                              child: const Text(
                                                                  'ADD'),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 3.0),
                                                      GridView.count(
                                                        shrinkWrap: true,
                                                        crossAxisCount: 2,
                                                        mainAxisSpacing: 10.0,
                                                        crossAxisSpacing: 10.0,
                                                        childAspectRatio:
                                                            ((MediaQuery.of(context)
                                                                        .size
                                                                        .width /
                                                                    2) /
                                                                50.0),
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        children: List.generate(
                                                            pincodeList.length,
                                                            (index) {
                                                          return Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 35,
                                                                  width: (MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      3.4),
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          10),
                                                                  margin: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5),
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    shape:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          const BorderSide(
                                                                        color:
                                                                            kBlueDarkColor,
                                                                      ),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            8.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
                                                                    inputFormatters: [
                                                                      LengthLimitingTextInputFormatter(
                                                                          6),
                                                                    ],
                                                                    cursorColor:
                                                                        Colors
                                                                            .black,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: const Color(
                                                                          0xff444444),
                                                                    ),
                                                                    decoration:
                                                                        const InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintText:
                                                                          "Type Pincode",
                                                                    ),
                                                                    initialValue:
                                                                        pincodeList[index]
                                                                            .name!,
                                                                    onChanged:
                                                                        (values) {
                                                                      pincodeList[index]
                                                                              .name =
                                                                          values;
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  if (totalPincodeCount !=
                                                                      1) {
                                                                    totalPincodeCount =
                                                                        totalPincodeCount! -
                                                                            1;
                                                                    totalPincodeCount =
                                                                        totalPincodeCount;

                                                                    pincodeList
                                                                        .removeAt(
                                                                            totalPincodeCount!);
                                                                  }
                                                                  setState(
                                                                      () {});
                                                                  for (var item
                                                                      in pincodeList) {
                                                                    debugPrint(item
                                                                        .name!);
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .delete_forever_outlined,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 25,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        }),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                    18.0),
                                                        child: const Text(
                                                            'Update your resume'),
                                                      )),
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 18.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // pickImageCamera();

                                                        openFiles();
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            border: Border.all(
                                                                color:
                                                                    kPrimaryColor)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0,
                                                                  vertical: 5),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  child:
                                                                      Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        4.0),
                                                                child: Text(
                                                                  _pickedFile ==
                                                                          null
                                                                      ? 'Resume'
                                                                      : _pickedFile!
                                                                          .name,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              )),
                                                              Icon(
                                                                Icons
                                                                    .picture_as_pdf,
                                                                color: Colors
                                                                    .grey
                                                                    .shade700,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ViewPdfScreen(
                                                                    fileUrl:
                                                                        profileViewModel!
                                                                            .resume!,
                                                                  )));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5.0,
                                                              right: 20),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          'View Resume',
                                                          textAlign:
                                                              TextAlign.end,
                                                          // 'Remark: ${widget.model.remark ??'vff':widget.model.remark}',
                                                          style: TextStyle(
                                                              color:
                                                                  kBlueDarkColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.black),
                                                    ),
                                                    onPressed: () {
                                                      updateUser(
                                                          authController);
                                                      // for(var item in pincodeList){
                                                      //   debugPrint(item.name!);
                                                      // }
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 70.0),
                                                      child: Text(
                                                        'Update Profile',
                                                        style: const TextStyle(
                                                            color: Colors.white,
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
            name: item.gradeName!,
            value: item.gradeName!,
            id: item.gradeId,
            isSelected: false));
      }
      print(_listOfGrades);
      setState(() {});
    }
  }

  Future<void> subjectListing() async {
    subjectResponseModel = await Get.find<AuthController>()
        .subjectListingGradeWise(GradeRequestModel(gradeId: gradesIdList));
    if (subjectResponseModel!.status == "success") {
      _listOfSubjects.clear();
      for (var item in subjectResponseModel!.data!) {
        _listOfSubjects.add(SelectedListItem(
            name: item.subjectName! + " - " + item.gradeName!,
            value: item.subjectId!,
            isSelected: false));
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
        data: _listOfBoards,
        selectedItems: (List<dynamic> selectedList) {
          print(selectedList.indexed);
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              selectedBoard = item.id!;
              boardsIDList.add(item.id!);
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
        data: _listOfGrades,
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
          _gradeController.text = gradesList!.join(",");
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
        data: _listOfSubjects,
        selectedItems: (List<dynamic> selectedList) {
          print(selectedList.indexed);
          subjectsList = [];
          subjectsIDList = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              subjectsList.add(item.name);
              subjectsIDList.add(item.value!);
            }
          }
          _subjectsController.text = subjectsList.join(",");
          GlobalFunctions.showSuccessToast(subjectsList.toString());
        },
        enableMultipleSelection: true,
      ),
    ).showModal(context);
  }

  void openFiles() async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
    if (resultFile != null) {
      PlatformFile file = resultFile.files.first;
      _pickedFile = XFile(file!.path!);
      print(file.name);
      print(file.path);
      setState(() {});
    } else {
      //not picket any file
    }
  }

  Future<void> updateUser(AuthController authController) async {
    String? modeOfTeaching = "", pincodeIds = "";
    for (int i = 0; i < checkListItems!.length; i++) {
      if (modeOfTeaching == "") {
        if (checkListItems[i]["value"]) {
          modeOfTeaching = checkListItems[i]["title"];
        }
      } else {
        if (checkListItems[i]["value"]) {
          modeOfTeaching = modeOfTeaching! + "," + checkListItems[i]["title"];
        }
      }
    }

    String subject = subjectsIDList.join(",");
    String multipleSelecte = multipleSelected.join(",");

    pincodeIds = "";
    for (var item in pincodeList) {
      if (pincodeIds == "") {
        pincodeIds = item.name!;
      } else {
        pincodeIds = pincodeIds! + "," + item.name!;
      }
    }

    authController
        .updateProfile(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            address: _addressController.text,
            pincode: pincodeIds,
            adhar: _adharController.text,
            pan: _panController.text,
            bankname: _banknameController.text,
            holdername: _holdernameController.text,
            accountNo: _accountnoontroller.text,
            ifsc: _ifscController.text,
            board: boardsIDList.join(","),
            grade: gradesIdList!.join(","),
            subjects: subject,
            resume: _pickedFile,
            modeOfTeachingSelected: modeOfTeaching,
            userId: await Get.find<AuthController>().getUserId())
        .then((model) async {
      if (model!.status == "200") {
        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Update Profile'),
            content: const Text('Profile Updated successfully'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
