import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import '../../data/api/best_seller_api.dart';
import 'di.config.dart';

final getIt = GetIt.instance;

@module
abstract class ApiModule {
  @lazySingleton
  BestSellerApi getBestSellerApi(Dio dio) => BestSellerApiImpl(dio);
}

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() {
  getIt.init();
}
