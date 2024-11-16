import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sound_sphere/core/router/app_navigation.dart';
import 'package:sound_sphere/core/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:sound_sphere/data/res/user_repository_impl.dart';
import 'package:sound_sphere/presentation/blocs/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configLoading();
  Bloc.observer = AppBlocObserver();

  // final userRepository = UserRepositoryImpl();
  // try {
  //   // await userRepository.createUserWithEmailAndPassword(
  //   //     "test@gmail.com", "test1123");
  //   await userRepository.signInWithEmailAndPassword(
  //       "test@gmail.com", "test1123");
  //   final user = userRepository.getUser();
  //   print("Firebase User: $user");
  // } catch (e) {
  //   print("Error signing in with email and password: $e");
  // }

  runApp(const MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.white
    ..textColor = Colors.black
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sound Sphere',
      theme: AppTheme.theme,
      // home: const MainWrapper(),
      routerConfig: AppNavigation.router,
    );
  }
}
