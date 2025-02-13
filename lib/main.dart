import 'package:flutter/material.dart'; 
import 'package:fapp/screens/intro.dart';
import 'package:fapp/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fapp/constants/texts.dart';

void main() async {
  // This is required for accessing shared preferences before runApp
  WidgetsFlutterBinding.ensureInitialized();
  
  // Get shared preferences instance
  final prefs = await SharedPreferences.getInstance();
  
  // Get the boolean value, default to true if not set
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;
  
  runApp(Trueastrologgers(isFirstTime: isFirstTime));
}

class Trueastrologgers extends StatelessWidget { 
  final bool isFirstTime;
  
  const Trueastrologgers({
    super.key,
    required this.isFirstTime,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isFirstTime ? const Intro() : Home(),
    );
  }
}