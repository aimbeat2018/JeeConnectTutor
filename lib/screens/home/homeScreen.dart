import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/screens/history/tutorListingHistoryScreen.dart';
import 'package:jeeconnecttutor/screens/payment/paymentScreen.dart';
import 'package:jeeconnecttutor/screens/schedule/scheduleListingScreen.dart';
import 'package:jeeconnecttutor/screens/sessions/todaysSessionsScreen.dart';
import 'package:sidebarx/sidebarx.dart';

import '../userAuth/profileScreen.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

const primaryColor = kStarColor;
const canvasColor = kLiveClassColor;
const scaffoldBackgroundColor = kComplimentaryBackgroundColor;
const accentCanvasColor = kYellowColor;
const white = Colors.white;
const actionColor = Colors.black;

final divider = Divider(color: Colors.black.withOpacity(0.5), height: 1);

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    // Positioned(
                    //   bottom: 0.0,
                    //   left: 0.0,
                    //   right: 0.0,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           Color.fromARGB(200, 0, 0, 0),
                    //           Color.fromARGB(0, 0, 0, 0)
                    //         ],
                    //         begin: Alignment.bottomCenter,
                    //         end: Alignment.topCenter,
                    //       ),
                    //     ),
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: 10.0, horizontal: 20.0),
                    //     child: Text(
                    //       'No. ${imgList.indexOf(item)} image',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 14.0,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                )),
          ),
        ))
    .toList();

class HomeScreen extends StatefulWidget {
  static const String name = 'home';

  HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  String username = "Pranjal Deshmukh";
  final TextEditingController _textSearchEditingController = TextEditingController();
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
        headerDivider: divider,
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
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,top: 10),
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
                    ),
                    SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 2.0, top: 10, bottom: 0,left: 0),
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
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          tooltip: 'Menu',
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Hello, ' + username + '',
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
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'scheduleContent',
                  child: Text(
                    'Schedule Content',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                PopupMenuItem(
                  value: 'testPapers',
                  child: Text(
                    'Test Papers',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                PopupMenuItem(
                  value: 'history',
                  child: Text(
                    'History',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
                PopupMenuItem(
                  value: 'Terms&Conditions',
                  child: Text(
                    'Terms & Conditions',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                )
              ];
            },
            color: Colors.white,
            onSelected: (String value) async {
             /* if (value == "extraSessions") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExtraSessionsScreen(),
                    ));
              } else if (value == "history") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TutorListingScreen(),
                    ));
              } else if (value == "scheduleContent") {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TodaysSessionScreen(),
                ));
              } else if (value == "uploadYourTestPaper") {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => ScheduleListingScreen(),
                // ));
              } else if (value == "newUpdate") {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => ScheduleListingScreen(),
                // ));
              } else if (value == "Terms&Conditions") {
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => ScheduleListingScreen(),
                // ));
              }*/
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true,
                    ),
                    items: imageSliders,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 8.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 40.0,
                                right: 40.0,
                                top: 8.0,
                                bottom: 18.0,
                              ),
                              child: SearchBar(
                                onChanged: (String value) {
                                  print('value: $value');
                                },
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 254, 242, 227)),
                                shape: MaterialStateProperty.all(
                                    const ContinuousRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                )),
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.blueAccent)),
                                hintText: 'Course...!',
                                constraints: const BoxConstraints(
                                  maxHeight: 45,
                                ),
                                controller: _textSearchEditingController,

                                trailing: [
                                  IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //   builder: (context) =>
                                    //       const CategoryListingScreen(),
                                    // ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/cbse.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Cbse\n      ',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //   builder: (context) =>
                                    //       const CategoryListingScreen(),
                                    // ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/icse.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Icse\n     ',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //   builder: (context) =>
                                    //       const CategoryListingScreen(),
                                    // ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/foreign_language.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Foreign\nLanguage',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
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
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //   builder: (context) =>
                                    //       const CategoryListingScreen(),
                                    // ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/talent-search.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Hunting Hidden\nTalent',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //   builder: (context) =>
                                    //       const CategoryListingScreen(),
                                    // ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/self-development.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Personality\nDevelopment',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //   builder: (context) =>
                                    //       const CategoryListingScreen(),
                                    // ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            'assets/images/mind-mapping.png',
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Brain\nMapping',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
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
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const TodaysSessionScreen(),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
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
                                      Text(
                                        'Sessions\n',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                           ScheduleListingScreen(),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
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
                                      Text(
                                        'Schedule\n',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const TutorListingScreen(),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
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
                                      Text(
                                        'History',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
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
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const PaymentScreen(),
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Card(
                                        elevation: 5,
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
                                      Text(
                                        'Payment',
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
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
      ),
    );
  }
}
