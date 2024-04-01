import 'package:meal_mate/cubit/model/country_model.dart';
import 'package:meal_mate/cubit/model/forms_status.dart';

class CountryState {
  final FormsStatus formsStatus;
  final List<CountryModel> countries;
  final String statusText;

  CountryState({
    required this.formsStatus,
    required this.statusText,
    required this.countries,
  });

  CountryState copyWith({
    FormsStatus? formsStatus,
    List<CountryModel>? countries,
    String? statusText,
  }) =>
      CountryState(
        formsStatus: formsStatus ?? this.formsStatus,
        countries: countries ?? this.countries,
        statusText: statusText ?? this.statusText,
      );
}
