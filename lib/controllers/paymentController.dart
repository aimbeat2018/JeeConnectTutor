import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jeeconnecttutor/model/RequestPaymentModel.dart';
import 'package:jeeconnecttutor/model/commonAuthTokenRequestModel.dart';
import 'package:jeeconnecttutor/model/commonResponseModel.dart';
import 'package:jeeconnecttutor/model/completedSessionsListResponseModel.dart';
import 'package:jeeconnecttutor/repository/paymentRepo.dart';

import '../constant/app_constants.dart';

class PaymentController extends GetxController implements GetxService {
  final PaymentRepo paymentRepo;

  PaymentController({required this.paymentRepo});

  List<CompletedSessionsListResponseModel>? completedSessionsListResponseModel;
  CommonResponseModel? commonResponseModel;

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;


  Future<List<CompletedSessionsListResponseModel>?>
  getCompletedSessionsList() async {
    _isLoading = true;

    CommonAuthTokenRequestModel commonAuthTokenRequestModel =
    CommonAuthTokenRequestModel();

    commonAuthTokenRequestModel.authToken = paymentRepo.getUserToken();

    var url =
        '${AppConstants.baseUrl}${AppConstants
        .instructorSessionsCompleteCount}';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: jsonEncode(commonAuthTokenRequestModel.toJson()),
      );

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        completedSessionsListResponseModel = toResponseList(data);
      } else {
        completedSessionsListResponseModel = [];
      }
    } catch (error) {
      rethrow;
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


  Future<CommonResponseModel?>
      requestPayment(String? totalAmount) async {
    _isLoading = true;

    RequestPaymentModel requestPaymentModel =
    RequestPaymentModel();

    requestPaymentModel.authToken = paymentRepo.getUserToken();
    requestPaymentModel.totalAmount = totalAmount;

    var url =
        '${AppConstants.baseUrl}${AppConstants.requestPayment}';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: jsonEncode(requestPaymentModel.toJson()),
      );


      if (response.statusCode == 200) {
        commonResponseModel = CommonResponseModel.fromJson(json.decode(response.body));

      } else {
        commonResponseModel = CommonResponseModel(status: 403);
      }
      _isLoading = false;
      update();
      return commonResponseModel;
    }


}
