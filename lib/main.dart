import 'package:flutter/material.dart';
import 'package:med/utils/theme.dart';
import './screens/splash_screen.dart';
import 'package:med/screens/billon/billon_page.dart';
import 'package:med/screens/billon/add_billon.dart';
import 'package:med/screens/doctor/doctors_page.dart';
import 'package:med/screens/drug/drugs_page.dart';
import 'package:med/screens/home_page.dart';
import 'package:med/screens/patient/patients_page.dart';

main(List<String> args) {
  runApp(MaterialApp(
    theme: themeData,
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => SplashScreen(),
      '/doctors': (context) => DoctorsPage(),
      '/homePage': (context) => HomePage(),
      '/patients': (context) => PatientsPage(),
      '/drugs': (context) => DrugsPage(),
      '/billon': (context) => BillonPage(),
      '/create': (context) => AddBillon()
    },
  ));
}
