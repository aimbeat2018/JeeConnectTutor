import 'package:get/get.dart';

import '../constant/custom_snackbar.dart';
import '../constant/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offAllNamed(RouteHelper.getLoginRoute());
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
