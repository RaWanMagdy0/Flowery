import 'package:category/core/routes/page_route_name.dart';
import 'package:category/presentation/auth/view/login/login_screen.dart';
import 'package:category/presentation/auth/view_model/login/login_cubit.dart';
import 'package:category/presentation/categories/view_model/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'data/api/categories_api/categories_api.dart';
import 'data/data_source/remote_data_source/categories/categories_remote_data_source.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<CategoriesApi>(
    () => CategoriesApiImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<CategoriesRemotDataSource>(
    () => CategoriesRemotDataSource(getIt<CategoriesApi>()),
  );

  getIt.registerFactory<CategoriesViewModel>(
    () => CategoriesViewModel(getIt<CategoriesRemotDataSource>()),
  );
}

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: PageRouteName.logIn,
          home: BlocProvider(
            create: (context) => getIt<LoginViewModel>(),
            child: const LogInScreen(),
          ),
        );
      },
    );
  }
}
