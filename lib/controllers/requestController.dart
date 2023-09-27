import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jeeconnecttutor/model/commonRequestModel.dart';
import 'package:jeeconnecttutor/model/courseModel.dart';
import 'package:jeeconnecttutor/model/tutorRequestModel.dart';

import '../constant/app_constants.dart';
import '../model/sessionDetailsModel.dart';
import '../model/updateProfileResponseModel.dart';
import '../repository/requestRepo.dart';

class RequestController extends GetxController implements GetxService {
  final RequestRepo requestRepo;

  RequestController({required this.requestRepo});

  List<TutorRequestModel>? tutorRequestList;
  List<TutorRequestModel>? acceptedTutorRequestList;
  List<TutorRequestModel>? completedTutorRequestList;

  List<CourseModel>? courseModelList = [];

  UpdateProfileResponseModel? model;

  SessionDetailsModel? sessionDetailsModel;

  bool? _isLoading = false;
  bool? _isDetailsLoading = false;

  bool get isLoading => _isLoading!;

  bool get isDetailsLoading => _isDetailsLoading!;

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

    Response response = await requestRepo.acceptedRequestList(
        CommonRequestModel(authToken: token, fromDate: "", toDate: ""));

    if (response.statusCode == 200) {
      List data = response.body;
      acceptedTutorRequestList = toResponseList(data);
    } else {
      acceptedTutorRequestList = [];
    }
    _isLoading = false;
    update();
    return acceptedTutorRequestList;
  }

  Future<List<TutorRequestModel>?> getCompletedTutorRequestList(
      String token) async {
    _isLoading = true;
    // update();

    // String token = courseRepo.getUserToken();

    Response response = await requestRepo
        .completedRequestList(CommonRequestModel(authToken: token));

    if (response.statusCode == 200) {
      List data = response.body;
      acceptedTutorRequestList = toResponseList(data);
    } else {
      acceptedTutorRequestList = [];
    }
    _isLoading = false;
    update();
    return acceptedTutorRequestList;
  }

  Future<UpdateProfileResponseModel?> acceptRequest(
      String id, String token) async {
    _isLoading = true;
    update();

    Response response = await requestRepo
        .acceptRequest(CommonRequestModel(id: id, authToken: token));

    if (response.statusCode == 200) {
      // if (response.body['status'] == 200) {
      model = UpdateProfileResponseModel.fromJson(response.body);
      // } else {
      //   model = UpdateProfileResponseModel(status: 403);
      // }
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

    Response response = await requestRepo
        .declineRequest(CommonRequestModel(id: id, authToken: token));

    if (response.statusCode == 200) {
      // if (response.body['status'] == 200) {
      model = UpdateProfileResponseModel.fromJson(response.body);
      // } else {
      //   model = UpdateProfileResponseModel(status: 403);
      // }
    } else {
      model = UpdateProfileResponseModel(status: 403);
    }
    _isLoading = false;
    update();
    return model;
  }

  Future<UpdateProfileResponseModel?> cancelRequest(
      String id, String token) async {
    _isLoading = true;
    update();

    Response response = await requestRepo
        .cancelRequest(CommonRequestModel(id: id, authToken: token));

    if (response.statusCode == 200) {
      // if (response.body['status'] == 200) {
      model = UpdateProfileResponseModel.fromJson(response.body);
      // } else {
      //   model = UpdateProfileResponseModel(status: 403);
      // }
    } else {
      model = UpdateProfileResponseModel(status: 403);
    }
    _isLoading = false;
    update();
    return model;
  }

  Future<SessionDetailsModel?> sessionDetails(String id, String token) async {
    _isDetailsLoading = true;
    // update();

    Response response = await requestRepo
        .sessionDetail(CommonRequestModel(id: id, authToken: token));

    if (response.statusCode == 200) {
      // if (response.body['status'] == 200) {
      List data = json.decode(response.bodyString!);
      List<SessionDetailsModel> listData = toSessionList(data);

      for (var sessionModel in listData) {
        sessionDetailsModel = sessionModel;
      }
    } else {
      sessionDetailsModel = SessionDetailsModel();
    }
    _isDetailsLoading = false;
    update();
    return sessionDetailsModel;
  }

  List<SessionDetailsModel> toSessionList(List<dynamic> data) {
    List<SessionDetailsModel> value = <SessionDetailsModel>[];
    for (var element in data) {
      value.add(SessionDetailsModel.fromJson(element));
    }
    return value;
  }

  Future<UpdateProfileResponseModel?> startSession(
      String id, String token, String otp, String? startTime) async {
    _isLoading = true;
    update();

    Response response = await requestRepo.startSession(CommonRequestModel(
        id: id, authToken: token, otp: otp, startTime: startTime!));

    if (response.statusCode == 200) {
      // if (response.body['status'] == 200) {
      model = UpdateProfileResponseModel.fromJson(response.body);
      // } else {
      //   model = UpdateProfileResponseModel(status: 403);
      // }
    } else {
      model = UpdateProfileResponseModel(status: 403);
    }
    _isLoading = false;
    update();
    return model;
  }

  Future<UpdateProfileResponseModel?> endSession(
      String id, String token, String startTime) async {
    _isLoading = true;
    update();

    Response response = await requestRepo.endSession(
        CommonRequestModel(id: id, authToken: token, startTime: startTime));

    if (response.statusCode == 200) {
      // if (response.body['status'] == 200) {
      model = UpdateProfileResponseModel.fromJson(response.body);
      // } else {
      //   model = UpdateProfileResponseModel(status: 403);
      // }
    } else {
      model = UpdateProfileResponseModel(status: 403);
    }
    _isLoading = false;
    update();
    return model;
  }

  Future<UpdateProfileResponseModel?> addReview(
      String id, String token, String rating, String review) async {
    _isLoading = true;
    update();

    Response response = await requestRepo.addReview(CommonRequestModel(
        id: id, authToken: token, rating: rating, review: review));

    if (response.statusCode == 200) {
      // if (response.body['status'] == 200) {
      model = UpdateProfileResponseModel.fromJson(response.body);
      // } else {
      //   model = UpdateProfileResponseModel(status: 403);
      // }
    } else {
      model = UpdateProfileResponseModel(status: 403);
    }
    _isLoading = false;
    update();
    return model;
  }
}
