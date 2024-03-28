import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/controllers/authController.dart';
import 'package:jeeconnecttutor/controllers/courseController.dart';
import 'package:jeeconnecttutor/screens/userAuth/courseDetailsBottomSheetScreen.dart';

import '../../constant/app_constants.dart';
import '../../constant/custom_snackbar.dart';
import '../../constant/internetConnectivity.dart';
import '../../constant/no_internet_screen.dart';
import '../../constant/route_helper.dart';
import '../../model/updateProfileModel.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String token;
  final String userId;
  String from;

  UpdateProfileScreen(
      {super.key,
      required this.token,
      required this.userId,
      required this.from});

  @override
  State<StatefulWidget> createState() => UpdateProfileScreenState();
}

class UpdateProfileScreenState extends State<UpdateProfileScreen>
    with TickerProviderStateMixin {
  final _experienceController = TextEditingController();
  final _tutorLocationController = TextEditingController();
  final _tutorPincodeController = TextEditingController();
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
    FocusNode(),
  ];

  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  List<CourseDetails> selectedCourseList = [];

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

    if (widget.from == 'update') {
      Get.find<AuthController>()
          .getProfile(Get.find<AuthController>().getUserToken());
    }

    Get.find<CourseController>().getCategoryList(widget.token);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return _connectionStatus == AppConstants.connectivityCheck
        ? const NoInternetScreen()
        : GetBuilder<CourseController>(builder: (courseController) {
            return GetBuilder<AuthController>(builder: (authController) {
              if (widget.from == 'update') {
                widget.from = "";
                if (authController.profileViewModel != null) {
                  _experienceController.text =
                      authController.profileViewModel!.experience!;
                  _nocController.text = authController.profileViewModel!.noc!;
                  _tutorLocationController.text =
                      authController.profileViewModel!.location!;
                  _tutorPincodeController.text =
                      authController.profileViewModel!.pincode!;
                  _aadhaarController.text =
                      authController.profileViewModel!.adhaarNo!;
                  _panNoController.text =
                      authController.profileViewModel!.panNo!;
                  _bankNameController.text =
                      authController.profileViewModel!.bankName!;
                  _accountHolderNameController.text =
                      authController.profileViewModel!.accountHolderName!;
                  _accountNoController.text =
                      authController.profileViewModel!.accountNo!;
                  _ifscController.text =
                      authController.profileViewModel!.ifscCode!;

                  selectedCourseList = [];
                  for (var courseInfo
                      in authController.profileViewModel!.courseInfo!) {
                    List<SelectedCourse> subSelectedList = [];
                    String course = "";
                    for (var selectedCourse in courseInfo.selectedCourse!) {
                      subSelectedList.add(SelectedCourse(
                          courseName: selectedCourse.courseName,
                          courseId: selectedCourse.courseId));
                      course += "${selectedCourse.courseName!},";
                    }
                    course = course.substring(0, course.length - 1);

                    CourseDetails model = CourseDetails();
                    model.selectedCourse = subSelectedList;
                    model.selectedCourserStr = course;
                    model.categoryId = courseInfo.categoryId;
                    model.categoryName = courseInfo.categoryName;
                    model.subCategoryName = courseInfo.subCategoryName;
                    model.subCategoryId = courseInfo.subCategoryId;
                    selectedCourseList.add(model);
                  }
                }
              }
              return Scaffold(
                key: _scaffoldKey,
                backgroundColor: kBackgroundColor,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.white, //change your color here
                  ),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                    categoryList:
                                        courseController.categoryList != null
                                            ? courseController.categoryList!
                                            : [],
                                  ),
                                  backgroundColor: Colors.transparent,
                                ).then((courseDetails) => {
                                      setState(() {
                                        CourseDetails model = courseDetails;

                                        if (model.categoryId != null) {
                                          selectedCourseList.add(model);
                                        }
                                      })
                                    });
                              },
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                // side: const BorderSide(color: kRedColor),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                            Container(
                              child: selectedCourseList.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,

                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            'Select Courses ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 200,
                                          child: ListView.separated(
                                            itemCount:
                                                selectedCourseList.length,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Category name : ${selectedCourseList[index].categoryName!}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text(
                                                            'Sub-Category name : ${selectedCourseList[index].subCategoryName!}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Course : ${selectedCourseList[index].selectedCourserStr!}',
                                                            maxLines: 2,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedCourseList
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      child: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const Divider();
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Experience', textAlign: TextAlign.start,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14, color: Colors.black),),
                            const SizedBox(height: 5,),
                            TextFormField(
                              focusNode: _focusNodes[0],
                              controller: _experienceController,
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.experience),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Location', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14, color: Colors.black),),
                            const SizedBox(height: 5,),
                            TextFormField(
                              focusNode: _focusNodes[1],
                              controller: _tutorLocationController,
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.tutorsLocation),
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Pin Code', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14, color: Colors.black),),
                            const SizedBox(height: 5,),
                            TextFormField(
                              focusNode: _focusNodes[2],
                              controller: _tutorPincodeController,
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.tutorsPincode),
                            ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            // TextFormField(
                            //   focusNode: _focusNodes[2],
                            //   controller: _selectNearbyAreaController,
                            //   decoration: GlobalFunctions.getInputDecorationWhite(
                            //       TextConstant.selectNearbyAreaKm),
                            //   onSaved: (String? value) {
                            //     // This optional block of code can be used to run
                            //     // code when the user saves the form.
                            //   },
                            //   validator: (String? value) {
                            //     return (value != null && value == "")
                            //         ? 'Enter mobile'
                            //         : null;
                            //   },
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('NOC', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14, color: Colors.black),),
                            const SizedBox(height: 5,),
                            TextFormField(
                              focusNode: _focusNodes[3],
                              controller: _nocController,
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.noc),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('KYC Details', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14, color: Colors.black),),
                            const SizedBox(height: 5,),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
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
                            const Text('Aadhaar Number', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14, color: Colors.black),),
                            const SizedBox(height: 5,),
                            TextFormField(
                              focusNode: _focusNodes[4],
                              controller: _aadhaarController,
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.aadhaarCard),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text('Pan Number', style: TextStyle(fontWeight: FontWeight.normal,fontSize: 14, color: Colors.black),),
                            const SizedBox(height: 5,),
                            TextFormField(
                              focusNode: _focusNodes[5],
                              controller: _panNoController,
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.panNO),
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
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.bankName),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _accountHolderNameController,
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.accountHolderName),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _accountNoController,
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.accountNo),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _ifscController,
                              decoration:
                                  GlobalFunctions.getInputDecorationWhite(
                                      TextConstant.ifsc),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: authController.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Padding(
                                      padding: const EdgeInsets.only(
                                          left: 100.0,
                                          top: 35.0,
                                          right: 100.0,
                                          bottom: 15.0),
                                      child: MaterialButton(
                                        elevation: 0,
                                        color: Colors.blue.shade900,
                                        onPressed: () {
                                          if (_experienceController
                                              .text.isEmpty) {
                                            showCustomSnackBar(
                                                'Enter experience',
                                                isError: true);
                                          } else if (_tutorLocationController
                                              .text.isEmpty) {
                                            showCustomSnackBar('Enter Area',
                                                isError: true);
                                          } else if (_tutorPincodeController
                                              .text.isEmpty) {
                                            showCustomSnackBar('Enter Pincode',
                                                isError: true);
                                          } else if (_nocController
                                              .text.isEmpty) {
                                            showCustomSnackBar('Enter NOC',
                                                isError: true);
                                          } else if (_aadhaarController
                                              .text.isEmpty) {
                                            showCustomSnackBar(
                                                'Enter Aadhar no',
                                                isError: true);
                                          } else if (_panNoController
                                              .text.isEmpty) {
                                            showCustomSnackBar(
                                                'Enter pancard no',
                                                isError: true);
                                          } else if (_bankNameController
                                              .text.isEmpty) {
                                            showCustomSnackBar(
                                                'Enter bank name',
                                                isError: true);
                                          } else if (_accountHolderNameController
                                              .text.isEmpty) {
                                            showCustomSnackBar(
                                                'Enter account holder name',
                                                isError: true);
                                          } else if (_accountNoController
                                              .text.isEmpty) {
                                            showCustomSnackBar(
                                                'Enter account no',
                                                isError: true);
                                          } else if (_ifscController
                                              .text.isEmpty) {
                                            showCustomSnackBar(
                                                'Enter IFSC code',
                                                isError: true);
                                          } else {
                                            UpdateProfileModel model =
                                                UpdateProfileModel();
                                            model.userId =
                                                int.parse(widget.userId);
                                            model.experience = int.parse(
                                                _experienceController.text);
                                            model.noc = _nocController.text;
                                            model.tutorLocation =
                                                _tutorLocationController.text;
                                            model.area =
                                                _tutorPincodeController.text;
                                            model.adhaarCard =
                                                _aadhaarController.text;
                                            model.panNo = _panNoController.text;
                                            model.bankName =
                                                _bankNameController.text;
                                            model.accountHolderName =
                                                _accountHolderNameController
                                                    .text;
                                            model.accountNo =
                                                _accountNoController.text;
                                            model.ifscCode =
                                                _ifscController.text;
                                            model.courseDetails =
                                                selectedCourseList;
                                            model.mode = "offline";

                                            _submit(model, authController);
                                          }
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
                                              'Update Profile',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
          });
  }

  void _submit(UpdateProfileModel model, AuthController authController) {
    authController
        .updateProfile(model, widget.userId, widget.token)
        .then((model) async {
      if (model!.status == 200) {
        showDialog<String>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Account Verification'),
            content: const Text('Thank you! for giving your details, We\'ll verify and contact you in two to three days'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  Get.offNamed(RouteHelper.getLoginRoute());
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showCustomSnackBar(model.message!);
      }
    });
  }
}
