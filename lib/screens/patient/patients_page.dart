import 'package:flutter/cupertino.dart';
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
  List<Patient> _duplicatedSearchItems = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.selectPatient().then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _patientList.add(Patient.fromMap(value[index]));
          _duplicatedSearchItems.add(Patient.fromMap(value[index]));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (input) {
            filterSearchResults(input);
          },
          style: Theme.of(context)
              .textTheme
              .headline2
              .copyWith(color: Colors.white),
          textAlignVertical: TextAlignVertical.bottom,
          cursorColor: Colors.white,
          decoration: InputDecoration(
              icon: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
                size: 18,
              ),
              hintText: 'Patients',
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 0)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 1))),
        ),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.plus,
                size: 18,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(
                        CupertinoPageRoute(builder: (context) => AddPatient()))
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _patientList.add(value);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).accentColor,
                        duration: Duration(seconds: 1),
                        content: Text(
                          'Patient créé ${value.fullname}',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(color: Colors.white),
                        )));
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
                  'Aucun Patient ajouté!',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black),
                ),
                Text(
                  '+ Pour ajouter',
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
                                .push(CupertinoPageRoute(
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
              'Supprimer?',
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
                    'Annuler',
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
                    'Supprimer',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.red),
                  )),
            ],
          );
        });
  }

  filterSearchResults(String query) {
    List<Patient> dummySearchList = [];
    dummySearchList.addAll(_patientList);
    if (query.isNotEmpty) {
      List<Patient> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.fullname
            .toLowerCase()
            .trim()
            .contains(query.toLowerCase().trim())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _patientList.clear();
        _patientList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _patientList.clear();
        _patientList.addAll(_duplicatedSearchItems);
      });
    }
  }
}
