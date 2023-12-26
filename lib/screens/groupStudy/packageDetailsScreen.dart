import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../constant/colorsConstant.dart';


class PackageDetailScreen extends StatefulWidget {
  static const String routeName = '/packageDetail';

  const PackageDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() =>
      PackageDetailScreenState();
}

class PackageDetailScreenState
    extends State<PackageDetailScreen>
    with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kYellowColor,
        centerTitle: true,
        title: const Text(
          'Package Details',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Package Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Center(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/blue_rectangle.png',
                          fit: BoxFit.cover,
                          height: 70,
                          width: 380,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 25),
                              child: Text(
                                'Rs. 49,999/-',
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 25),
                              child: Text(
                                'BASIC',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'ENGLISH' /*.toUpperCase()*/,
                            style: TextStyle(
                                color: kBlueDarkColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        const Text(
                          'No. of Chapters : 05' /*.toUpperCase()*/,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1.0),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: Container(
                                                width: 5.0,
                                                height: 5.0,
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          const Text(
                                            'Chapter 1 : The Tiny Desert',
                                            maxLines: 3,
                                            style: TextStyle(
                                                color: kTextLowBlackColor,
                                                fontSize: 14,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.w600),
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
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Duration : 10 Months' /*.toUpperCase()*/,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'No. of Sessions : 15' /*.toUpperCase()*/,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
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
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15.0),
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: 'ENGLISH - ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                ),
                                TextSpan(
                                  text: 'Monday, 10:00 am',
                                  style: TextStyle(color: Colors.black87),
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
                      height: 5,
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
                          trimCollapsedText: ' view details',
                          trimExpandedText: ' show less',
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // selectImages();
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) =>
                              //       GroupStudyConfirmedPageScreen(),
                              // ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('ACCEPT',
                                style:
                                TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // selectImages();
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) =>
                              //       GroupStudyConfirmedPageScreen(),
                              // ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text('DECLINE',
                                style:
                                TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    )
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
