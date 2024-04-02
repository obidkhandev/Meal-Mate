import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/cubit/model/network_reponse.dart';
import 'package:meal_mate/cubit/model/transactions/transactions_model.dart';
import 'package:meal_mate/cubit/transactions_cubit/transactions_state.dart';
import 'package:meal_mate/data/repository/repo.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  TransactionsCubit({required this.transactionsRepo})
      : super(TransactionsInitialState());

  final TransactionsRepo transactionsRepo;

  Future<void> fetchAllTransactions() async {
    emit(TransactionsLoadingState());
    NetworkResponse response = await transactionsRepo.getTransactions();
    if (response.errorText.isEmpty) {
      emit(TransactionsSuccessState(
          transactions: response.data as List<TransactionModels>));
    } else {
      emit(TransactionsErrorState(errorText: response.errorText));
    }
  }
}
