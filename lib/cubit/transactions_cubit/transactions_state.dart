
import 'package:meal_mate/cubit/model/transactions/transactions_model.dart';

abstract class TransactionsState {}

class TransactionsInitialState extends TransactionsState {}

class TransactionsLoadingState extends TransactionsState {}

class TransactionsSuccessState extends TransactionsState {
  TransactionsSuccessState({required this.transactions});

  final List<TransactionModels> transactions;
}

class TransactionsErrorState extends TransactionsState {
  TransactionsErrorState({required this.errorText});

  final String errorText;
}