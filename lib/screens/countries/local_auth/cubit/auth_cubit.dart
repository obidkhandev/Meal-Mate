import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/screens/countries/local_auth/cubit/auth_cubit_state.dart';
import '../../../../data/local/storage_repository.dart';


abstract class LocalPasswordScreenEvent {}

class PasswordButtonTapped extends LocalPasswordScreenEvent {
  final int index;

  PasswordButtonTapped(this.index);
}

class PasswordButtonRemove extends LocalPasswordScreenEvent {}
class ValidatePassword extends LocalPasswordScreenEvent {}

class LocalPasswordScreenCubit extends Cubit<LocalPasswordScreenState> {
  List<String> selectedButtons = [];

  LocalPasswordScreenCubit() : super(LocalPasswordScreenInitial());

  void onButtonTap(int index) {
    if (selectedButtons.length < 4) {
      selectedButtons.add(index.toString());
      emit(LocalPasswordScreenInitial());
    }
  }

  void onButtonTapRemove() {
    if (selectedButtons.isNotEmpty) {
      selectedButtons.removeLast();
      emit(LocalPasswordScreenInitial());
    }
  }

  void validatePassword() async {
    List<String> lastPass = StorageRepository.getStringList(key: "my_pass");

    if (lastPass.isEmpty) {
      StorageRepository.setListString(key: "my_pass", values: selectedButtons);
      emit(LocalPasswordScreenNavSecond());
      return;
    }



    if (selectedButtons.length == 4 && lastPass.isNotEmpty) {
      if (listEquals(selectedButtons, lastPass)) {
        selectedButtons.clear();
        emit(LocalPasswordScreenSuccess());
      } else {
        emit(LocalPasswordScreenError('Sizning parolingiz xato'));
        selectedButtons.clear();
      }
    } else {
      selectedButtons.clear();
      emit(LocalPasswordScreenError('Siz Parolni to\'liq kiritmadingiz'));
    }
  }
}
