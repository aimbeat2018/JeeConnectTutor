import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeeconnecttutor/model/updateCourseModel.dart';
import 'package:jeeconnecttutor/model/updateProfileModel.dart';

import '../../constant/colorsConstant.dart';
import '../../constant/globalFunction.dart';
import '../../controllers/courseController.dart';
import '../../model/categoryModel.dart';

class CourseDetailsBottomSheetScreen extends StatefulWidget {
  final List<CategoryModel> categoryList;

  const CourseDetailsBottomSheetScreen({Key? key, required this.categoryList})
      : super(key: key);

  @override
  State<CourseDetailsBottomSheetScreen> createState() =>
      _CourseDetailsBottomSheetScreen();
}

class _CourseDetailsBottomSheetScreen
    extends State<CourseDetailsBottomSheetScreen> {
  String? selectedCategory,
      selectedSubCategory,
      selectedCategoryId,
      selectedSubCategoryId;
  List<SubCategories>? subCategoryList;
  List<UpdateCourseModel>? updateCourseList;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseController>(builder: (courseController) {
      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Add Course Details'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Select Category',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, top: 15, right: 0.0, bottom: 5),
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 6.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          dropdownColor: Colors.white,
                          isDense: true,
                          isExpanded: true,
                          value: selectedCategory,
                          iconEnabledColor: Colors.black,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          items: widget.categoryList.map((list) {
                            return DropdownMenuItem(
                              value: list.name,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(list.name!),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              selectedCategory = value!;

                              for (var categoryModel in widget.categoryList) {
                                if (selectedCategory == categoryModel.name) {
                                  selectedCategoryId = categoryModel.id!;
                                  subCategoryList = categoryModel.subCategories;
                                }
                              }

                              if (subCategoryList == null) {
                                courseController.getCategoryCourseList(
                                    selectedCategoryId!, "category");
                              } else if (subCategoryList!.isEmpty) {
                                courseController.getCategoryCourseList(
                                    selectedCategoryId!, "category");
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  subCategoryList != null
                      ? subCategoryList!.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Select Sub Category',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0,
                                      top: 15,
                                      right: 0.0,
                                      bottom: 5),
                                  child: Container(
                                    height: 45,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        dropdownColor: Colors.white,
                                        isDense: true,
                                        isExpanded: true,
                                        value: selectedSubCategory,
                                        iconEnabledColor: Colors.black,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        items: subCategoryList!.map((list) {
                                          return DropdownMenuItem(
                                            value: list.name,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(list.name!),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedSubCategory = value!;

                                            for (var subCategoryModel
                                                in subCategoryList!) {
                                              if (selectedSubCategory ==
                                                  subCategoryModel.name) {
                                                selectedSubCategoryId =
                                                    subCategoryModel.id!;
                                              }
                                            }

                                            courseController
                                                .getCategoryCourseList(
                                                    selectedSubCategoryId!,
                                                    "subcategory");
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox()
                      : SizedBox(),
                  courseController.courseModelList != null &&
                          !courseController.isLoading
                      ? courseController.courseModelList!.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    'Course & Charges',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                    itemCount: courseController
                                        .courseModelList!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                courseController
                                                    .courseModelList![index]
                                                    .title!,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                decoration: GlobalFunctions
                                                    .getInputDecoration(
                                                  "charge",
                                                ),
                                                onChanged: (String value) {
                                                  setState(() {
                                                    // updateCourseList
                                                    courseController
                                                        .courseModelList![index]
                                                        .charge = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            )
                          : SizedBox()
                      : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: MaterialButton(
                      elevation: 0,
                      color: kYellowColor,
                      onPressed: () {
                        ProfileCourse model = ProfileCourse();
                        model.categoryId = selectedCategoryId;
                        model.subCategoryId = selectedSubCategoryId;

                        Navigator.pop(context);
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        // side: const BorderSide(color: kRedColor),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Add',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
