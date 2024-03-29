class NotificationModel{
  final String title;
  final int id;
  final String body;

  NotificationModel({
    required this.title,
    required this.id,
    this.body = '',
});
}