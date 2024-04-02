import 'package:meal_mate/cubit/model/network_reponse.dart';
import 'package:meal_mate/data/network/api_provider.dart';

class TransactionsRepo{
  Future<NetworkResponse> getTransactions() async{
    return ApiProvider.getAllTransaction();
  }
}