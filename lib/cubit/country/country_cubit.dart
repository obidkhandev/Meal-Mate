import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/cubit/country/country_state.dart';
import 'package:meal_mate/cubit/model/country_model.dart';

import '../../data/network/api_provider.dart';
import '../model/forms_status.dart';
import '../model/network_reponse.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit()
      : super(
    CountryState(
      formsStatus: FormsStatus.pure,
      statusText: "",
      countries: [],
    ),
  ) {
    //fetchCurrencies();
  }

  fetchCurrencies() async {
    emit(state.copyWith(formsStatus: FormsStatus.loading));
    NetworkResponse response = await ApiProvider.getCountries();
    if (response.errorText.isEmpty) {
      emit(
        state.copyWith(
          countries: response.data as List<CountryModel>,
          formsStatus: FormsStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(
        statusText: response.errorText,
        formsStatus: FormsStatus.error,
      ));
    }
  }
}
