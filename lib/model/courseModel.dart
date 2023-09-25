class CourseModel {
  String? id;
  String? title;
  String? shortDescription;
  String? description;
  List<String>? outcomes;
  String? faqs;
  String? language;
  String? categoryId;
  String? subCategoryId;
  String? section;
  List<String>? requirements;
  String? price;
  String? discountFlag;
  String? discountedPrice;
  String? level;
  String? userId;
  String? thumbnail;
  String? videoUrl;
  String? dateAdded;
  String? lastModified;
  String? courseType;
  String? isTopCourse;
  String? isAdmin;
  String? status;
  String? courseOverviewProvider;
  String? metaKeywords;
  String? metaDescription;
  String? isFreeCourse;
  String? multiInstructor;
  String? enableDripContent;
  String? creator;
  String? expiryPeriod;
  String? isPopular;
  String? duration;
  int? rating;
  int? numberOfRatings;
  String? instructorName;
  String? instructorImage;
  int? totalEnrollment;
  String? shareableLink;
  String? charge = "0";
  bool? selected = false;

  CourseModel(
      {this.id,
      this.title,
      this.shortDescription,
      this.description,
      this.outcomes,
      this.faqs,
      this.language,
      this.categoryId,
      this.subCategoryId,
      this.section,
      this.requirements,
      this.price,
      this.discountFlag,
      this.discountedPrice,
      this.level,
      this.userId,
      this.thumbnail,
      this.videoUrl,
      this.dateAdded,
      this.lastModified,
      this.courseType,
      this.isTopCourse,
      this.isAdmin,
      this.status,
      this.courseOverviewProvider,
      this.metaKeywords,
      this.metaDescription,
      this.isFreeCourse,
      this.multiInstructor,
      this.enableDripContent,
      this.creator,
      this.expiryPeriod,
      this.isPopular,
      this.duration,
      this.rating,
      this.numberOfRatings,
      this.instructorName,
      this.instructorImage,
      this.totalEnrollment,
      this.shareableLink});

  CourseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDescription = json['short_description'];
    description = json['description'];
    outcomes = json['outcomes'].cast<String>();
    faqs = json['faqs'];
    language = json['language'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    section = json['section'];
    requirements = json['requirements'].cast<String>();
    price = json['price'];
    discountFlag = json['discount_flag'];
    discountedPrice = json['discounted_price'];
    level = json['level'];
    userId = json['user_id'];
    thumbnail = json['thumbnail'];
    videoUrl = json['video_url'];
    dateAdded = json['date_added'];
    lastModified = json['last_modified'];
    courseType = json['course_type'];
    isTopCourse = json['is_top_course'];
    isAdmin = json['is_admin'];
    status = json['status'];
    courseOverviewProvider = json['course_overview_provider'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    isFreeCourse = json['is_free_course'];
    multiInstructor = json['multi_instructor'];
    enableDripContent = json['enable_drip_content'];
    creator = json['creator'];
    expiryPeriod = json['expiry_period'];
    isPopular = json['is_popular'];
    duration = json['duration'];
    rating = json['rating'];
    numberOfRatings = json['number_of_ratings'];
    instructorName = json['instructor_name'];
    instructorImage = json['instructor_image'];
    totalEnrollment = json['total_enrollment'];
    shareableLink = json['shareable_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['outcomes'] = this.outcomes;
    data['faqs'] = this.faqs;
    data['language'] = this.language;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['section'] = this.section;
    data['requirements'] = this.requirements;
    data['price'] = this.price;
    data['discount_flag'] = this.discountFlag;
    data['discounted_price'] = this.discountedPrice;
    data['level'] = this.level;
    data['user_id'] = this.userId;
    data['thumbnail'] = this.thumbnail;
    data['video_url'] = this.videoUrl;
    data['date_added'] = this.dateAdded;
    data['last_modified'] = this.lastModified;
    data['course_type'] = this.courseType;
    data['is_top_course'] = this.isTopCourse;
    data['is_admin'] = this.isAdmin;
    data['status'] = this.status;
    data['course_overview_provider'] = this.courseOverviewProvider;
    data['meta_keywords'] = this.metaKeywords;
    data['meta_description'] = this.metaDescription;
    data['is_free_course'] = this.isFreeCourse;
    data['multi_instructor'] = this.multiInstructor;
    data['enable_drip_content'] = this.enableDripContent;
    data['creator'] = this.creator;
    data['expiry_period'] = this.expiryPeriod;
    data['is_popular'] = this.isPopular;
    data['duration'] = this.duration;
    data['rating'] = this.rating;
    data['number_of_ratings'] = this.numberOfRatings;
    data['instructor_name'] = this.instructorName;
    data['instructor_image'] = this.instructorImage;
    data['total_enrollment'] = this.totalEnrollment;
    data['shareable_link'] = this.shareableLink;
    return data;
  }
}
