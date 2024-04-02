import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/cubit/country/country_cubit.dart';
import 'package:meal_mate/cubit/timer/timer_cubit.dart';
import 'package:meal_mate/cubit/transactions_cubit/transaction_cubit.dart';
import 'package:meal_mate/data/repository/repo.dart';
import 'package:meal_mate/screens/transactions/transactions_screen.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => TransactionsRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CountryCubit(),
          ),
          BlocProvider(create: (context) => TimerCubit()),
          BlocProvider(
            create: (context) => TransactionsCubit(
                transactionsRepo: context.read<TransactionsRepo>())
              ..fetchAllTransactions(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        ScreenUtil.init(context);
        return AdaptiveTheme(
          light: AppTheme.lightTheme,
          dark: AppTheme.darkTheme,
          initial: AdaptiveThemeMode.light,
          builder: (light, dark) {
            return MaterialApp(
                darkTheme: dark,
                theme: light,
                debugShowCheckedModeBanner: false,
                // initialRoute: RouteName.splash,
                // onGenerateRoute: AppRoute.generateRoute,
                home: TransactionsScreen());
          },
        );
      },
    );
  }
}
