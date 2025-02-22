import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flowery/generated/l10n.dart';
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
import 'firebase/flutter_notification_service.dart';
import 'presentation/home_layout/screens/cart/view_model/cart_view_model.dart';
import 'firebase/firebase_options.dart';


// Background Handler
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getFcmToken();

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

void getFcmToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  print("🔥 FCM Token: $token");
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initNotifications();
    Future.delayed(Duration.zero, () async {
      await NotificationService().showNotification(
        title: "Welcome!",
        body: "Welcome to Flowery App 🌸",
      );
    });
  }

  Future<void> _initNotifications() async {
    await NotificationService().initNotification();

    await NotificationService().showNotification();

  }  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider<CartViewModel>(
          create: (context) => getIt<CartViewModel>(),
          child: MaterialApp(
            navigatorKey: navigatorKey,
            locale: Locale(provider.locale),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.appTheme,
            initialRoute: PageRouteName.splash,
            onGenerateRoute: AppRoutes.onGenerateRoute,
          ),
        );
      },
    );
  }
}
