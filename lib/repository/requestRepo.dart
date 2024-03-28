import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:jeeconnecttutor/model/commonRequestModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constant/app_constants.dart';
import '../constant/shared_pref_helper.dart';
import '../controllers/authController.dart';
import '../model/request/gradeRequestModel.dart';

class RequestRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  RequestRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> acceptRequest(
      {String? package_purchase_id, String? instructorid}) async {
    return await apiClient.postData(AppConstants.acceptRequest, {
      'instructor_id': instructorid,
      'package_purchase_id': package_purchase_id
    });
  }

  Future<Response> declineRequest(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.declineRequest, jsonEncode(model.toJson()));
  }

  Future<Response> cancelRequest(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.cancelRequest, jsonEncode(model.toJson()));
  }

  Future<Response> startSession(
      String sessionid, String otp, String starttime) async {
    return await apiClient.postData(AppConstants.sessionStart,
        {'session_id': sessionid, 'otp': otp, 'start_time': starttime});
  }

  Future<Response> endSession(String sessionid, String time) async {
    return await apiClient.postBodyData(
        AppConstants.sessionEnd, {'session_id': sessionid, 'end_time': time});
  }

  Future<Response> addReview(
      String sessionid, String rating,String instreview,String chaptername) async {
    return await apiClient.postBodyData(AppConstants.addReview, {
      'session_id': sessionid,
      'rating': rating,
      'user_id':Get.find<AuthController>().getUserId(),
      'ins_review': instreview,
      'chapter_name':chaptername
    });
  }

  Future<Response> acceptedRequestList(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.instructorAcceptedRequestList, jsonEncode(model.toJson()));
  }

  Future<Response> pendingPackageList(String instructor_id, String flag) async {
    return await apiClient.postData(AppConstants.pendingPackageList,
        {"instructor_id": instructor_id, "flag": flag});
  }

  Future<Response> getpackageDetails({String? package_id}) async {
    return await apiClient
        .postData(AppConstants.packageDetails, {"package_id": package_id});
  }

  Future<Response> completedRequestList(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.instructorCompletedRequestList,
        jsonEncode(model.toJson()));
  }

  Future<Response> sessionDetail(String id) async {
    return await apiClient
        .postData(AppConstants.sessionDetails, {'session_id': id});
  }
  Future<Response> chapterList(String packageid) async{
    return await apiClient.postData(AppConstants.chapterList, {
      'package_id':packageid
    });
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

  Future<bool> saveUserId(String userId) async {
    return await sharedPreferences.setString(AppConstants.userId, userId);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  String getUserRole() {
    return sharedPreferences.getString(AppConstants.userRole) ?? "";
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
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
