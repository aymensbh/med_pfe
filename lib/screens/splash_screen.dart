import 'package:flutter/material.dart';
import 'package:med/backend/database_helper.dart';

import 'doctor/doctors_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //connection to database
    return FutureBuilder(
      future: DatabaseHelper.init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Material(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          //connected to database
          return DoctorsPage();
        }
      },
    );
  }
}
