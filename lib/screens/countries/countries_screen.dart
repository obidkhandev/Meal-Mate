import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/cubit/country/country_cubit.dart';
import 'package:meal_mate/cubit/country/country_state.dart';
import 'package:meal_mate/cubit/model/country_model.dart';
import 'package:meal_mate/cubit/model/forms_status.dart';
import 'package:meal_mate/utils/style/app_text_style.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Countries",
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CountryCubit, CountryState>(
        builder: (BuildContext context, CountryState state) {
          if (state.formsStatus == FormsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.formsStatus == FormsStatus.error) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.statusText),
              ],
            );
          }
          return ListView(
            children: List.generate(state.countries.length, (index) {
              CountryModel countryModel = state.countries[index];
              return ListTile(
                trailing: Text(
                  countryModel.emoji,
                  style: AppTextStyle.recolateMedium.copyWith(fontSize: 22),
                ),
                title: Text(
                  "${countryModel.name} - ${countryModel.continent.name}",
                  style: AppTextStyle.recolateBold,
                ),
                subtitle: Row(
                  children: [
                    Text(countryModel.capital),
                    const SizedBox(width: 10),
                    Text("phone code - ${countryModel.phone}"),

                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
