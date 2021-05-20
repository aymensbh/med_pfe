import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _nameController = new TextEditingController(text: widget.drug.name);
    super.initState();
  }

  _validate() {
    //TODO: Edit This
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      DatabaseHelper.updateDrug(Drug(
        id: widget.drug.id,
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
                  hintText: 'drug Name',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .2))),
            ),
          ],
        ),
      ),
    );
  }
}
