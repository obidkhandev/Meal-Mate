
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/local/storage_repository.dart';
abstract class LocalPasswordScreenState {}

class LocalPasswordScreenInitial extends LocalPasswordScreenState {}

class LocalPasswordScreenSuccess extends LocalPasswordScreenState {}
class LocalPasswordScreenNavSecond extends LocalPasswordScreenState {}


class LocalPasswordScreenError extends LocalPasswordScreenState {
  final String errorMessage;

  LocalPasswordScreenError(this.errorMessage);
}



// Define the states
abstract class LocalPasswordScreenSecondState {}

class LocalPasswordScreenSecondInitial extends LocalPasswordScreenSecondState {}

class LocalPasswordScreenSecondSuccess extends LocalPasswordScreenSecondState {}

class LocalPasswordScreenSecondError extends LocalPasswordScreenSecondState {
  final String errorMessage;

  LocalPasswordScreenSecondError(this.errorMessage);
}

// Define the events
abstract class LocalPasswordScreenSecondEvent {}

class PasswordButtonTapped extends LocalPasswordScreenSecondEvent {
  final int index;

  PasswordButtonTapped(this.index);
}

class PasswordButtonRemove extends LocalPasswordScreenSecondEvent {}

class ValidatePasswordSecond extends LocalPasswordScreenSecondEvent {}

// Define the Cubit
class LocalPasswordScreenSecondCubit extends Cubit<LocalPasswordScreenSecondState> {
  List<String> selectedButtons = [];

  LocalPasswordScreenSecondCubit() : super(LocalPasswordScreenSecondInitial());

  void onButtonTap(int index) {
    if (selectedButtons.length < 4) {
      selectedButtons.add(index.toString());
      emit(LocalPasswordScreenSecondInitial());
    }
  }

  void onButtonTapRemove() {
    if (selectedButtons.isNotEmpty) {
      selectedButtons.removeLast();
      emit(LocalPasswordScreenSecondInitial());
    }
  }

  void validatePassword() async {
    List<String> lastPass = StorageRepository.getStringList(key: "my_pass");

    if (selectedButtons.length == 4 && lastPass.isNotEmpty) {
      if (listEquals(selectedButtons, lastPass)) {
        selectedButtons.clear();
        emit(LocalPasswordScreenSecondSuccess());
      } else {
        emit(LocalPasswordScreenSecondError('Sizning parolingiz xato'));
        selectedButtons.clear();
      }
    }
  }
}

