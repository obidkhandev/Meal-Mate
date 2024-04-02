import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/cubit/transactions_cubit/transaction_cubit.dart';
import 'package:meal_mate/cubit/transactions_cubit/transactions_state.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      body: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (BuildContext context, state) {
          if(state is TransactionsLoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TransactionsSuccessState) {
            return ListView.builder(
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.transactions[index].data[0].sender.name),
                    subtitle: Text(state.transactions[index].transferDate),
                  );
                });
          }else if(state is TransactionsErrorState){
            return Center(
              child: Text(state.errorText),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
