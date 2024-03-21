import 'package:meal_mate/utils/tools/file_importer.dart';

class IngredientViewModel extends ChangeNotifier {

  List<String> ingredientItem = [];
  List get ingredients=> ingredientItem;

  insertToList(String value){
    ingredientItem.add(value);
    notifyListeners();
  }

  deleteFromList(String value){
    ingredientItem.remove(value);
    notifyListeners();
  }

  setToList(int index, String value){
    ingredientItem[index] = value;
    notifyListeners();
  }
}