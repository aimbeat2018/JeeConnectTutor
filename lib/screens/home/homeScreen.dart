import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/model/commonResponseModel.dart';
import 'package:jeeconnecttutor/screens/groupStudy/categoriesScreen.dart';
import 'package:jeeconnecttutor/screens/payment/paymentScreen.dart';
import 'package:jeeconnecttutor/screens/schedule/acceptedSessionsListingScreen.dart';
import 'package:jeeconnecttutor/screens/sessions/sessionRequestsScreen.dart';
import 'package:jeeconnecttutor/screens/userAuth/updatePasswordScreen.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../constant/internetConnectivity.dart';
import '../../constant/textConstant.dart';
import '../../controllers/authController.dart';
import '../../model/response/bannerModel.dart';
import '../other/HelpScreen.dart';
import '../userAuth/profileScreen.dart';
import 'completedScreen.dart';

final List<String> imgList = [];

const primaryColor = kStarColor;
const canvasColor = kLiveClassColor;
const scaffoldBackgroundColor = kComplimentaryBackgroundColor;
const accentCanvasColor = kYellowColor;
const white = Colors.white;
const actionColor = Colors.black;

final divider = Divider(color: Colors.black.withOpacity(0.5), height: 1);

List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  ],
                )),
          ),
        ))
    .toList();

class HomeScreen extends StatefulWidget {
  static const String name = 'home';

  int currentIndex = 0;

  HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  CommonResponseModel? commonResponseModel;
  BannerModel bannerModel = BannerModel();
  String username = "";
  String userId = "";
  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
            _connectionStatus = value;
          }));
    });
    getBanners();

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
        headerDivider: divider,
        headerBuilder: (context, extended) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ));
                },
                child: Row(
                  children: [
                    /* const SizedBox(
                      height: 60,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: CircleAvatar(
                            radius: 25,
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
                    ),*/
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 2.0, top: 10, bottom: 0, left: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                Get.find<AuthController>()
                                    .getUserName()
                                    .toUpperCase(),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 2, left: 12),
                              child: Text(
                                'User Id - ${Get.find<AuthController>().getUserUniqueId()}',
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
              Navigator.pop(context);
            },
          ),
          // const SidebarXItem(
          //   icon: Icons.school,
          //   label: 'Your Course',
          // ),
          SidebarXItem(
            icon: Icons.currency_rupee,
            label: 'Payment',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PaymentScreen(),
              ));
            },
          ),
          SidebarXItem(
            icon: Icons.group,
            label: 'Group Study',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CategoriesScreen(),
              ));
            },
          ),
          SidebarXItem(
            icon: Icons.lock,
            label: 'Change Password',
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const UpdatePasswordScreen(),
              ));
            },
          ),
          SidebarXItem(
            icon: Icons.money,
            label: 'Refer & Earn',
            onTap: () {
              _referAndEarn(context);
            },
          ),
          SidebarXItem(
            icon: Icons.help,
            label: 'Help',
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HelpScreen(),
                  ));
            },
          ),
          SidebarXItem(
            icon: Icons.power_settings_new_outlined,
            label: 'Logout',
            onTap: () {
              Navigator.pop(context);
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Do you really like to logout?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        Get.find<AuthController>().clearSharedData();
                        final prefs = await SharedPreferences.getInstance();
                        prefs.remove('userData');
                        prefs.clear();
                        logout();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: kYellowColor,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          tooltip: 'Menu',
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Hello, ' + Get.find<AuthController>().getUserName() + '',
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            tooltip: 'Notifications',
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bannerModel.data == null
                    ? SizedBox()
                    : bannerModel.data!.isEmpty
                        ? SizedBox()
                        : CarouselSlider.builder(
                            options: CarouselOptions(
                              viewportFraction: 1.0,
                              height: 150,
                              scrollDirection: Axis.horizontal,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                // print(index);
                                widget.currentIndex = index;
                                // setState(() {
                                // });
                              },
                            ),
                            itemCount: bannerModel.data!.length,
                            itemBuilder: (BuildContext context, int index,
                                int realIndex) {
                              return ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: bannerModel.data![index].image!,
                                  alignment: Alignment.topCenter,
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  // placeholder: (context, url) => SizedBox(
                                  //     height: 50,
                                  //     width: 50,
                                  //     child: CircularProgressIndicator(
                                  //       color: primaryColor,
                                  //     )),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              );
                            },
                          ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 8.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        SessionRequestsScreen(),
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        //set border radius more than 50% of height and width to make circle
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/images/meeting.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Requests',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const AcceptedSessionsListingScreen(),
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        //set border radius more than 50% of height and width to make circle
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/images/schedule.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Schedule\n',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const CompletedSessionsScreen(),
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        //set border radius more than 50% of height and width to make circle
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/images/history.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'History',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const PaymentScreen(),
                                  ));
                                },
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        //set border radius more than 50% of height and width to make circle
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.asset(
                                          'assets/images/creditCard.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      'Payment',
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.clip,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getBanners() async {
    userId = (await Get.find<AuthController>().getUserId());

    bannerModel = await Get.find<AuthController>().getBanners();
    setState(() {});
  }

  logout() async {
    // commonResponseModel = await Get.find<AuthController>().logoutUser();
    // if (commonResponseModel!.status == 401) {
    Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
    // } else {
    //   showCustomSnackBar('Something went wrong!', isError: true);
    // }
  }

  void _referAndEarn(context) async {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        builder: (BuildContext bc) {
          return Container(
            alignment: Alignment.center,
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Refer & Earn',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      const Divider(
                        height: 2,
                        thickness: 2,
                        endIndent: 140,
                        indent: 140,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: Image.asset('assets/images/refer_and_earn.png',
                            height: 120),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'Hey ${username},  We\'re having an awesome offers.\nIf you refer a friend, you\'ll both get a coins for your next purchase!\nUse the code - ${Get.find<AuthController>().getUserUniqueId()} while registration.',
                          style: const TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                            const TextSpan(
                              text: 'Your referral code : ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  '${Get.find<AuthController>().getUserUniqueId()}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ])),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(kPrimaryColor),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(fontSize: 16),
                            ),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Share.share(
                                'Hey, I would like to suggest JeeConnect App for you!\nUse my referral code -$userId while registration to avail coins');
                          },
                          child: Text(
                            TextConstant.share,
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
