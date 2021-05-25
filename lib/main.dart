import 'package:flutter/material.dart';
import 'package:med/utils/theme.dart';
import './screens/splash_screen.dart';

main(List<String> args) {
  runApp(MaterialApp(
    theme: themeData,
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
