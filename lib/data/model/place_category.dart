import 'package:flutter/material.dart';

enum PlaceCategory {
  work,
  home,
  other,
}

List<IconData> iconsCategory = [
  Icons.work,
  Icons.home,
  Icons.location_on,
];

IconData getIcon(String category){
  switch (category) {
    case 'work':
      return iconsCategory[0];

    case 'home':
      return iconsCategory[1];

    default:
      return iconsCategory[2];
  }
}


extension PlaceCategoryExtension on PlaceCategory {
  String toJson() {
    switch (this) {
      case PlaceCategory.work:
        return 'work';
      case PlaceCategory.home:
        return 'home';
      case PlaceCategory.other:
        return 'other';
    }
  }

  static PlaceCategory fromJson(String value) {
    switch (value) {
      case 'work':
        return PlaceCategory.work;
      case 'home':
        return PlaceCategory.home;
      case 'other':
        return PlaceCategory.other;
      default:
        throw ArgumentError('Invalid value: $value');
    }
  }
}
