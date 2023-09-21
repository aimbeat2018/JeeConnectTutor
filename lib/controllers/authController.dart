import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jeeconnecttutor/constant/app_constants.dart';
import 'package:jeeconnecttutor/model/otpModel.dart';
import 'package:jeeconnecttutor/model/registerModel.dart';

import '../model/loginModel.dart';
import '../repository/authRepo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  LoginModel? loginModel;

  RegisterModel? registerModel;

  OtpModel? otpModel;

  String? msgReset;

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  // Future<CheckEmailModel?> checkEmail(String? phone) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await authRepo.checkEmail(phone: phone);
  //
  //   if (response.statusCode == 200) {
  //     responseModel = CheckEmailModel.fromJson(response.body);
  //   } else {
  //     responseModel = CheckEmailModel();
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }
  //
  Future<LoginModel?> loginUser(
      {String? phone, String? password, String? deviceToken}) async {
    _isLoading = true;
    update();

    var url =
        '${AppConstants.baseUrl}${AppConstants.login}?email=${phone!}&password=${password!}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      final responseData = json.decode(response.body);

      if (responseData['validity'] == 1) {
        loginModel = LoginModel.fromJson(json.decode(response.body));
        if (loginModel!.profileUpdated == "3") {
          authRepo.saveUserToken(loginModel!.token!);
          authRepo.saveUserId(loginModel!.userId!.toString());
        }
      } else {
        loginModel = LoginModel(validity: 0);
      }
    } catch (error) {
      rethrow;
    }
    _isLoading = false;
    update();
    return loginModel;
  }

  Future<RegisterModel?> registerUser(
      {String? name,
      String? email,
      String? phone,
      String? password,
      String? confirmPassword,
      String? pincode,
      String? deviceToken}) async {
    _isLoading = true;
    update();

    Response response = await authRepo.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
        pincode: pincode,
        deviceToken: deviceToken);

    if (response.statusCode == 200) {
      if (response.body['status'] == 200) {
        registerModel = RegisterModel.fromJson(response.body);
      } else {
        registerModel = RegisterModel(status: 403);
      }
    } else {
      registerModel = RegisterModel(status: 403);
    }
    _isLoading = false;
    update();
    return registerModel;
  }

  Future<OtpModel?> sendRegisterOtp({String? phone}) async {
    _isLoading = true;
    update();

    Response response = await authRepo.sendRegisterOtp(phone: phone);

    if (response.statusCode == 200) {
      if (response.body['status'] == 200) {
        otpModel = OtpModel.fromJson(response.body);
      } else {
        otpModel = OtpModel(status: 403);
      }
    } else {
      otpModel = OtpModel(status: 403);
    }
    _isLoading = false;
    update();
    return otpModel;
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  String getUserId() {
    return authRepo.getUserId();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
