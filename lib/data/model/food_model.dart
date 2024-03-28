class FoodModel {
  final String docId;
  final String foodDescription;
  final List<String> stepsList;
  late final String imageUrl;
  final String difficultly;
  final List<String> ingredientList;
  final String title;
  final String categoryId;
  final String timestamp;
  final String userName;
  final String userEmail;

  FoodModel({
    required this.docId,
    required this.userName,
    required this.userEmail,
    required this.timestamp,
    required this.foodDescription,
    required this.stepsList,
    required this.imageUrl,
    required this.difficultly,
    required this.ingredientList,
    required this.title,
    required this.categoryId,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      userEmail: json["userEmail"] as String? ?? '',
      userName: json["userName"] as String? ?? '',
      timestamp: json["timestamp"] as String? ?? '',
      docId: json["docId"] as String? ?? "",
      foodDescription: json["foodDescription"] as String? ?? "",
      // Ensure stepsList and ingredientList are casted to List<String>
      stepsList: (json["stepsList"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      imageUrl: json["imageUrl"] as String? ?? "",
      difficultly: json["difficultly"] as String? ?? "",
      // Ensure stepsList and ingredientList are casted to List<String>
      ingredientList: (json["ingredientList"] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      title: json["title"] as String? ?? "",
      categoryId: json["categoryId"] as String? ?? "",
    );
  }

  FoodModel copWith({
    String? docId,
    String? foodDescription,
    List<String>? stepsList,
    String? imageUrl,
    String? difficultly,
    List<String>? ingredientList,
    String? title,
    String? categoryId,
    String? timestamp,
    String? userName,
    String? userEmail,
  }) {
    return FoodModel(
        docId: docId ?? this.docId,
        userName: userName ?? this.userName,
        userEmail: userEmail ?? this.userEmail,
        timestamp: timestamp ?? this.timestamp,
        foodDescription: foodDescription ?? this.foodDescription,
        stepsList: stepsList ?? this.stepsList,
        imageUrl: imageUrl ?? this.imageUrl,
        difficultly: difficultly ?? this.difficultly,
        ingredientList: ingredientList ?? this.ingredientList,
        title: title ?? this.title,
        categoryId: categoryId ?? this.categoryId);
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "userEmail": userEmail,
      "timestamp": timestamp,
      "docId": docId,
      "foodDescription": foodDescription,
      "stepsList": stepsList,
      "imageUrl": imageUrl,
      "difficultly": difficultly,
      "ingredientList": ingredientList,
      "title": title,
      "categoryId": categoryId,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      "imageUrl": imageUrl,
      "foodDescription": foodDescription,
      "stepsList": stepsList,
      "difficultly": difficultly,
      "ingredientList": ingredientList,
      "title": title,
      "timestamp": timestamp,
      "categoryId": categoryId,
    };
  }

  static bool canAddToDB(FoodModel foodModel) {
    if (foodModel.categoryId == '') return false;
    if (foodModel.foodDescription == '') return false;
    if (foodModel.stepsList.isEmpty) return false; // Use isEmpty instead of comparing to []
    if (foodModel.title == '') return false;
    if (foodModel.ingredientList.isEmpty)
      return false; // Use isEmpty instead of comparing to []
    if (foodModel.timestamp == '') return false;
    if (foodModel.imageUrl == '') return false;
    if (foodModel.userEmail == '') return false;
    if (foodModel.userName == '') return false;
    return true;
  }
}
