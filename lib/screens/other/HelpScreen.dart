import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/constant/colorsConstant.dart';
import 'package:provider/provider.dart';

import '../../constant/globalFunction.dart';
import '../../controllers/authController.dart';
import '../../model/termsPrivacyHelpDynamicContentResponseModel.dart';

class HelpScreen extends StatefulWidget {
  static const String routeName = '/helpScreen';

  HelpScreen({super.key});

  @override
  State<StatefulWidget> createState() => HelpScreenState();
}

class HelpScreenState extends State<HelpScreen>
    with TickerProviderStateMixin {
  String? email, phone, address;
  TermsPrivacyHelpDynamicContentResponseModel? termsPrivacyHelpDynamicContentResponseModel;


  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(Duration.zero, () async {
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
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Help',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: email == "" || email == null || phone == "" || phone == null ||
              address == "" || address == null ?
          Center(child: const CircularProgressIndicator()) :
          Card(
            elevation: 10,
            color: CupertinoColors.lightBackgroundGray,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text(
                      "Contact number : ${phone!}\n\nEmail Address : ${email!}\n\nAddress : ${address!}",
                      style: TextStyle(color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),)

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
/*
  Future<TermsPrivacyHelpDynamicContentResponseModel?> dynamicContent() async {
    TermsPrivacyHelpDynamicContentResponseModel? termsPrivacyHelpDynamicContentResponseModel;
    try {
      termsPrivacyHelpDynamicContentResponseModel =
      await Provider.of<HomeProvider>(context, listen: false)
          .dynamicContent();

      email = termsPrivacyHelpDynamicContentResponseModel!.email;
      phone = termsPrivacyHelpDynamicContentResponseModel!.phone;
      address = termsPrivacyHelpDynamicContentResponseModel!.address;

      setState(() {});
    } on HttpException {
      var errorMsg = 'Auth failed';
      GlobalFunctions.showErrorDialog(errorMsg, context);
    } catch (error) {
      String errorMsg = error.toString();

      GlobalFunctions.showErrorDialog(errorMsg, context);
    }
  }*/

  Future<void> getDynamicContent() async {

    termsPrivacyHelpDynamicContentResponseModel = await Get.find<AuthController>()
        .dynamicContent();

    phone = termsPrivacyHelpDynamicContentResponseModel!.phone!;
    email = termsPrivacyHelpDynamicContentResponseModel!.email!;
    address = termsPrivacyHelpDynamicContentResponseModel!.address!;
  }

}
