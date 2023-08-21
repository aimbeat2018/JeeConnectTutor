import 'package:flutter/material.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/constant/globalFunction.dart';
import 'package:jeeconnecttutor/constant/textConstant.dart';
import 'package:jeeconnecttutor/screens/home/mainScreen.dart';

class SubjectListingScreen extends StatefulWidget {
  static const String name = 'subjectsListing';

  const SubjectListingScreen({super.key});

  @override
  State<StatefulWidget> createState() => SubjectListingScreenState();
}

class SubjectListingScreenState extends State<SubjectListingScreen>
    with TickerProviderStateMixin {
  bool _isLoading = false;

  List<String> _subjects = [
    "English",
    "Hindi",
    "Marathi",
    "Mathematics",
    "Science",
    "Environmental Studies",
    "Social Studies"
  ];

  late List<bool> _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = List<bool>.filled(_subjects.length, false);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kYellowColor,
          centerTitle: true,
          title: Text(
            'Subjects',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                children: [
                  Text(
                    '5th CLASS',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _subjects.length,
                        itemBuilder: (context, index) {
                          return CheckboxListTile(

                            title: Text(_subjects[index]),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 20,
                                  child: TextFormField(
                                    decoration: GlobalFunctions
                                        .getInputDecorationWhiteBGBlackBroderColor(
                                        TextConstant.enterChargePerHour,
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
                                ),
                            ),
                            value: _isChecked[index],
                            onChanged: (val) {

                              setState(
                                () {
                                  _isChecked[index] = val!;
                                },
                              );
                            },
                          );
                        }),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 14)),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ));
                    },
                    child: const Text('Enroll subjects'),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
