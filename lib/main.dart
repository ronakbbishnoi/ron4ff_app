import 'package:flutter/material.dart';
import 'package:ron4ff/profile_lookup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ron4ff',
      theme: ThemeData(
        brightness: Brightness.dark, // Dark mode for VIP feel
        scaffoldBackgroundColor: const Color(0xFF0F0F1A), // Darker background
        cardColor: const Color(0xFF1A1A2E), // Card background color
        primaryColor: const Color(0xFF6A1B9A), // Deep purple accent
        hintColor: Colors.white54,
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
          labelLarge: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A4A), // Text field background
          hintStyle: const TextStyle(color: Colors.white54),
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Color(0xFF6A1B9A), width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6A1B9A), // Button background
            foregroundColor: Colors.white, // Button text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(background: const Color(0xFF0F0F1A)),
      ),
      home: const ProfileLookupScreen(),
    );
  }
}
