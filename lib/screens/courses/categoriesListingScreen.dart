import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/screens/courses/subjectListingScreen.dart';

class CategoryListingScreen extends StatefulWidget {
  static const String name = 'categoryListing';

  const CategoryListingScreen({super.key});

  @override
  State<StatefulWidget> createState() => CategoryListingScreenState();
}

class CategoryListingScreenState extends State<CategoryListingScreen>
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
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: kYellowColor,
        centerTitle: true,
        title: Text(
          'Category',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(children: [
                          Text(
                            'ICSE',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(children: [
                            GestureDetector(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const SubjectListingScreen(),
                              )),
                              child: SizedBox(
                                  child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      physics: NeverScrollableScrollPhysics(),
                                      children: List.generate(9, (i) {
                                        return Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Container(
                                              height: 10,
                                                color: Color(0xFF3231BD),
                                                child: Center(
                                                  child: Text(
                                                    '5th\nCLASS',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ))
                                            /* child:SizedBox(
                                              height: 50,
                                              child: Center(
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      // decoration: BoxDecoration(
                                                      //     gradient: LinearGradient(colors: [
                                                      //       Color(0xff4477e3),
                                                      //       Color(0xff3c66c2),
                                                      //       Color(0xff3E4982)
                                                      //     ]),
                                                           color: const Color(
                                                               0xff3231bd),
                                                      //     image: DecorationImage(
                                                      //       fit: BoxFit.cover,
                                                      //       image: NetworkImage(
                                                      //           "https://miro.medium.com/max/1400/1*-6WdIcd88w3pfphHOYln3Q.png"),
                                                      //       colorFilter: new ColorFilter.mode(
                                                      //           Colors.black.withOpacity(0.19), BlendMode.dstATop),
                                                      //     ),
                                                      //     borderRadius: BorderRadius.only(
                                                      //         topLeft: Radius.circular(20),
                                                      //         bottomRight: Radius.circular(20))
                                                      // ),
                                                    ),
                                                    Positioned(
                                                      child: Container(
                                                        padding: EdgeInsets.all(10),
                                                        alignment: Alignment.center,

                                                        child: Text(
                                                          '5th\nCLASS',
                                                          textAlign: TextAlign.center,

                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),

                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),*/
                                            // SizedBox(
                                            //   height: 50,
                                            //   width: 50,
                                            //   child: Center(
                                            //     child: Column(
                                            //       children: [
                                            //         Text("hi"),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            );
                                      }))),
                            ),
                          ])
                        ]),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
