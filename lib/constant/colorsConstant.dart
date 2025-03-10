// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

const BASE_URL =
    'https://jeeconnect.com/jeeconnectadmin/'; // Example: const BASE_URL = 'http://192.168.0.119/academy-demo';

// list of colors that we use in our app

const kPrimaryColor = Color(0xff302fb4);
const kBackgroundColor = Color(0xFFFFFFFF);
const kComplimentaryBackgroundColor = Color(0xFF7BA4FF);
const kDarkButtonBg = Color(0xFF273546);
const kSecondaryColor = Color(0xFF808080);
const kSelectItemColor = Color(0xFF000000);
const kRedColor = Color(0xFF303293);
const kYellowColor = Color(0xff302fb4);
const kYellowDimColor = Color(0xFFB6AFA7);
const kBlueColor = Color(0xFF68B0FF);
const kBlueDarkColor = Color(0xFF303293);
const kGreenColor = Color(0xFF43CB65);
const kGreenDimColor = Color(0xFFFFFFFF);
const kGreenPurchaseColor = Color(0xFF2BD0A8);
const kToastTextColor = Color(0xFFEEEEEE);
const kTextColor = Color(0xFF273242);
const kTextLightColor = Color(0xFF000000);
const kTextLowBlackColor = Colors.black38;
const kStarColor = Color(0xFFEFD358);
const kDeepBlueColor = Color(0xFF594CF5);
const kTabBarBg = Color(0xFFEEEEEE);
const kDarkGreyColor = Color(0xFF757575);
const kTextBlueColor = Color(0xFF5594bf);
const kTimeColor = Color(0xFF366cc6);
const kTimeBackColor = Color(0xFFe3ebf5);
const kLessonBackColor = Color(0xFFf8e5d2);
// const kLightBlueColor = Color(0xFFE7EEFE);
const kLightBlueColor = Color(0xFF4AA8D4);
const kFormInputColor = Color(0xFFc7c8ca);
const kNoteColor = Color(0xFFbfdde4);
const kLiveClassColor = Color(0xFFfff3cd);
const kSectionTileColor = Color(0xFFdddcdd);
// Color of Categories card, long arrow
const iCardColor = Color(0xFFF4F8F9);
const iLongArrowRightColor = Color(0xFF559595);
const otpColor = Color(0xFF0B0ABE);

const primaryColor = kStarColor;
const canvasColor = kLiveClassColor;
const scaffoldBackgroundColor = kComplimentaryBackgroundColor;
const accentCanvasColor = kYellowColor;
const white = Colors.white;
const actionColor = Colors.black;
const gradient1 = Color(0xFF312FB4);
const gradient1_1 = Color(0xFF3432BF);
const gradient1_5 = Color(0xFF1D1C69);
const gradient2 = Color(0xFF030308);
const cgradient1 = Color(0xFF3000EE);
const cgradient1_1 = Color(0xFF400BBB);
const cgradient2 = Color(0xFF4909B4);
const cgradient2_1 = Color(0xFF7A008D);
const violet = Color(0xFFCF3FFF);
const btnColor = Color(0xFF302FBD);


const kDefaultInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide(color: Colors.white, width: 2),
);

const kDefaultFocusInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
  borderSide: BorderSide(color: kBlueColor, width: 2),
);
const kDefaultFocusErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(color: kRedColor),
  borderRadius: BorderRadius.all(Radius.circular(12.0)),
);

// our default Shadow
const kDefaultShadow = BoxShadow(
  offset: Offset(20, 10),
  blurRadius: 20,
  color: Colors.black12, // Black color with 12% opacity
);
