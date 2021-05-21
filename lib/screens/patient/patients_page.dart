import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/patient.dart';
import 'package:med/screens/patient/edit_patient.dart';

import 'add_patient.dart';

class PatientsPage extends StatefulWidget {
  final bool selectMode;

  const PatientsPage({Key key, this.selectMode}) : super(key: key);
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
              icon: Icon(
                FontAwesomeIcons.plus,
                size: 18,
              ),
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
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/patient.png',
                  width: 180,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'No Patients Added!',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black),
                ),
                Text(
                  'Tap + to add',
                  style: Theme.of(context).textTheme.headline2,
                )
              ],
            ))
          : ListView.builder(
              itemCount: _patientList.length,
              itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(18, 8, 18, 8),
                      title: Text(
                        _patientList[index].fullname,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.black),
                      ),
                      trailing: Icon(
                        widget.selectMode == null
                            ? FontAwesomeIcons.penAlt
                            : FontAwesomeIcons.arrowRight,
                        size: 18,
                      ),
                      leading: Icon(
                        FontAwesomeIcons.userAlt,
                        size: 18,
                        color: Colors.orange,
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
                        widget.selectMode == null
                            ? Navigator.of(context)
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
                              })
                            : Navigator.of(context).pop(_patientList[index]);
                      },
                    ),
                  )),
    );
  }

  Future buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 1,
            title: Text(
              'Delete patient?',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Delete',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.red),
                  )),
            ],
          );
        });
  }
}
