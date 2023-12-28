import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:readmore/readmore.dart';

import '../../constant/colorsConstant.dart';

class CompletedPackagesHistoryListScreen extends StatefulWidget {
  static const String routeName = '/completedPackagesHistoryList';

  const CompletedPackagesHistoryListScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      CompletedPackagesHistoryListScreenState();
}

class CompletedPackagesHistoryListScreenState
    extends State<CompletedPackagesHistoryListScreen>
    with TickerProviderStateMixin {
  String? selectedSubjects;
  String? selectedChapters;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      // duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    // controller.repeat(reverse: false);
    controller.value = 0.5;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kYellowColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Package History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          builder: (context) {
                            return SingleChildScrollView(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    // leading: Icon(Icons.share),
                                    title: Center(
                                        child: Text(
                                      'BASIC - 7th std',
                                      style: TextStyle(
                                        fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87),
                                    )),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 25.0,
                                                  vertical: 0.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 8.0),
                                                    child: Text(
                                                      'ENGLISH' /*.toUpperCase()*/,
                                                      style: TextStyle(
                                                          color: Colors.blueAccent,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 13.0),
                                                    child: Container(
                                                      height: 10,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      15)),
                                                          color: Colors.black38,
                                                          border: Border.all()),
                                                      child:
                                                          Padding(
                                                            padding: const EdgeInsets.all(1),
                                                            child: LinearProgressIndicator(
                                                        color: kGreenColor,
                                                        backgroundColor:
                                                              kGreenDimColor,
                                                        value: controller.value,
                                                        semanticsLabel:
                                                              'Linear progress indicator',
                                                      ),
                                                          ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        vertical: 12.5),
                                                    child: Text(
                                                      '50%',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontSize: 10),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 20.0),
                                              child: const Text(
                                                'No. of Chapters : 05' /*.toUpperCase()*/,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 0.0),
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: 5,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 25.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 4.0),
                                                          child: Row(
                                                            children: [
                                                              Center(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    width: 5.0,
                                                                    height: 5.0,
                                                                    decoration: const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .black54),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 6,
                                                              ),
                                                              const Text(
                                                                'Chapter 1 : The Tiny Desert',
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    color:
                                                                        kTextLowBlackColor,
                                                                    fontSize: 12,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Course Duration : 10 Months' /*.toUpperCase()*/,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'No. of Sessions : 15' /*.toUpperCase()*/,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          'Batch Starts from : DD/MM/YYYY' /*.toUpperCase()*/,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Schedule :' /*.toUpperCase()*/,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: 2,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (BuildContext context, int index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 15.0),
                                              child: RichText(
                                                text: TextSpan(
                                                  style:
                                                      DefaultTextStyle.of(context)
                                                          .style,
                                                  children: [
                                                    TextSpan(
                                                      text: 'ENGLISH - ',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    TextSpan(
                                                      text: 'Monday, 10:00 am',
                                                      style: TextStyle(
                                                          color: Colors.black87),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          'Requirements :' /*.toUpperCase()*/,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Html(
                                          data: 'Notebook\nPen\nMobile',
                                        ),
                                        Container(
                                          height: 100,
                                          child: Flexible(
                                            child: ReadMoreText(
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing e'
                                              'lit,Lorem ipsum dolor sit amet, consectetur adipi'
                                              'scing elit,Lorem ipsum dolor sit amet, consectetur.'
                                              ' adipiscing eliet, consectetur adipiscing elit,'
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing eli'
                                              'et, consectetur adipiscing elit,Lorem ipsum dolo'
                                              'r sit amet, consectetur adipiscing eliLorem '
                                              'ipsum dolor sit amet, consectetur adipiscing eli'
                                              't,Lorem ipsum dolor sit amet, consectetur adipis'
                                              'cing elit,Lorem ipsum dolor sit amet, consectetu'
                                              'r adipiscing eliet, consectetur adipiscing elit,'
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing'
                                              ' eliet, co'
                                              'nsectetur adipiscing elit,Lorem ipsum dolor sit ame'
                                              't, consectetur adipiscing eliLorem '
                                              'ipsum dolor sit amet, consectetur adipiscing e'
                                              'lit,Lorem ipsum dolor sit amet, consectetur adipi'
                                              'scing elit,Lorem ipsum dolor sit amet, consectetur.'
                                              ' adipiscing eliet, consectetur adipiscing elit,'
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing eli'
                                              'et, consectetur adipiscing elit,Lorem ipsum dolo'
                                              'r sit amet, consectetur adipiscing eliLorem '
                                              'ipsum dolor sit amet, consectetur adipiscing eli'
                                              't,Lorem ipsum dolor sit amet, consectetur adipis'
                                              'cing elit,Lorem ipsum dolor sit amet, consectetu'
                                              'r adipiscing eliet, consectetur adipiscing elit,'
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing'
                                              ' eliet, co'
                                              'nsectetur adipiscing elit,Lorem ipsum dolor sit ame'
                                              't, consectetur adipiscing eli',
                                              trimLines: 10,
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12),
                                              colorClickableText: Colors.pink,
                                              trimMode: TrimMode.Line,
                                              trimCollapsedText: 'view details',
                                              trimExpandedText: 'show less',
                                              moreStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.blue),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // Center(
                                        //   child: ElevatedButton(
                                        //     onPressed: () {
                                        //       // selectImages();
                                        //       // Navigator.of(context).push(MaterialPageRoute(
                                        //       //   builder: (context) =>
                                        //       //       GroupStudyConfirmedPageScreen(),
                                        //       // ));
                                        //     },
                                        //     style: ElevatedButton.styleFrom(
                                        //       backgroundColor: Colors.black,
                                        //     ),
                                        //     child: const Text('BUY NOW',
                                        //         style: TextStyle(
                                        //             fontWeight: FontWeight.bold)),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                          height: 5,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 145,
                          width: 350,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/blueCard.png',
                                fit: BoxFit.fitWidth,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.0, top: 5.0),
                                          child: Text(
                                            '7th Std',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: kYellowColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 10.0, top: 5.0),
                                          child: Text(
                                            'BASIC',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3),
                                      child: Text(
                                        'No. of Subjects : 02',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3),
                                      child: Text(
                                        'No. of Sessions : 15',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3),
                                      child: Text(
                                        'Course Duration : 10 Months',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 3),
                                      child: Text(
                                        'Start from DD/MM/YYYY',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
