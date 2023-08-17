import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/screens/home/homeScreen.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/textConstant.dart';
import '../home/homeScreen.dart';

class ProfileScreen extends StatefulWidget {
  static const String name = 'profile';

  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String username = "Pranjal Deshmukh";
  String userId = "Pranjal2002";
  String contact = "9999999999";
  String email = "email";
  String password = "12345678";
  String location = "Haware Infotech Park, Vashi";
  String referPassword = "88888";

  bool hidePassword = true;
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final userIdController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();

  List<FocusNode> _focusNodes = [
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

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      drawer: SidebarX(
        controller: _controller,

        showToggleButton: false,
        theme: SidebarXTheme(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: canvasColor,
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          selectedTextStyle:
          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          itemTextPadding: const EdgeInsets.only(left: 30),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
            border: Border.all(color: canvasColor),
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: actionColor.withOpacity(0.37),
            ),
            gradient: const LinearGradient(
              colors: [canvasColor, accentCanvasColor],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.28),
                blurRadius: 30,
              )
            ],
          ),
          // iconTheme: const IconThemeData(
          //   color: Colors.black,
          //   size: 20,
          // ),
        ),
        extendedTheme: const SidebarXTheme(
          width: 300,
          decoration: BoxDecoration(
            color: canvasColor,
          ),
          margin: EdgeInsets.only(right: 10),
        ),
        // footerDivider: divider,
        headerBuilder: (context, extended) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ));
                },
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            radius: 20,
                            backgroundImage:
                            // dataSnapshot.data!.userProfileData ==
                            //     null
                            //     ?
                            AssetImage(
                              'assets/images/sliderSampleStudent.png',
                            )
                          // as ImageProvider
                          //     : NetworkImage(dataSnapshot.data!
                          //     .userProfileData!.imageUrl!),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 2.0, top: 25, bottom: 0,left: 0),
                        child: Column(
                          children: [
                            Text(
                              username,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 2, left: 12),
                              child: Text(
                                'User Id - Pranjal2002',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              debugPrint('Home');
            },
          ),
          const SidebarXItem(
            icon: Icons.school,
            label: 'Your Course',
          ),
          const SidebarXItem(
            icon: Icons.currency_rupee,
            label: 'Payment',
          ),
          const SidebarXItem(
            icon: Icons.lock,
            label: 'Change Password',
          ),
          const SidebarXItem(
            icon: Icons.money,
            label: 'Refer & Earn',
          ),
          const SidebarXItem(
            icon: Icons.help,
            label: 'Help',
          ),
          const SidebarXItem(
            icon: Icons.power_settings_new_outlined,
            label: 'Logout',
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: kYellowColor,
        centerTitle: true,
        title: Text(
          'Profile',
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                    // dataSnapshot.data!.userProfileData ==
                    //     null
                    //     ?
                    AssetImage(
                      'assets/images/sliderSampleStudent.png',
                    )
                    // as ImageProvider
                    //     : NetworkImage(dataSnapshot.data!
                    //     .userProfileData!.imageUrl!),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Form(
                              child: Column(
                                children: [
                                  TextFormField(
                                    focusNode: _focusNodes[0],
                                    controller: _nameController,
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
                                      labelText: TextConstant.name,
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
                                          value=="")
                                          ? 'Enter name'
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    focusNode: _focusNodes[1],
                                    controller: userIdController,
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
                                      labelText: TextConstant.userId,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(color: Colors.black),
                                    ),
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    focusNode: _focusNodes[2],
                                    controller: _mobileController,
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
                                          value=="")
                                          ? 'Enter mobile'
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    focusNode: _focusNodes[3],
                                    controller: _emailController,
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
                                      labelText: TextConstant.email,
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
                                          value=="")
                                          ? 'Enter address'
                                          : null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    focusNode: _focusNodes[4],
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
                                    height: 20,
                                  ),
                                  TextFormField(
                                    focusNode: _focusNodes[5],
                                    controller: _addressController,
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
                                      labelText: TextConstant.address,
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
                                  new InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //   builder: (context) => const HomeScreen(),
                                      // ));
                                    },
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        TextConstant.refer_earn,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
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
}
