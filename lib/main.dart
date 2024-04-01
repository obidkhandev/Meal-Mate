import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_mate/cubit/country/country_cubit.dart';
import 'package:meal_mate/utils/tools/file_importer.dart';
import 'app/app.dart';
import 'service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>CountryCubit()..fetchCurrencies(),)
    ], child: App(),)
  );
}