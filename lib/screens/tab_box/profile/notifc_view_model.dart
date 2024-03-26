import 'package:meal_mate/utils/tools/file_importer.dart';

import 'notif_model.dart';

class NotificationViewModel extends ChangeNotifier{

  List<NotificationModel> notificationList = [];
  List<NotificationModel> get notifications => notificationList;

  addToNotification( NotificationModel model){
    notificationList.add(model);
    notifyListeners();
  }

  removeFromList( NotificationModel model){
    notificationList.remove(model);
    notifyListeners();
  }
  removeAll(){
    notificationList.removeRange(0, notificationList.length);
    notifyListeners();
  }
}