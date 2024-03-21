class CategoryModel {
  final String categoryId;
  final String category;

  CategoryModel({
    required this.categoryId,
    required this.category,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['categoryId'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'category': category,
    };
  }
  Map<String, dynamic> toJsonForUpdate() {
    return {
      'category': category,
    };
  }
}

enum CategoryEnum{
  everyday,
  drinks,
  cakes,
  seasonal,
}
