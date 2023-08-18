import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:sidebarx/sidebarx.dart';

const primaryColor = kStarColor;
const canvasColor = kLiveClassColor;
const scaffoldBackgroundColor = kComplimentaryBackgroundColor;
const accentCanvasColor = kYellowColor;
const white = Colors.white;
const actionColor = Colors.black;

final divider = Divider(color: Colors.black.withOpacity(0.5), height: 1);

class PaymentScreen extends StatefulWidget {
  static const String name = 'paymentScreen';

  const PaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen>
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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kYellowColor,
          title: Text(
            'Payment',
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
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
                    value: 'weekly',
                    child: Text(
                      'Weekly',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Monthly',
                    child: Text(
                      'Monthly',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'custom',
                    child: Text(
                      'Custom',
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
              } */
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Your Subjects",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                ListView.builder(
                    itemCount: 3,
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
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              trailing: Text(
                                "21",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            )),
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                        textStyle: const TextStyle(fontSize: 14)),
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const PaymentScreen(),
                      // ));
                    },
                    child: const Text('Request for payment'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
