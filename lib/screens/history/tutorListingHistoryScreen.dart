import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';

class TutorListingScreen extends StatefulWidget {
  static const String name = 'tutorListing';

  const TutorListingScreen({super.key});

  @override
  State<StatefulWidget> createState() => TutorListingScreenState();
}

class TutorListingScreenState extends State<TutorListingScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;

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
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        centerTitle: true,
        title: Text(
          'History',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Tutors',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              // Padding(
              // padding: const EdgeInsets.symmetric(vertical: 15.0),
              // child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 600,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: 4,
                                  physics:NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                              padding: const EdgeInsets.all(2),
                                              child: Card(
                                                color: Colors.white,
                                                elevation: 10,
                                                child: ListTile(
                                                  onTap: (){
                                                    // Navigator.of(context).push(MaterialPageRoute(
                                                    //   builder: (context) => const TodaysSessionScreen(),
                                                    // ));

                                                  },
                                                    title: Padding(
                                                      padding: const EdgeInsets.all(4.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                         Padding(
                                                           padding: const EdgeInsets.all(1.0),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Text(
                                                                 'Tutor Name',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                               Text(
                                                                 '',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                         Padding(
                                                           padding: const EdgeInsets.all(1.0),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Text(
                                                                 'Subject',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                               Text(
                                                                 'Mathematics',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                         Padding(
                                                           padding: const EdgeInsets.all(2.0),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Text(
                                                                 'Session Date',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                               Text(
                                                                 '29 - 05 - 2023',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                         Padding(
                                                           padding: const EdgeInsets.all(1.0),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Text(
                                                                 'Session Time',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                               Text(
                                                                 '10:00 AM - 11:00 PM',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                         Padding(
                                                           padding: const EdgeInsets.all(2.0),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Text(
                                                                 'Session No',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                               Text(
                                                                 '35',
                                                                 textAlign: TextAlign.right,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                         Padding(
                                                           padding: const EdgeInsets.all(1.0),
                                                           child: Row(
                                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                             children: [
                                                               Text(
                                                                 'Session Type',
                                                                 textAlign: TextAlign.left,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                               Text(
                                                                 'Online',
                                                                 textAlign: TextAlign.right,
                                                                 style: TextStyle(
                                                                     color: Colors.blue,
                                                                     fontSize: 14,
                                                                     fontWeight: FontWeight.normal),
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                        ],
                                                      ),
                                                    ),

                                                ),
                                              )),
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
