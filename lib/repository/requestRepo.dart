import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:jeeconnecttutor/model/commonRequestModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constant/app_constants.dart';
import '../model/request/gradeRequestModel.dart';

class RequestRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  RequestRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> acceptRequest(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.acceptRequest, jsonEncode(model.toJson()));
  }

  Future<Response> declineRequest(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.declineRequest, jsonEncode(model.toJson()));
  }

  Future<Response> cancelRequest(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.cancelRequest, jsonEncode(model.toJson()));
  }

  Future<Response> startSession(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.sessionStart, jsonEncode(model.toJson()));
  }

  Future<Response> endSession(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.sessionEnd, jsonEncode(model.toJson()));
  }

  Future<Response> addReview(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.addReview, jsonEncode(model.toJson()));
  }

  Future<Response> acceptedRequestList(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.instructorAcceptedRequestList, jsonEncode(model.toJson()));
  }

  Future<Response> completedRequestList(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.instructorCompletedRequestList,
        jsonEncode(model.toJson()));
  }

  Future<Response> sessionDetail(CommonRequestModel model) async {
    return await apiClient.postBodyData(
        AppConstants.sessionDetails, jsonEncode(model.toJson()));
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
