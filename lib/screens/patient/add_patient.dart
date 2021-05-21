import 'package:flutter/material.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/patient.dart';

class AddPatient extends StatefulWidget {
  @override
  _AddPatientState createState() => _AddPatientState();
}

class _AddPatientState extends State<AddPatient> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _fullName, _birthdate, _address, _phone;
  _validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.insertPatient(Patient(
        id: null,
        fullname: _fullName,
        address: _address,
        birthdate: _birthdate,
        phone: _phone,
      )).then((value) {
        Navigator.of(context).pop(Patient(
          id: value,
          fullname: _fullName,
          address: _address,
          birthdate: _birthdate,
          phone: _phone,
        ));
      }).catchError((onError) => print(onError));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: _validate),
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
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                  _fullName = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Full Name',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: .2))),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: TextFormField(
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
                  _birthdate = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Birthdate',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: .2))),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: TextFormField(
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
                  _address = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Address',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: .2))),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: TextFormField(
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
                  _phone = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Phone',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: .2))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
