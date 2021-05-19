import 'package:flutter/material.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/patient.dart';
import 'package:med/screens/patient/edit_patient.dart';
import 'package:sqflite/sqlite_api.dart';

import 'add_patient.dart';

class PatientsPage extends StatefulWidget {
  @override
  _PatientsPageState createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  List<Patient> _patientList = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.selectPatient().then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _patientList.add(Patient.fromMap(value[index]));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddPatient()))
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _patientList.add(value);
                    });
                  }
                });
              }),
          // TextButton(
          //     onPressed: () {},
          //     child: Text('Save', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: _patientList.length == 0
          ? Center(
              child: Icon(
              Icons.people,
              size: 80,
            ))
          : ListView.builder(
              itemCount: _patientList.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(12),
                        title: Text(_patientList[index].fullname),
                        trailing: Icon(
                          Icons.edit,
                        ),
                        leading: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        onLongPress: () {
                          buildShowDialog(context).then((value) {
                            if (value != null) {
                              if (value) {
                                DatabaseHelper.deletePatient(
                                        _patientList[index].id)
                                    .then((value) {
                                  setState(() {
                                    _patientList.remove(_patientList[index]);
                                  });
                                });
                              }
                            }
                          });
                        },
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => EditPatient(
                                        patient: _patientList[index],
                                      )))
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                _patientList[index] = value;
                              });
                            }
                          });
                        },
                      ),
                      Divider(
                        height: 0,
                      ),
                    ],
                  )),
    );
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cancel', style: TextStyle(color: Colors.black))),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Delete', style: TextStyle(color: Colors.red))),
            ],
          );
        });
  }
}
