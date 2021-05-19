import 'package:flutter/material.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/patient.dart';

class EditPatient extends StatefulWidget {
  final Patient patient;

  const EditPatient({Key key, this.patient}) : super(key: key);
  @override
  _EditPatientState createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatient> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _fullName, _birthdate, _address, _phone;
  TextEditingController _fullNameController,
      _birthdateController,
      _addressController,
      _phoneController;

  @override
  void initState() {
    _fullNameController =
        new TextEditingController(text: widget.patient.fullname);
    _birthdateController =
        new TextEditingController(text: widget.patient.birthdate);
    _addressController =
        new TextEditingController(text: widget.patient.address);
    _phoneController = new TextEditingController(text: widget.patient.phone);
    super.initState();
  }

  _validate() {
    //TODO: Edit This
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.updatePatient(Patient(
        id: widget.patient.id,
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
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _fullNameController,
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
            TextFormField(
              controller: _birthdateController,
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
            TextFormField(
              controller: _addressController,
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
            TextFormField(
              controller: _phoneController,
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
            )
          ],
        ),
      ),
    );
  }
}
