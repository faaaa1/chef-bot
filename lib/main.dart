import 'package:chefbot/constants/gemini_api_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'screens/home.dart';

void main() {
  Gemini.init(apiKey: geminiApiKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEF1F8),
        fontFamily: 'Intel',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
