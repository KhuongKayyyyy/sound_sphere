import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/router/app_navigation.dart';
import 'package:sound_sphere/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sound_sphere/data/res/user_repository.dart';
import 'package:sound_sphere/presentation/blocs/app_bloc_observer.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }

  configLoading();
  Bloc.observer = AppBlocObserver();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthenticationBloc()..add(AuthGetUserRequested())),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..indicatorColor = AppColor.primaryColor
    ..textColor = AppColor.primaryColor
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sound Sphere',
      theme: AppTheme.theme,
      routerConfig: AppNavigation.router,
      builder: (context, child) {
        return EasyLoading.init()(context, child);
      },
    );
  }
}
