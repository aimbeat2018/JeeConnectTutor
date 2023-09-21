import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/controllers/courseController.dart';
import 'package:jeeconnecttutor/screens/home/mainScreen.dart';
import 'package:jeeconnecttutor/screens/userAuth/courseDetailsBottomSheetScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String token;
  final String userId;

  const UpdateProfileScreen(
      {super.key, required this.token, required this.userId});

  @override
  State<StatefulWidget> createState() => UpdateProfileScreenState();
}

class UpdateProfileScreenState extends State<UpdateProfileScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;

  final _experienceController = TextEditingController();
  final _tutorLocationController = TextEditingController();
  final _selectNearbyAreaController = TextEditingController();
  final _nocController = TextEditingController();
  final _aadhaarController = TextEditingController();
  final _panNoController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountHolderNameController = TextEditingController();
  final _accountNoController = TextEditingController();
  final _ifscController = TextEditingController();

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

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

    Get.find<CourseController>().getCategoryList(widget.token);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<CourseController>(builder: (courseController) {
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                backgroundColor: kYellowColor,
                centerTitle: true,
                title: const Text(
                  'Update Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      MaterialButton(
                                        elevation: 0,
                                        color: kYellowColor,
                                        onPressed: () {
                                          showModalBottomSheet(
                                            useSafeArea: true,
                                            context: context,
                                            isScrollControlled: true,
                                            builder: (context) =>
                                                CourseDetailsBottomSheetScreen(
                                              categoryList: courseController
                                                          .categoryList !=
                                                      null
                                                  ? courseController
                                                      .categoryList!
                                                  : [],
                                            ),
                                            backgroundColor: Colors.transparent,
                                          ).then((leaveTypeModel) => {
                                                // setState(() {
                                                //   LeaveTypeData model = leaveTypeModel;
                                                //   selectedLeaveType = model.typeName!;
                                                //   selectedLeaveTypeId =
                                                //       model.id!.toString();
                                                // })
                                              });
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  10),
                                          // side: const BorderSide(color: kRedColor),
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Add Course Details',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        focusNode: _focusNodes[0],
                                        controller: _experienceController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant.experience),
                                        onSaved: (String? value) {
                                          // This optional block of code can be used to run
                                          // code when the user saves the form.
                                        },
                                        validator: (String? value) {
                                          return (value != null && value == "")
                                              ? 'Enter experience'
                                              : null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        focusNode: _focusNodes[1],
                                        controller: _tutorLocationController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant.tutorsLocation),
                                        onSaved: (String? value) {
                                          // This optional block of code can be used to run
                                          // code when the user saves the form.
                                        },
                                        // validator: (String? value) {
                                        //   return (value != null &&
                                        //       value=="")
                                        //       ? 'Enter User Id'
                                        //       : null;
                                        // },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        focusNode: _focusNodes[2],
                                        controller: _selectNearbyAreaController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant
                                                    .selectNearbyAreaKm),
                                        onSaved: (String? value) {
                                          // This optional block of code can be used to run
                                          // code when the user saves the form.
                                        },
                                        validator: (String? value) {
                                          return (value != null && value == "")
                                              ? 'Enter mobile'
                                              : null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        focusNode: _focusNodes[3],
                                        controller: _nocController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant.noc),
                                        onSaved: (String? value) {
                                          // This optional block of code can be used to run
                                          // code when the user saves the form.
                                        },
                                        validator: (String? value) {
                                          return (value != null && value == "")
                                              ? 'Enter address'
                                              : null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text(
                                          'KYC Details',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        focusNode: _focusNodes[4],
                                        controller: _aadhaarController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant.aadhaarCard),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        focusNode: _focusNodes[5],
                                        controller: _panNoController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant.panNO),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Bank Details',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _bankNameController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant.bankName),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller:
                                            _accountHolderNameController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant.accountHolderName),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: _accountNoController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant.accountNo),
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
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        controller: _ifscController,
                                        decoration: GlobalFunctions
                                            .getInputDecorationWhite(
                                                TextConstant.ifsc),
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
                                        width: double.infinity,
                                        child: _isLoading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 100.0,
                                                    top: 35.0,
                                                    right: 100.0,
                                                    bottom: 15.0),
                                                child: MaterialButton(
                                                  elevation: 0,
                                                  color: Colors.blue.shade900,
                                                  onPressed: _submit,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 5,
                                                      vertical: 15),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .circular(10),
                                                    // side: const BorderSide(color: kRedColor),
                                                  ),
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Update Profile',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  )
                                ],
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
          });
  }

  void _submit() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MainScreen(),
    ));
  }
}
