import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:jeeconnecttutor/model/termsPrivacyHelpDynamicContentResponseModel.dart';
import 'package:provider/provider.dart';

import '../../constant/globalFunction.dart';
import '../../constant/internetConnectivity.dart';
import '../../controllers/authController.dart';

class TermsAndConditionScreen extends StatefulWidget {
  static const String routeName = '/termsAndCondition';

  TermsAndConditionScreen({super.key});

  @override
  State<StatefulWidget> createState() => TermsAndConditionScreenState();
}

class TermsAndConditionScreenState extends State<TermsAndConditionScreen>
    with TickerProviderStateMixin {
  String? value;
  TermsPrivacyHelpDynamicContentResponseModel? termsPrivacyHelpDynamicContentResponseModel;


  String _connectionStatus = 'unKnown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    if (mounted){
      Future.delayed(Duration.zero, () async {
        CheckInternet.initConnectivity().then((value) => setState(() {
          _connectionStatus = value;
        }));
        _connectivitySubscription =
            _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
              CheckInternet.updateConnectionStatus(result).then((value) => setState(() {
                _connectionStatus = value;
              }));
            });
getDynamicContent();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      home: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kYellowColor,
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'Terms & Conditions',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: value==""||value==null?
              const CircularProgressIndicator():
                  Container(
                      color: kBackgroundColor,
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Html(
                          data: value
                        ),
                      )),
            ),
          ),
        ),
      ),
    );
  }

  getDynamicContent() async {

    termsPrivacyHelpDynamicContentResponseModel = await Get.find<AuthController>()
        .dynamicContent();

    value = termsPrivacyHelpDynamicContentResponseModel!.termsCondition!;
    setState(() {

    });
  }

  /*Future<TermsPrivacyHelpDynamicContentResponseModel?> dynamicContent() async {
    TermsPrivacyHelpDynamicContentResponseModel? termsPrivacyHelpDynamicContentResponseModel;
    try {
      termsPrivacyHelpDynamicContentResponseModel = await Provider.of<HomeProvider>(context, listen: false)
          .dynamicContent();

     value= termsPrivacyHelpDynamicContentResponseModel!.termsCondition;
setState(() {

});
    } on HttpException {
      var errorMsg = 'Auth failed';
      GlobalFunctions.showErrorDialog(errorMsg, context);
    } catch (error) {
      String errorMsg = error.toString();

      GlobalFunctions.showErrorDialog(errorMsg, context);
    }
  }*/

}
