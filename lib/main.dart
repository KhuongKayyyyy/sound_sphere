import 'package:flutter/material.dart';
import 'package:sound_sphere/core/theme/app_theme.dart';
import 'package:sound_sphere/presentation/views/main_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sound Sphere',
      theme: AppTheme.theme,
      home: const MainWrapper(),
    );
  }
}
