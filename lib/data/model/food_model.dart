import 'package:cloud_firestore/cloud_firestore.dart';

class FoodModel {
  final String docId;
  final String foodDescription;
  final List<String> stepsList;
  final String imageUrl;
  final String difficultly;
  final List<String> ingredientList;
  final String title;
  final String categoryId;
  final String timestamp;

  FoodModel({
    required this.docId,
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
      timestamp: json["timestamp"] as String? ?? '',
      docId: json["docId"] as String? ?? "",
      foodDescription: json["foodDescription"] as String? ?? "",
      stepsList: json["stepsList"] as List<String>? ?? [],
      imageUrl: json["imageUrl"] as String? ?? "",
      difficultly: json["difficultly"] as String? ?? "",
      ingredientList: json["ingredientList"] as List<String>? ?? [],
      title: json["title"] as String? ?? "",
      categoryId: json["categoryId"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "timestamp":timestamp,
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
      "timestamp":timestamp,
      "categoryId": categoryId,
    };
  }

 static  bool canAddToDB(FoodModel foodModel){
    if(foodModel.categoryId == '') return false;
    if(foodModel.foodDescription == '') return false;
    if(foodModel.stepsList == []) return false;
    if(foodModel.title == '') return false;
    if(foodModel.ingredientList == []) return false;
    if(foodModel.timestamp == '') return false;
    if(foodModel.imageUrl == '') return false;
  return true;
  }


}
