import 'package:flutter/material.dart';
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
  String _name;
  TextEditingController _nameController;

  @override
  void initState() {
    _nameController = new TextEditingController(text: widget.doctor.name);
    super.initState();
  }

  _validate() {
    //TODO: Edit This
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.updateDoctor(Doctor(
        id: widget.doctor.id,
        name: _name,
      )).then((value) {
        Navigator.of(context).pop(Doctor(
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
        title: Text('Edit Doctor'),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: _validate),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              autofocus: true,
              controller: _nameController,
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
          ],
        ),
      ),
    );
  }
}
