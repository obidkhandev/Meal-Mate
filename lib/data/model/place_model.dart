import '../local/local_db.dart';

class PlaceModel {
  PlaceModel({
    required this.placeCategory,
    required this.lat,
    required this.long,
    required this.placeName,
    required this.entrance,
    required this.flatNumber,
    required this.orientAddress,
    required this.stage,
    this.docId,
  });

  final String? docId;
  final double lat;
  final double long;
  final String placeName;
  final String placeCategory;
  final String entrance;
  final String stage;
  final String flatNumber;
  final String orientAddress;

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      docId: json['docId'] as String?,
      placeCategory: json[PlaceModelConstants.placeCategory] as String,
      lat: json[PlaceModelConstants.lat] as double? ?? 0.0,
      long: json[PlaceModelConstants.long] as double? ?? 0.0,
      placeName: json[PlaceModelConstants.placeName] as String? ?? '',
      entrance: json[PlaceModelConstants.entrance] as String? ?? '',
      stage: json[PlaceModelConstants.stage] as String? ?? '',
      flatNumber: json[PlaceModelConstants.flatNumber] as String? ?? '',
      orientAddress: json[PlaceModelConstants.orientAddress] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    PlaceModelConstants.placeCategory: placeCategory,
    PlaceModelConstants.lat: lat,
    PlaceModelConstants.long: long,
    PlaceModelConstants.placeName: placeName,
    PlaceModelConstants.entrance: entrance,
    PlaceModelConstants.stage: stage,
    PlaceModelConstants.flatNumber: flatNumber,
    PlaceModelConstants.orientAddress: orientAddress,
  };

  PlaceModel copyWith({
    String? docId,
    String? placeCategory,
    double? lat,
    double? long,
    String? placeName,
    String? entrance,
    String? stage,
    String? flatNumber,
    String? orientAddress,
  }) {
    return PlaceModel(
      docId: docId ?? this.docId,
      placeCategory: placeCategory ?? this.placeCategory,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      placeName: placeName ?? this.placeName,
      entrance: entrance ?? this.entrance,
      stage: stage ?? this.stage,
      flatNumber: flatNumber ?? this.flatNumber,
      orientAddress: orientAddress ?? this.orientAddress,
    );
  }
}
