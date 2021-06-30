import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/drug.dart';

class AddDrug extends StatefulWidget {
  @override
  _AddAddDrugState createState() => _AddAddDrugState();
}

class _AddAddDrugState extends State<AddDrug> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _name, _lab;
  _validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.insertDrug(Drug(id: null, name: _name, lab: _lab))
          .then((value) {
        Navigator.of(context).pop(Drug(id: value, name: _name, lab: _lab));
      }).catchError((onError) => print(onError));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Médicaments'),
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
                autofocus: true,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black),
                validator: (input) {
                  if (input.trim().isEmpty) {
                    return 'Fournir un médicament';
                  }
                  return null;
                },
                onSaved: (input) {
                  _name = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Médicament',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: .2))),
              ),
            ),
            Card(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: TextFormField(
                autofocus: true,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black),
                onSaved: (input) {
                  _lab = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Laboratoire',
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
