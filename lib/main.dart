import 'package:flutter/material.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/screens/create_page.dart';
import 'package:med/screens/drugs_page.dart';
import 'package:med/screens/home_page.dart';
import 'package:med/screens/patient/patients_page.dart';

main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/': (context) => HomePage(),
      '/patients': (context) => PatientsPage(),
      '/drugs': (context) => DrugsPage(),
      '/create': (context) => CreatePage()
    },
  ));
}
