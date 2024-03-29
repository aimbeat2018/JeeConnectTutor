import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jeeconnecttutor/model/RequestPaymentModel.dart';
import 'package:jeeconnecttutor/model/commonAuthTokenRequestModel.dart';
import 'package:jeeconnecttutor/model/commonResponseModel.dart';
import 'package:jeeconnecttutor/model/completedSessionsListResponseModel.dart';
import 'package:jeeconnecttutor/model/updateProfileModel.dart';
import 'package:jeeconnecttutor/model/updateProfileResponseModel.dart';
import 'package:jeeconnecttutor/repository/paymentRepo.dart';

import '../constant/app_constants.dart';

class PaymentController extends GetxController implements GetxService {
  final PaymentRepo paymentRepo;

  PaymentController({required this.paymentRepo});

  CompletedSessionsListResponseModel? completedSessionsListResponseModel;
  CommonResponseModel? commonResponseModel;
  UpdateProfileResponseModel? updateProfileResponseModel;

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;


  Future<CompletedSessionsListResponseModel?>
  getCompletedSessionsList() async {
    _isLoading = true;
    Response response=await paymentRepo.completedPaymentCount();
    if(response.statusCode==200)
      {
        completedSessionsListResponseModel=CompletedSessionsListResponseModel.fromJson(response.body);
      }
    else {
      completedSessionsListResponseModel = CompletedSessionsListResponseModel(status: '403');
    }
    _isLoading = false;
    update();
    return completedSessionsListResponseModel;
  }

  List<CompletedSessionsListResponseModel> toResponseList(List<dynamic> data) {
    List<CompletedSessionsListResponseModel> value = <CompletedSessionsListResponseModel>[];
    data.forEach((element) {
      value.add(CompletedSessionsListResponseModel.fromJson(element));
    });
    return List<CompletedSessionsListResponseModel>.empty();
  }


  Future<UpdateProfileResponseModel?>
      requestPayment(String? totalAmount) async {
    _isLoading = true;

    Response response=await paymentRepo.requestPayment(totalAmount);
      if (response.statusCode == 200) {
        updateProfileResponseModel = UpdateProfileResponseModel.fromJson(json.decode(response.body));

      } else {
        updateProfileResponseModel = UpdateProfileResponseModel(status: '403');
      }
      _isLoading = false;
      update();
      return updateProfileResponseModel;
    }


}
