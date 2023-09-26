import 'dart:async';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constant/app_constants.dart';

class RequestRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  RequestRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> acceptRequest(String token, String id) async {
    return await apiClient.postBodyData(
        AppConstants.acceptRequest, {"id": id, "auth_token": token});
  }

  Future<Response> declineRequest(String token, String id) async {
    return await apiClient.postBodyData(
        AppConstants.declineRequest, {"id": id, "auth_token": token});
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
