import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/doctor.dart';

class AddDoctor extends StatefulWidget {
  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _name;
  _validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.insertDoctor(Doctor(
        id: null,
        name: _name,
      )).then((value) {
        Navigator.of(context).pop(Doctor(id: value, name: _name));
      }).catchError((onError) => print(onError));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Doctor'),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.check,
                size: 18,
              ),
              onPressed: _validate),
          // TextButton(
          //     onPressed: () {},
          //     child: Text('Save', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Card(
              margin: EdgeInsets.all(12),
              child: TextFormField(
                autofocus: true,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black),
                validator: (input) {
                  if (input.trim().isEmpty) {
                    return 'value is empty';
                  }
                },
                onSaved: (input) {
                  _name = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Full Name',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: .2))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
