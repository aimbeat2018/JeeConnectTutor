import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jeeconnecttutor/model/updateProfileModel.dart';
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


  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }


}
