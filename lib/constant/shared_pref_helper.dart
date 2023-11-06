// ignore_for_file: constant_identifier_names, camel_case_types
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  Future<bool> setAuthToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.AuthToken.toString(), token);
  }

  Future<String?> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.AuthToken.toString());
  }

  Future<bool> setUserId(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.UserId.toString(), val);
  }

  Future<String?> getUserId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.UserId.toString());
  }

  Future<bool> setGetStartedFlag(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.GetStartedFlag.toString(), val);
  }

  Future<String?> getGetStartedFlag() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.GetStartedFlag.toString());
  }

  Future<bool> setName(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.Name.toString(), val);
  }

  Future<String?> getName() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.Name.toString());
  }

  Future<bool> setParentName(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.ParentName.toString(), val);
  }

  Future<String?> getParentName() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.ParentName.toString());
  }

  Future<bool> setPhoneNumber(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.PhoneNumber.toString(), val);
  }

  Future<String?> getPhoneNumber() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.PhoneNumber.toString());
  }

  Future<bool> setUniqueCode(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.UniqueCode.toString(), val);
  }

  Future<String?> getUniqueCode() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.UniqueCode.toString());
  }

  Future<bool> setRole(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.Role.toString(), val);
  }

  Future<String?> getRole() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.Role.toString());
  }

  Future<bool> setimage(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.image.toString(), val);
  }

  Future<String?> getimage() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.image.toString());
  }

  Future<bool> setemail(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.email.toString(), val);
  }

  Future<String?> getemail() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.email.toString());
  }

  Future<bool> setfacebook(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.facebook.toString(), val);
  }

  Future<String?> getfacebook() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.facebook.toString());
  }

  Future<bool> settwitter(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.twitter.toString(), val);
  }

  Future<String?> gettwitter() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.twitter.toString());
  }

  Future<bool> setlinkedin(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.linkedin.toString(), val);
  }

  Future<String?> getlinkedin() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.linkedin.toString());
  }

  Future<bool> setbiography(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.biography.toString(), val);
  }

  Future<String?> getbiography() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.biography.toString());
  }

  Future<bool> setAddress(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.Address.toString(), val);
  }

  Future<String?> getAddress() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.Address.toString());
  }

  Future<bool> setReferralCode(String val) async {
    final pref = await SharedPreferences.getInstance();
    return pref.setString(userPref.referralCode.toString(), val);
  }

  Future<String?> getReferralCode() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(userPref.referralCode.toString());
  }

}

enum userPref {
  AuthToken,
  UserId,
  GetStartedFlag,
  Name,
  ParentName,
  PhoneNumber,
  Address,
  UniqueCode,
  Role,
  image,
  email,
  facebook,
  twitter,
  linkedin,
  biography,
  referralCode,
}
