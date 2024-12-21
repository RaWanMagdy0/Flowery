import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/di/di.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/page_route_name.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/bloc_observer/app_bloc_observer.dart';
import 'core/utils/functions/providers/local_provider.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'presentation/home_layout/screens/cart/view_model/cart_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();

  Bloc.observer = AppBlocObserver();

  LocalProvider provider = LocalProvider();

  await provider.loadSavedLanguage();

  runApp(
    ChangeNotifierProvider(
      create: (context) => provider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalProvider>(context);

    return ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocProvider<CartViewModel>(
            create: (context) => getIt<CartViewModel>(),
            child: MaterialApp(
              locale: Locale(provider.locale),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.appTheme,
              initialRoute: PageRouteName.splash,
              onGenerateRoute: (settings) =>
                  AppRoutes.onGenerateRoute(settings),
            ),
          );
        });
  }
}
