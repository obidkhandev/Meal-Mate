import 'package:meal_mate/utils/tools/file_importer.dart';

class StepsViewModel extends ChangeNotifier {

  List<String> stepsItem = [];
  List get steps=>stepsItem;

  insertToList(String value){
    stepsItem.add(value);
    notifyListeners();
  }

  deleteFromList(String value){
    stepsItem.remove(value);
    notifyListeners();
  }

  gapList(){
    stepsItem = [];
    notifyListeners();
  }

  setToList(int index, String value){
    stepsItem[index] = value;
    notifyListeners();
  }
}