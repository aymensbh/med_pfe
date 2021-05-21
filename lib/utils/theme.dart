import 'package:flutter/material.dart';

final themeData = ThemeData(
    accentColor: Color(0xff34B4B7),
    primarySwatch: Colors.teal,
    textTheme: TextTheme(
      headline1: TextStyle(fontFamily: 'product-sans', fontSize: 22),
      headline2: TextStyle(fontFamily: 'product-sans', fontSize: 18),
      headline3: TextStyle(fontFamily: 'product-sans', fontSize: 14),
    ),
    scaffoldBackgroundColor: Color(0xfff1f1f1),
    appBarTheme: AppBarTheme(
        color: Color(0xff34B4B7),
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: TextTheme(
            // center text style
            headline6: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'product-sans'))));
