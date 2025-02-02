import 'package:flutter/material.dart';
import 'package:perplexity_ai_clone/pages/home_page.dart';
import 'package:perplexity_ai_clone/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.submitButton),
        textTheme: ThemeData.dark().textTheme,
      ),
      home: const HomePage(),
    );
  }
}

