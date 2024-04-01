import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeeconnecttutor/model/updateProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constant/app_constants.dart';
import '../model/request/gradeRequestModel.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(
      {String? phone, String? password, String? deviceToken}) async {
    return await apiClient.postData(
        AppConstants.login, {"mobile_no": phone, "password": password,"token":deviceToken});
  }

  Future<Response> register(
      {String? firstName,
      String? lastName,
      String? phone,
      String? email,
      String? address,
      String? password,
      String? pincode,
      String? adhar,
      String? pan,
      String? bankname,
      String? holdername,
      String? accountNo,
      String? ifsc,
      String? referralCode,
      String? board,
      String? grade,
      String? subjects,
      String? token,
      String? modeOfTeachingSelected,
        XFile? resume}) async {

    return await apiClient.postMultipartData(
        AppConstants.registerInstructor, {
      "first_name": firstName!,
      "last_name": lastName!,
      "mobile_no": phone!,
      "email": email!,
      "address": address!,
      "password": password!,
      "pincode": pincode!,
      "aadhar_no": adhar!,
      "pan_no": pan!,
      "bank_name": bankname!,
      "account_holder_name": holdername!,
      "account_no": accountNo!,
      "ifsc_code": ifsc!,
      "referralCode": referralCode!,
      "board_id": board!,
      "grade_id": grade!,
      "subject_id": subjects!,
      "tokan": token!,
      "mode_of_teaching": modeOfTeachingSelected!
    }, [
      MultipartBody('resume', resume!)
    ]);
  }

  Future<Response> sendRegisterOtp({String? phone}) async {
    return await apiClient.postData(AppConstants.sendOtp, {
      "mobile_no": phone,
    });
  }
  Future<Response> sendForgotOtp({String? mobile}) async{
    return await apiClient.postData(AppConstants.sendforgotOtp, {
      'mobile_no':mobile
    });
  }

  Future<Response> subjectListingGradeWise(GradeRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.gradeWisemultiplesubjectslist, jsonEncode(model.toJson()));
  }

  Future<Response> updateProfile(UpdateProfileModel? model) async {
    return await apiClient.postBodyData(
        AppConstants.updateProfile, jsonEncode(model!.toJson()));
  }
  Future<Response> updatePassword(String mobile, String password) async {
    return await apiClient.postData(
        AppConstants.updatePassword, {"mobile_no": mobile, "new_password": password});
  }

  Future<Response> resetPassword({String? phone, String? password}) async {
    return await apiClient.postData(
        AppConstants.resetPassword, {"email": phone, "password": password});
  }

  Future<Response> getUserProfile({String? phone, String? password}) async {
    return await apiClient.getData(AppConstants.userProfile);
  }

  Future<Response> updateUserImage(XFile data) async {
    return await apiClient.postMultipartData(
        AppConstants.updateUserImage, {}, [MultipartBody('image', data)]);
  }

  Future<String?> _saveDeviceToken() async {
    String? _deviceToken = '@';
    if (!GetPlatform.isWeb) {
      try {
        // _deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {}
    }
    print('--------Device Token---------- $_deviceToken');
      return _deviceToken;
  }

  // for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  Future<bool> saveUserRole(String role) async {
    return await sharedPreferences.setString(AppConstants.userRole, role);
  }

  Future<bool> saveUserMobile(String userMobile) async {
    return await sharedPreferences.setString(AppConstants.userMobile, userMobile);
  }

  Future<bool> saveUserUniqueId(String userUniqueId) async {
    return await sharedPreferences.setString(AppConstants.userUniqueId, userUniqueId);
  }

  Future<bool> saveUserName(String userName) async {
    return await sharedPreferences.setString(AppConstants.userName, userName);
  }

  Future<bool> saveUserId(String userId) async {
    return await sharedPreferences.setString(AppConstants.userId, userId);
  }

  Future<bool> saveUserImage(String userImage) async {
    return await sharedPreferences.setString(AppConstants.userImage, userImage);
  }

  Future<bool> savereferral_code(String referral_code) async {
    return await sharedPreferences.setString(AppConstants.referral_code, referral_code);
  }

  Future<bool> savereferral_stud(String referral_stud) async {
    return await sharedPreferences.setString(AppConstants.referral_stud, referral_stud);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  String getUserUniqueId() {
    return sharedPreferences.getString(AppConstants.userUniqueId) ?? "";
  }


  String getUserImage() {
    return sharedPreferences.getString(AppConstants.userImage) ?? "";
  }

  String getreferral_code() {
    return sharedPreferences.getString(AppConstants.referral_code) ?? "";
  }

  String getreferral_stud() {
    return sharedPreferences.getString(AppConstants.referral_stud) ?? "";
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstants.userName) ?? "";
  }

  String getUserRole() {
    return sharedPreferences.getString(AppConstants.userRole) ?? "";
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }

  String getUserMobile() {
    return sharedPreferences.getString(AppConstants.userMobile) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.userMobile);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }
}
