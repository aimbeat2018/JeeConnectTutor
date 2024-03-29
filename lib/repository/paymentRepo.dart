import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:jeeconnecttutor/controllers/authController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';
import '../constant/app_constants.dart';

class PaymentRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PaymentRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> login(
      {String? phone, String? password, String? deviceToken}) async {
    return await apiClient.getDataWithQuery(
        AppConstants.login, {"email": phone, "password": password});
  }

  Future<Response> completedPaymentCount() async {
    return await apiClient.postBodyData(
        AppConstants.instructorSessionsCompleteCount,
        {'user_id': await Get.find<AuthController>().getUserId()});
  }
  Future<Response> requestPayment(String? amount) async{
    return await apiClient.postBodyData(AppConstants.requestPayment, {
      'user_id': await Get.find<AuthController>().getUserId(),
      'total_amount':amount
    });
  }
  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }
}
