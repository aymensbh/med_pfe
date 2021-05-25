import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/doctor.dart';

class EditDoctor extends StatefulWidget {
  final Doctor doctor;

  const EditDoctor({Key key, this.doctor}) : super(key: key);
  @override
  _EditDoctorState createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _name, _spec;
  TextEditingController _nameController, _specController;

  @override
  void initState() {
    _nameController = new TextEditingController(text: widget.doctor.name);
    _specController = new TextEditingController(text: widget.doctor.spec);
    super.initState();
  }

  _validate() {
    //TODO: Edit This
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.updateDoctor(
              Doctor(id: widget.doctor.id, name: _name, spec: _spec))
          .then((value) {
        Navigator.of(context).pop(Doctor(id: value, name: _name, spec: _spec));
      }).catchError((onError) => print(onError));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier un Médecin'),
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
                  if (input.trim().length < 4) {
                    return 'Fournir un nom complet!';
                  }
                },
                onSaved: (input) {
                  _name = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Nom et Prénom',
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
                controller: _specController,
                // validator: (input) {
                //   if (input.trim().isEmpty) {
                //     return 'value is empty';
                //   }
                // },
                onSaved: (input) {
                  _spec = input.trim();
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(18),
                    hintText: 'Spécialité',
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
