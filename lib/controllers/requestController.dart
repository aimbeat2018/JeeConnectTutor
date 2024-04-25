import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jeeconnecttutor/model/commonRequestModel.dart';
import 'package:jeeconnecttutor/model/courseModel.dart';
import 'package:jeeconnecttutor/model/response/ChapterListResponseModel.dart';
import 'package:jeeconnecttutor/model/tutorRequestModel.dart';

import '../constant/app_constants.dart';
import '../model/loginModel.dart';
import '../model/response/SessionResponseModel.dart';
import '../model/response/sesssionStartRequestModel.dart';
import '../model/sessionDetailsModel.dart';
import '../model/updateProfileResponseModel.dart';
import '../repository/requestRepo.dart';

class RequestController extends GetxController implements GetxService {
  final RequestRepo requestRepo;

  RequestController({required this.requestRepo});

  List<TutorRequestModel>? tutorRequestList;
  List<TutorRequestModel>? acceptedTutorRequestList;
  List<TutorRequestModel>? completedTutorRequestList;

  TutorRequestModel? tutorRequestModel;
  ChapterListResponseModel? chapterListResponseModel;

  List<CourseModel>? courseModelList = [];

  UpdateProfileResponseModel? model;
  SessionResponseModel? sessionResponseModel;

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
          'API-KEY': 'ea3652c8-d890-44c6-9789-48dfc5832e79',
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

  Future<TutorRequestModel?> getSessionRequestList(
      {String? userid, String? flag}) async {
    _isLoading = true;
    Response response = await requestRepo.pendingPackageList(userid!, flag!);
    if (response.statusCode == 200) {
      tutorRequestModel = TutorRequestModel.fromJson(response.body);
    } else {
      tutorRequestModel = TutorRequestModel();
    }
    _isLoading = false;
    update();
    return tutorRequestModel;
  }

  Future<TutorRequestModel?> getPackageDetails({String? packageid}) async {
    _isLoading = true;
    Response response =
        await requestRepo.getpackageDetails(package_id: packageid);
    if (response.statusCode == 200) {
      tutorRequestModel = TutorRequestModel.fromJson(response.body);
    } else {
      tutorRequestModel = TutorRequestModel();
    }
    _isLoading = false;
    update();
    return tutorRequestModel;
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
      completedTutorRequestList = toResponseList(data);
    } else {
      completedTutorRequestList = [];
    }
    _isLoading = false;
    update();
    return completedTutorRequestList;
  }

  Future<UpdateProfileResponseModel?> acceptRequest(
      String packageid, String userid) async {
    _isLoading = true;
    update();

    Response response = await requestRepo.acceptRequest(
        package_purchase_id: packageid, instructorid: userid);

    if (response.statusCode == 200) {
      // if (response.body['status'] == 200) {
      model = UpdateProfileResponseModel.fromJson(response.body);
      // } else {
      //   model = UpdateProfileResponseModel(status: 403);
      // }
    } else {
      model = UpdateProfileResponseModel(status: '403');
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
      model = UpdateProfileResponseModel(status: '403');
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
      model = UpdateProfileResponseModel(status: '403');
    }
    _isLoading = false;
    update();
    return model;
  }

  Future<SessionDetailsModel?> sessionDetails(String id, String token) async {
    _isDetailsLoading = true;

    Response response = await requestRepo.sessionDetail(id);

    if (response.statusCode == 200) {
      sessionDetailsModel = SessionDetailsModel.fromJson(response.body);
    } else {
      sessionDetailsModel = SessionDetailsModel();
    }
    _isDetailsLoading = false;
    update();
    return sessionDetailsModel;
  }

  Future<ChapterListResponseModel?> getchapterlist(String packageid) async {
    _isDetailsLoading = true;
    Response response = await requestRepo.chapterList(packageid);
    if (response.statusCode == 200) {
      chapterListResponseModel =
          ChapterListResponseModel.fromJson(response.body);
    } else {
      chapterListResponseModel = ChapterListResponseModel();
    }
    _isDetailsLoading = false;
    update();
    return chapterListResponseModel;
  }

  List<SessionDetailsModel> toSessionList(List<dynamic> data) {
    List<SessionDetailsModel> value = <SessionDetailsModel>[];
    for (var element in data) {
      value.add(SessionDetailsModel.fromJson(element));
    }
    return value;
  }

  Future<SessionResponseModel?> startSession(SesssionStartRequestModel sesssionStartRequestModel) async {
    _isLoading = true;
    update();

    Response response = await requestRepo.startSession(sesssionStartRequestModel);

    if (response.statusCode == 200) {
      sessionResponseModel = SessionResponseModel.fromJson(response.body);
    } else {
      sessionResponseModel = SessionResponseModel(status: '403');
    }
    _isLoading = false;
    update();
    return sessionResponseModel;
  }

  Future<SessionResponseModel?> endSession(
      String id, String token, String startTime) async {
    _isLoading = true;
    update();

    Response response = await requestRepo.endSession(id, startTime);

    if (response.statusCode == 200) {
      sessionResponseModel = SessionResponseModel.fromJson(response.body);
    } else {
      sessionResponseModel = SessionResponseModel(status: '403');
    }
    _isLoading = false;
    update();
    return sessionResponseModel;
  }

  Future<UpdateProfileResponseModel?> addReview(String id, String token,
      String rating, String review, String chaptername) async {
    _isLoading = true;
    update();

    Response response =
        await requestRepo.addReview(id, rating, review, chaptername);

    if (response.statusCode == 200) {
      model = UpdateProfileResponseModel.fromJson(response.body);
    } else {
      model = UpdateProfileResponseModel(status: '403');
    }
    _isLoading = false;
    update();
    return model;
  }
}
