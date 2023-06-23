import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_rest_api/theme/theme_controller.dart';
import 'package:github_rest_api/view/home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() {
  // Initialize the ThemeController and register it with GetX
  Get.put(ThemeController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'github user',
      theme: ThemeData.light().copyWith(
        // Set the app bar background color for light mode
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black12, // Replace with your desired color
        ),
        // Set the background color for light mode
        scaffoldBackgroundColor: Colors.white54,
        // Set the font color for light mode
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
          // Add other text styles as needed
        ),
      ),
      darkTheme: ThemeData.dark(),
      home: HomePage(),
      //RepositoryPage()
      //HomePage(),
    );
  }
}
