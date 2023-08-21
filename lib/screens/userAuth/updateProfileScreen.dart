import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/screens/home/mainScreen.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String name = 'updateProfile';

  const UpdateProfileScreen({super.key});

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
  @override
  void initState() {
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kYellowColor,
        centerTitle: true,
        title: Text(
          'Update Profile',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Column(
                        children: [
                          Form(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0.0,
                                        top: 5,
                                        right: 0.0,
                                        bottom: 5),
                                    child: Container(
                                      height: 45,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          dropdownColor: Colors.white,
                                          isDense: true,
                                          isExpanded: true,
                                          value: 'Select Category',
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          items: [],
                                          onChanged: null,
                                          /*items: dataSnapshot.data!.data?.map((list) {
                                            return DropdownMenuItem(
                                              value: list.name,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text(list.name!),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedLocation = value!;

                                              for (int i = 0;
                                              i <= dataSnapshot.data!.data!.length;
                                              i++) {
                                                if (selectedLocation ==
                                                    dataSnapshot.data!
                                                        .data![i].name!) {
                                                  selectedLocationId =
                                                      dataSnapshot.data!.data![i].id!
                                                          .toString();
                                                  break;
                                                }
                                              }
                                            });
                                            // getRouteData();
                                            routemodel =  Provider.of<AddEmployeeProvider>(context, listen: false)
                                                .routeModel;
                                            setState(() {

                                            });
                                          },*/
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0.0,
                                        top: 5,
                                        right: 0.0,
                                        bottom: 5),
                                    child: Container(
                                      height: 45,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          dropdownColor: Colors.white,
                                          isDense: true,
                                          isExpanded: true,
                                          value: 'Select Standard',
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          items: [],
                                          onChanged: null,
                                          /*items: dataSnapshot.data!.data?.map((list) {
                                            return DropdownMenuItem(
                                              value: list.name,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text(list.name!),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedLocation = value!;

                                              for (int i = 0;
                                              i <= dataSnapshot.data!.data!.length;
                                              i++) {
                                                if (selectedLocation ==
                                                    dataSnapshot.data!
                                                        .data![i].name!) {
                                                  selectedLocationId =
                                                      dataSnapshot.data!.data![i].id!
                                                          .toString();
                                                  break;
                                                }
                                              }
                                            });
                                            // getRouteData();
                                            routemodel =  Provider.of<AddEmployeeProvider>(context, listen: false)
                                                .routeModel;
                                            setState(() {

                                            });
                                          },*/
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0.0,
                                        top: 5,
                                        right: 0.0,
                                        bottom: 5),
                                    child: Container(
                                      height: 45,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          dropdownColor: Colors.white,
                                          isDense: true,
                                          isExpanded: true,
                                          value: 'Subject and charge',
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          items: [],
                                          onChanged: null,
                                          /*items: dataSnapshot.data!.data?.map((list) {
                                            return DropdownMenuItem(
                                              value: list.name,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text(list.name!),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedLocation = value!;

                                              for (int i = 0;
                                              i <= dataSnapshot.data!.data!.length;
                                              i++) {
                                                if (selectedLocation ==
                                                    dataSnapshot.data!
                                                        .data![i].name!) {
                                                  selectedLocationId =
                                                      dataSnapshot.data!.data![i].id!
                                                          .toString();
                                                  break;
                                                }
                                              }
                                            });
                                            // getRouteData();
                                            routemodel =  Provider.of<AddEmployeeProvider>(context, listen: false)
                                                .routeModel;
                                            setState(() {

                                            });
                                          },*/
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0.0,
                                        top: 5,
                                        right: 0.0,
                                        bottom: 5),
                                    child: Container(
                                      height: 45,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          dropdownColor: Colors.white,
                                          isDense: true,
                                          isExpanded: true,
                                          value: 'Online/Offline',
                                          iconEnabledColor: Colors.white,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          items: [],
                                          onChanged: null,
                                          /*items: dataSnapshot.data!.data?.map((list) {
                                            return DropdownMenuItem(
                                              value: list.name,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8.0),
                                                child: Text(list.name!),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              selectedLocation = value!;

                                              for (int i = 0;
                                              i <= dataSnapshot.data!.data!.length;
                                              i++) {
                                                if (selectedLocation ==
                                                    dataSnapshot.data!
                                                        .data![i].name!) {
                                                  selectedLocationId =
                                                      dataSnapshot.data!.data![i].id!
                                                          .toString();
                                                  break;
                                                }
                                              }
                                            });
                                            // getRouteData();
                                            routemodel =  Provider.of<AddEmployeeProvider>(context, listen: false)
                                                .routeModel;
                                            setState(() {

                                            });
                                          },*/
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  TextFormField(
                                    focusNode: _focusNodes[0],
                                    controller: _experienceController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.experience

                                    ),
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    validator: (String? value) {
                                      return (value != null &&
                                          value == "")
                                          ? 'Enter experience'
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    focusNode: _focusNodes[1],
                                    controller: _tutorLocationController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.tutorsLocation

                                    ), onSaved: (String? value) {
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    focusNode: _focusNodes[2],
                                    controller: _selectNearbyAreaController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.selectNearbyAreaKm

                                    ),
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    validator: (String? value) {
                                      return (value != null &&
                                          value == "")
                                          ? 'Enter mobile'
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    focusNode: _focusNodes[3],
                                    controller: _nocController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.noc

                                    ),
                                    onSaved: (String? value) {
                                      // This optional block of code can be used to run
                                      // code when the user saves the form.
                                    },
                                    validator: (String? value) {
                                      return (value != null &&
                                          value == "")
                                          ? 'Enter address'
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'KYC Details',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  TextFormField(
                                    focusNode: _focusNodes[4],
                                    controller: _aadhaarController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.aadhaarCard

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
                                    focusNode: _focusNodes[5],
                                    controller: _panNoController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.panNO

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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Bank Details',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: _bankNameController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.bankName

                                    ), onSaved: (String? value) {
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
                                    controller: _accountHolderNameController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.accountHolderName

                                    ), onSaved: (String? value) {
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
                                    controller: _accountNoController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.accountNo

                                    ), onSaved: (String? value) {
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
                                    controller: _ifscController,
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhite(
                                        TextConstant.ifsc

                                    ), onSaved: (String? value) {
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
                                        onPressed: _submit,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadiusDirectional.circular(10),
                                          // side: const BorderSide(color: kRedColor),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: const [
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
                              ))
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

  }

  void _submit() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MainScreen(),
    ));
  }
}
