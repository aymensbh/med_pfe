import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  String _fullName, _age, _address, _phone;
  TextEditingController _fullNameController,
      _ageController,
      _addressController,
      _phoneController;

  @override
  void initState() {
    _fullNameController =
        new TextEditingController(text: widget.patient.fullname);
    _ageController = new TextEditingController(text: widget.patient.age);
    _addressController =
        new TextEditingController(text: widget.patient.address);
    _phoneController = new TextEditingController(text: widget.patient.phone);
    super.initState();
  }

  _validate() {
    //TODO: Edit This
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.updatePatients(Patient(
        id: widget.patient.id,
        fullname: _fullName,
        address: _address,
        age: _age,
        phone: _phone,
      )).then((value) {
        Navigator.of(context).pop(Patient(
          id: value,
          fullname: _fullName,
          address: _address,
          age: _age,
          phone: _phone,
        ));
      }).catchError((onError) => print(onError));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier un Patient'),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.check,
                size: 18,
              ),
              onPressed: _validate),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Card(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black),
                autofocus: true,
                controller: _fullNameController,
                validator: (input) {
                  if (input.trim().isEmpty) {
                    return 'Fournir un nom complet';
                  }
                },
                onSaved: (input) {
                  _fullName = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Nom complet',
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
                controller: _ageController,
                validator: (input) {
                  if (input.trim().isEmpty) {
                    return 'Fournir l\'age';
                  }
                },
                onSaved: (input) {
                  _age = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Age',
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
                controller: _addressController,
                onSaved: (input) {
                  _address = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Adresse',
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
                controller: _phoneController,
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
