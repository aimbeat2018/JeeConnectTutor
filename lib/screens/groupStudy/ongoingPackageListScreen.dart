import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/screens/groupStudy/ongoingPackageDetailScreen.dart';

import '../../constant/colorsConstant.dart';

class OngoingPackagesListScreen extends StatefulWidget {
  static const String routeName = '/ongoingPackagesList';

  const OngoingPackagesListScreen({super.key});

  @override
  State<StatefulWidget> createState() => OngoingPackagesListScreenState();
}

class OngoingPackagesListScreenState
    extends State<OngoingPackagesListScreen>
    with TickerProviderStateMixin {

  List<String> _subjects = ['A', 'B', 'C', 'D'];
  List<String> _chapters = ['E', 'F', 'G', 'H'];
  String? selectedSubjects;
  String? selectedChapters;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kYellowColor,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
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
                  'Packages',
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
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              OngoingPackageDetailScreen(),
                        ));
                      },
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 300,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 79,
                                      width: 400,
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            'assets/images/blue_package_header.png',
                                            fit: BoxFit.cover,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 15.0, bottom: 25.0),
                                                child: Text(
                                                  '7th Std',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: kYellowColor,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w900),
                                                ),
                                              ),
                                              const Align(
                                                alignment: Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: 20.0),
                                                  child: Text(
                                                    'BASIC',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 23,
                                                        fontWeight: FontWeight.w900),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'No. of Students: 02',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'No. of Sessions: 15',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'Course duration: 10 Months',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'Batch Start From: DD/MM/YYYY',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'Total Seats: 05',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'Total Seats: 05',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'ENGLISH - Monday, 10:00 am',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2.0),
                                      child: Text(
                                        'HINDI - Tuesday, 09:00 am',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: const Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Select Subjects',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black54,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: _subjects
                                            .map((String item) => DropdownMenuItem<String>(
                                          value: item.toString(),
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black54,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                            .toList(),
                                        value: selectedSubjects,
                                        onChanged: (String? value) {
                                          setState(() {
                                            // selectedValue = value;
                                            // setState(() {
                                            //   // _tabController.index = 0;
                                            //   _tabController.animateTo(_selectedIndex);
                                            // });
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 30,
                                          width: 180,
                                          padding: const EdgeInsets.only(left: 14, right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.black, width: 1),
                                            color: kToastTextColor,
                                          ),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ),
                                          iconSize: 20,
                                          iconEnabledColor: kPrimaryColor,
                                          iconDisabledColor: kPrimaryColor,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: kToastTextColor,
                                          ),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness: MaterialStateProperty.all<double>(6),
                                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                                          ),
                                        ),
                                        menuItemStyleData: const MenuItemStyleData(
                                          height: 40,
                                          padding: EdgeInsets.only(left: 14, right: 14),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: const Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Select Chapters',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black54,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        items: _chapters
                                            .map((String item) => DropdownMenuItem<String>(
                                          value: item.toString(),
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                            .toList(),
                                        value: selectedChapters,
                                        onChanged: (String? value) {
                                          setState(() {
                                            // selectedValue = value;
                                            // setState(() {
                                            //   // _tabController.index = 0;
                                            //   _tabController.animateTo(_selectedIndex);
                                            // });
                                          });
                                        },
                                        buttonStyleData: ButtonStyleData(
                                          height: 30,
                                          width: 180,
                                          padding: const EdgeInsets.only(left: 14, right: 14),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.black, width: 1),
                                            color: kToastTextColor,
                                          ),
                                        ),
                                        iconStyleData: const IconStyleData(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                          ),
                                          iconSize: 20,
                                          iconEnabledColor: kPrimaryColor,
                                          iconDisabledColor: kPrimaryColor,
                                        ),
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          width: 250,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14),
                                            color: kToastTextColor,
                                          ),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness: MaterialStateProperty.all<double>(6),
                                            thumbVisibility: MaterialStateProperty.all<bool>(true),
                                          ),
                                        ),
                                        menuItemStyleData: const MenuItemStyleData(
                                          height: 40,
                                          padding: EdgeInsets.only(left: 14, right: 14),
                                        ),
                                      ),
                                    ),
                                    // : SizedBox(),
                                    SizedBox(
                                      height: 10,
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
                                          backgroundColor: kBlueDarkColor,
                                        ),
                                        child: const Text('SUBMIT',
                                            style:
                                            TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    )
                                  ],
                                )),
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
