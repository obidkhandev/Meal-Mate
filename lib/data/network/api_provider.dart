import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:meal_mate/cubit/model/country_model.dart';
import 'package:meal_mate/cubit/model/network_reponse.dart';

class ApiProvider {
  static Future<NetworkResponse> getCountries() async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://all-countries.free.mockoapp.net/countries"));

      if (response.statusCode == HttpStatus.ok) {
        dynamic responseBody = jsonDecode(response.body);
        if (responseBody['data'] != null &&
            responseBody['data']['countries'] != null) {
          List<dynamic> countriesData = responseBody['data']['countries'];
          print(countriesData[0]);
          // Map each country data to CountryModel object
          List<CountryModel> countries = countriesData
              .map((countryData) {

                return CountryModel.fromJson(countryData);
          },)
              .toList();

          print(countries);

          return NetworkResponse(data: countries);
        } else {
          print(response.statusCode.toString());
          return NetworkResponse(
            errorText: "Data or countries not found in response",
          );
        }
      } else {
        print(response.statusCode.toString());
        return NetworkResponse(

          errorText: "HTTP Status Code: ${response.statusCode}",
        );
      }
    } catch (error) {
      print(error.toString());
      return NetworkResponse(errorText: error.toString());
    }
  }
}
