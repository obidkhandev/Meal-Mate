import 'package:get_it/get_it.dart';
import 'package:meal_mate/qr_code_scaner/repo/product_repo.dart';

var getIt = GetIt.I;

void setUp() {
  getIt.registerSingleton<ProductRepository>(ProductRepository());
}