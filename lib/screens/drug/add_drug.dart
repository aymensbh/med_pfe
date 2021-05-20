import 'package:flutter/material.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/drug.dart';

class AddDrug extends StatefulWidget {
  @override
  _AddAddDrugState createState() => _AddAddDrugState();
}

class _AddAddDrugState extends State<AddDrug> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _name;
  _validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.insertDrug(Drug(
        id: null,
        name: _name,
      )).then((value) {
        Navigator.of(context).pop(Drug(
          id: value,
          name: _name,
        ));
      }).catchError((onError) => print(onError));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drugs'),
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
            TextFormField(
              autofocus: true,
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
                  hintText: 'Drug Name',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .2))),
            ),
          ],
        ),
      ),
    );
  }
}
