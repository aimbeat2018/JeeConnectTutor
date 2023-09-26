import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jeeconnecttutor/model/courseModel.dart';
import 'package:jeeconnecttutor/model/tutorRequestModel.dart';

import '../constant/app_constants.dart';
import '../model/updateProfileResponseModel.dart';
import '../repository/requestRepo.dart';

class RequestController extends GetxController implements GetxService {
  final RequestRepo requestRepo;

  RequestController({required this.requestRepo});

  List<TutorRequestModel>? tutorRequestList;

  List<CourseModel>? courseModelList = [];

  UpdateProfileResponseModel? model;

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  Future<List<TutorRequestModel>?> getTutorRequestList(String token) async {
    _isLoading = true;
    // update();

    // String token = courseRepo.getUserToken();

    var url =
        '${AppConstants.baseUrl}${AppConstants.instructorRequestList}?auth_token=$token';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      // final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        tutorRequestList = toResponseList(data);
      } else {
        tutorRequestList = [];
      }
    } catch (error) {
      rethrow;
    }
    _isLoading = false;
    update();
    return tutorRequestList;
  }

  List<TutorRequestModel> toResponseList(List<dynamic> data) {
    List<TutorRequestModel> value = <TutorRequestModel>[];
    for (var element in data) {
      value.add(TutorRequestModel.fromJson(element));
    }
    return value;
  }

  Future<List<TutorRequestModel>?> getAcceptedTutorRequestList(
      String token) async {
    _isLoading = true;
    // update();

    // String token = courseRepo.getUserToken();

    var url =
        '${AppConstants.baseUrl}${AppConstants.instructorRequestList}?auth_token=$token';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      // final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        tutorRequestList = toResponseList(data);
      } else {
        tutorRequestList = [];
      }
    } catch (error) {
      rethrow;
    }
    _isLoading = false;
    update();
    return tutorRequestList;
  }

  Future<UpdateProfileResponseModel?> acceptRequest(
      String id, String token) async {
    _isLoading = true;
    update();

    Response response = await requestRepo.acceptRequest(id, token);

    if (response.statusCode == 200) {
      if (response.body['status'] == 200) {
        model = UpdateProfileResponseModel.fromJson(response.body);
        getTutorRequestList(token);
      } else {
        model = UpdateProfileResponseModel(status: 403);
      }
    } else {
      model = UpdateProfileResponseModel(status: 403);
    }
    _isLoading = false;
    update();
    return model;
  }

  Future<UpdateProfileResponseModel?> declineRequest(
      String id, String token) async {
    _isLoading = true;
    update();

    Response response = await requestRepo.declineRequest(id, token);

    if (response.statusCode == 200) {
      if (response.body['status'] == 200) {
        model = UpdateProfileResponseModel.fromJson(response.body);
      } else {
        model = UpdateProfileResponseModel(status: 403);
      }
    } else {
      model = UpdateProfileResponseModel(status: 403);
    }
    _isLoading = false;
    update();
    return model;
  }
}
