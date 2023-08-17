import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:sidebarx/sidebarx.dart';

import '../userAuth/profileScreen.dart';

const primaryColor = kStarColor;
const canvasColor = kLiveClassColor;
const scaffoldBackgroundColor = kComplimentaryBackgroundColor;
const accentCanvasColor = kYellowColor;
const white = Colors.white;
const actionColor = Colors.black;

final divider = Divider(color: Colors.black.withOpacity(0.5), height: 1);

class ScheduleListingScreen extends StatefulWidget {
  static const String name = 'schedule';

  ScheduleListingScreen({super.key});

  @override
  State<StatefulWidget> createState() => ScheduleListingScreenState();
}

class ScheduleListingScreenState extends State<ScheduleListingScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = "Pranjal Deshmukh";

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
          'Schedule',
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: SizedBox(
          height: 1000,
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Monday",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              ListView.builder(
                                  itemCount: 2,
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                          color: Colors.pink,
                                          child: ListTile(
                                              title: Text(
                                                "Mathematics",
                                                style: TextStyle(fontSize: 11,
                                                    fontWeight: FontWeight.w700, color: Colors.white),
                                              ),
                                              // subtitle: Text("June 05, 2023",
                                              //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                                              subtitle: Padding(
                                                  padding: const EdgeInsets.only(left: 0, right: 8.0),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: <Widget>[
                                                      Text("June 05, 2023",
                                                        style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400, color: Colors.white),),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: <Widget>[
                                                            Text("10.00 am to 11.00 am",softWrap: true,
                                                              style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal, color: Colors.white),),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              ),
                                              // leading: Padding(
                                              //   padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                                              //   child: VerticalDivider(
                                              //     thickness: 4,
                                              //     color: Colors.white,
                                              //   ),
                                              // ),
                                              trailing: Icon(
                                                Icons.arrow_forward_ios_sharp,
                                                color: Colors.white,
                                                size: 14,
                                              ))),
                                    );
                                  }),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          /*  ListView(padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    children: <Widget>[
              Container(
                child: ListTile(
                  title: Column(
                    children: [
                      Text(
                        "Monday",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                      ListView.builder(
                          itemCount: 2,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Text('Child');
                          }),

                      // ListView(
                      //   padding: const EdgeInsets.all(8),
                      //   children: <Widget>[
                      //     Card(
                      //         color: Colors.pink,
                      //         child: ListTile(
                      //             title: Text(
                      //               "Mathematics",
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.w700,
                      //                   color: Colors.white),
                      //             ),
                      //             // subtitle: Text("June 05, 2023",
                      //             //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                      //             subtitle: Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 0, right: 8.0),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.start,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.center,
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   children: <Widget>[
                      //                     Text(
                      //                       "June 05, 2023",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.w400,
                      //                           color: Colors.white),
                      //                     ),
                      //                     Expanded(
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.end,
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.center,
                      //                         mainAxisSize: MainAxisSize.max,
                      //                         children: <Widget>[
                      //                           Text(
                      //                             "10.00 am to 11.00 am",
                      //                             softWrap: true,
                      //                             style: TextStyle(
                      //                                 fontWeight:
                      //                                     FontWeight.normal,
                      //                                 color: Colors.white),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 )),
                      //             leading: Padding(
                      //               padding: const EdgeInsets.only(
                      //                   top: 10.0, bottom: 10.0),
                      //               child: VerticalDivider(
                      //                 thickness: 5,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //             trailing: Icon(
                      //               Icons.arrow_forward_ios_sharp,
                      //               color: Colors.white,
                      //             ))),
                      //     Card(
                      //         color: Colors.pink,
                      //         child: ListTile(
                      //             title: Text(
                      //               "Mathematics",
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.w700,
                      //                   color: Colors.white),
                      //             ),
                      //             // subtitle: Text("June 05, 2023",
                      //             //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                      //             subtitle: Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 0, right: 8.0),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.start,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.center,
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   children: <Widget>[
                      //                     Text(
                      //                       "June 05, 2023",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.w400,
                      //                           color: Colors.white),
                      //                     ),
                      //                     Expanded(
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.end,
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.center,
                      //                         mainAxisSize: MainAxisSize.max,
                      //                         children: <Widget>[
                      //                           Text(
                      //                             "10.00 am to 11.00 am",
                      //                             softWrap: true,
                      //                             style: TextStyle(
                      //                                 fontWeight:
                      //                                     FontWeight.normal,
                      //                                 color: Colors.white),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 )),
                      //             leading: Padding(
                      //               padding: const EdgeInsets.only(
                      //                   top: 10.0, bottom: 10.0),
                      //               child: VerticalDivider(
                      //                 thickness: 5,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //             trailing: Icon(
                      //               Icons.arrow_forward_ios_sharp,
                      //               color: Colors.white,
                      //             ))),
                      //     Card(
                      //         color: Colors.pink,
                      //         child: ListTile(
                      //             title: Text(
                      //               "Mathematics",
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.w700,
                      //                   color: Colors.white),
                      //             ),
                      //             // subtitle: Text("June 05, 2023",
                      //             //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                      //             subtitle: Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 0, right: 8.0),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.start,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.center,
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   children: <Widget>[
                      //                     Text(
                      //                       "June 05, 2023",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.w400,
                      //                           color: Colors.white),
                      //                     ),
                      //                     Expanded(
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.end,
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.center,
                      //                         mainAxisSize: MainAxisSize.max,
                      //                         children: <Widget>[
                      //                           Text(
                      //                             "10.00 am to 11.00 am",
                      //                             softWrap: true,
                      //                             style: TextStyle(
                      //                                 fontWeight:
                      //                                     FontWeight.normal,
                      //                                 color: Colors.white),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 )),
                      //             leading: Padding(
                      //               padding: const EdgeInsets.only(
                      //                   top: 10.0, bottom: 10.0),
                      //               child: VerticalDivider(
                      //                 thickness: 5,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //             trailing: Icon(
                      //               Icons.arrow_forward_ios_sharp,
                      //               color: Colors.white,
                      //             ))),
                      //     Card(
                      //         color: Colors.pink,
                      //         child: ListTile(
                      //             title: Text(
                      //               "Mathematics",
                      //               style: TextStyle(
                      //                   fontWeight: FontWeight.w700,
                      //                   color: Colors.white),
                      //             ),
                      //             // subtitle: Text("June 05, 2023",
                      //             //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                      //             subtitle: Padding(
                      //                 padding: const EdgeInsets.only(
                      //                     left: 0, right: 8.0),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.start,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.center,
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   children: <Widget>[
                      //                     Text(
                      //                       "June 05, 2023",
                      //                       style: TextStyle(
                      //                           fontWeight: FontWeight.w400,
                      //                           color: Colors.white),
                      //                     ),
                      //                     Expanded(
                      //                       child: Row(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.end,
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.center,
                      //                         mainAxisSize: MainAxisSize.max,
                      //                         children: <Widget>[
                      //                           Text(
                      //                             "10.00 am to 11.00 am",
                      //                             softWrap: true,
                      //                             style: TextStyle(
                      //                                 fontWeight:
                      //                                     FontWeight.normal,
                      //                                 color: Colors.white),
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 )),
                      //             leading: Padding(
                      //               padding: const EdgeInsets.only(
                      //                   top: 10.0, bottom: 10.0),
                      //               child: VerticalDivider(
                      //                 thickness: 5,
                      //                 color: Colors.white,
                      //               ),
                      //             ),
                      //             trailing: Icon(
                      //               Icons.arrow_forward_ios_sharp,
                      //               color: Colors.white,
                      //             ))),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              )
            ])*/
          /*child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Card(
                  color: Colors.pink,
                  child: ListTile(
                      title: Text(
                        "Mathematics",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      // subtitle: Text("June 05, 2023",
                      //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 0, right: 8.0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Text("June 05, 2023",
                            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text("10.00 am to 11.00 am",softWrap: true,
                                  style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: VerticalDivider(
                          thickness: 5,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.white,
                      ))),
              Card(
                  color: Colors.pink,
                  child: ListTile(
                      title: Text(
                        "Mathematics",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      // subtitle: Text("June 05, 2023",
                      //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 8.0),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text("June 05, 2023",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text("10.00 am to 11.00 am",softWrap: true,
                                      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: VerticalDivider(
                          thickness: 5,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.white,
                      ))),
              Card(
                  color: Colors.pink,
                  child: ListTile(
                      title: Text(
                        "Mathematics",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      // subtitle: Text("June 05, 2023",
                      //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 8.0),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text("June 05, 2023",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text("10.00 am to 11.00 am",softWrap: true,
                                      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: VerticalDivider(
                          thickness: 5,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.white,
                      ))),
              Card(
                  color: Colors.pink,
                  child: ListTile(
                      title: Text(
                        "Mathematics",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      // subtitle: Text("June 05, 2023",
                      //   style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                      subtitle: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 8.0),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text("June 05, 2023",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text("10.00 am to 11.00 am",softWrap: true,
                                      style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: VerticalDivider(
                          thickness: 5,
                          color: Colors.white,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.white,
                      ))),
            ],
          ),*/
        ),
      ),
    );
  }
}
