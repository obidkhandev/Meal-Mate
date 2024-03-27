
class UserModel {
  final String userId;
  final String userName;
  final String email;
  final String imageUrl;
  final String fcmToken;
  final String userDocId;

  UserModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.imageUrl,
    required this.fcmToken,
    required this.userDocId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] ?? '',
      userName: json['user_name'] ?? '',
      email: json['e_mail'] ?? '',
      imageUrl: json['image_url'] ?? '',
      fcmToken: json['fcm_token'] ?? '',
      userDocId: json['user_doc_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'e_mail': email,
      'image_url': imageUrl,
      'fcm_token': fcmToken,
      'user_doc_id': userDocId,
    };
  }
}