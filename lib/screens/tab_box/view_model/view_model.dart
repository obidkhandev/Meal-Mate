import '../../../utils/tools/file_importer.dart';

class TabViewModel extends ChangeNotifier {
  int _activeIndex = 0;

  int get getIndex => _activeIndex;

  void changeIndex(int newIndex) {
    _activeIndex = newIndex;
    notifyListeners();
  }
}