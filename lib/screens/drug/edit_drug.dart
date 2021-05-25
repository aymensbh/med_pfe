import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/drug.dart';

class EditDrug extends StatefulWidget {
  final Drug drug;

  const EditDrug({Key key, this.drug}) : super(key: key);
  @override
  _EditDrugState createState() => _EditDrugState();
}

class _EditDrugState extends State<EditDrug> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _name;
  TextEditingController _nameController;
  String _lab;
  TextEditingController _labController;

  @override
  void initState() {
    _nameController = new TextEditingController(text: widget.drug.name);
    _labController = new TextEditingController(text: widget.drug.lab);
    super.initState();
  }

  _validate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.updateDrug(
              Drug(id: widget.drug.id, name: _name, lab: _lab))
          .then((value) {
        Navigator.of(context).pop(Drug(id: value, name: _name, lab: _lab));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier un Médicament'),
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
                controller: _nameController,
                validator: (input) {
                  if (input.trim().isEmpty) {
                    return 'Fournir un médicament';
                  }
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
                controller: _labController,
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
