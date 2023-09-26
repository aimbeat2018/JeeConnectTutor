import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jeeconnecttutor/model/categoryModel.dart';
import 'package:jeeconnecttutor/model/courseModel.dart';
import 'package:jeeconnecttutor/repository/courseRepo.dart';

import '../constant/app_constants.dart';

class CourseController extends GetxController implements GetxService {
  final CourseRepo courseRepo;

  CourseController({required this.courseRepo});

  List<CategoryModel>? categoryList;

  List<CourseModel>? courseModelList = [];

  bool? _isLoading = false;

  bool get isLoading => _isLoading!;

  Future<List<CategoryModel>?> getCategoryList(String token) async {
    _isLoading = true;
    // update();

    // String token = courseRepo.getUserToken();

    var url =
        '${AppConstants.baseUrl}${AppConstants.categoryList}?auth_token=$token';

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
        categoryList = toResponseList(data);
      } else {
        categoryList = [];
      }
    } catch (error) {
      rethrow;
    }
    _isLoading = false;
    update();
    return categoryList;
  }

  List<CategoryModel> toResponseList(List<dynamic> data) {
    List<CategoryModel> value = <CategoryModel>[];
    for (var element in data) {
      value.add(CategoryModel.fromJson(element));
    }
    return value;
  }

  Future<List<CourseModel>?> getCategoryCourseList(
      String categoryId, String from) async {
    _isLoading = true;
    update();

    // String token = courseRepo.getUserToken();
    String url;
    if (from == "category") {
      url =
          '${AppConstants.baseUrl}${AppConstants.categoryWiseCourse}?category_id=$categoryId';
    } else {
      url =
          '${AppConstants.baseUrl}${AppConstants.subCategoryWiseCourse}?sub_category_id=$categoryId';
    }

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
        courseModelList = [];
        courseModelList = toCourseList(data);
      } else {
        courseModelList = [];
      }
    } catch (error) {
      rethrow;
    }
    _isLoading = false;
    update();
    return courseModelList;
  }

  List<CourseModel> toCourseList(List<dynamic> data) {
    List<CourseModel> value = <CourseModel>[];
    for (var element in data) {
      value.add(CourseModel.fromJson(element));
    }
    return value;
  }
}
