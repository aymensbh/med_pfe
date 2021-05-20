import 'package:flutter/material.dart';
import 'package:med/entities/patient.dart';
import 'package:med/screens/patient/patients_page.dart';

class AddBillon extends StatefulWidget {
  @override
  _AddBillonState createState() => _AddBillonState();
}

class _AddBillonState extends State<AddBillon> {
  int _groupValue = -1;
  Patient _patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Billon'),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: () {}),
          // TextButton(
          //     onPressed: () {},
          //     child: Text('Save', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(12),
            title:
                Text(_patient == null ? 'Select a Patient' : _patient.fullname),
            trailing: Icon(_patient == null ? Icons.add : Icons.edit),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => PatientsPage(
                            selectMode: true,
                          )))
                  .then((value) {
                if (value != null) {
                  setState(() {
                    _patient = value;
                  });
                }
              });
            },
          ),
          Divider(
            height: 0,
          ),
          _myRadioButton(
            title: "CR",
            value: 0,
            onChanged: (newValue) => setState(() => _groupValue = newValue),
          ),
          Divider(
            height: 0,
          ),
          _myRadioButton(
            title: "BR",
            value: 1,
            onChanged: (newValue) => setState(() => _groupValue = newValue),
          ),
          Divider(
            height: 0,
          ),
          _myRadioButton(
            title: "TGO/TGP",
            value: 2,
            onChanged: (newValue) => setState(() => _groupValue = newValue),
          ),
          Divider(
            height: 0,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(18),
                hintText: 'Enter value in ml',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: .2))),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   height: 200,
          //   child: Text(
          //     'Result here',
          //     style: TextStyle(fontSize: 42),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}
