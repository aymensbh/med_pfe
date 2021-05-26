import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/bilan.dart';
import 'package:med/entities/drug.dart';
import 'package:med/entities/patient.dart';
import 'package:med/screens/drug/drugs_page.dart';
import 'package:med/screens/patient/patients_page.dart';
import 'package:intl/intl.dart';

class AddBilan extends StatefulWidget {
  final int doctorid;

  const AddBilan({Key key, this.doctorid}) : super(key: key);
  @override
  _AddBilanState createState() => _AddBilanState();
}

class _AddBilanState extends State<AddBilan> {
  String _dose = '/';
  Patient _patient;
  Drug _drug;
  TextEditingController crController = TextEditingController(),
      brController = TextEditingController(),
      tgoTgpController = TextEditingController();

  Future<bool> _onWillPop() {
    if (_patient != null || _drug != null) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                elevation: 1,
                title: Text(
                  'Voulez-vous quitter?',
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
                        'Quitter',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.red),
                      )),
                ],
              )).then((value) {
        if (value != null) {
          if (value) {
            Navigator.of(context).pop();
          }
        }
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Créer un Bilan'),
          actions: [
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.check,
                  size: 18,
                ),
                onPressed: () {
                  if (_patient == null || _drug == null) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(
                                'Erreur de saisi!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(color: Colors.black),
                              ),
                              elevation: 1,
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Retour',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(color: Colors.black),
                                    ))
                              ],
                            ));
                  } else {
                    DatabaseHelper.insertBilan(Bilan(
                      id: null,
                      creationdate: DateFormat('yyyy-MM-dd – kk:mm')
                          .format(DateTime.now()),
                      doctorid: widget.doctorid,
                      dose: _dose,
                      drugid: _drug.id,
                      patientid: _patient.id,
                      br: brController.text.trim().isEmpty
                          ? '/'
                          : brController.text.trim(),
                      cr: crController.text.trim().isEmpty
                          ? '/'
                          : crController.text.trim(),
                      tgoTgp: tgoTgpController.text.trim().isEmpty
                          ? '/'
                          : tgoTgpController.text.trim(),
                    )).then((value) {
                      Navigator.of(context).pop();
                    });
                  }
                }),
          ],
        ),
        body: ListView(
          children: [
            Card(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(18, 2, 18, 2),
                title: Text(
                    _patient == null
                        ? 'Sélectionner un patient'
                        : _patient.fullname,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        color: _patient == null ? Colors.grey : Colors.black)),
                trailing: Icon(
                  _patient == null
                      ? FontAwesomeIcons.plus
                      : FontAwesomeIcons.check,
                  color: _patient == null ? Colors.grey : Colors.teal,
                  size: 14,
                ),
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
            ),
            Card(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(18, 2, 18, 2),
                title: Text(
                    _drug == null ? 'Sélectionnez un Médicament' : _drug.name,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        color: _drug == null ? Colors.grey : Colors.black)),
                trailing: Icon(
                  _drug == null
                      ? FontAwesomeIcons.plus
                      : FontAwesomeIcons.check,
                  color: _drug == null ? Colors.grey : Colors.teal,
                  size: 14,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => DrugsPage(
                                selectMode: true,
                              )))
                      .then((value) {
                    if (value != null) {
                      setState(() {
                        _drug = value;
                      });
                    }
                  });
                },
              ),
            ),
            Card(
                margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: ExpansionTile(
                  title: Text(
                    'Bilans exigé',
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.black),
                  ),
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        _calculateDose();
                      },
                      controller: crController,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                          suffix: Text(
                            'ml/min',
                          ),
                          contentPadding: EdgeInsets.all(18),
                          hintText: 'Cr',
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1))),
                    ),
                    TextField(
                      onChanged: (value) {
                        _calculateDose();
                      },
                      controller: brController,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                          suffix: Text(
                            'ml/min',
                          ),
                          contentPadding: EdgeInsets.all(18),
                          hintText: 'Br',
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1))),
                    ),
                    TextField(
                      onChanged: (value) {
                        _calculateDose();
                      },
                      controller: tgoTgpController,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Colors.black),
                      decoration: InputDecoration(
                          suffix: Text(
                            'ml/min',
                          ),
                          contentPadding: EdgeInsets.all(18),
                          hintText: 'Tgo/Tgp',
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1))),
                    ),
                  ],
                )),
            Card(
              margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
              color: Theme.of(context).accentColor,
              child: ListTile(
                leading: Text(
                  'Dose administé',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                ),
                trailing: Text(
                  '$_dose',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _calculateDose() {
    if (_drug == null || _patient == null) {
      return;
    }
    setState(() {
      if (isDouble(crController.text.trim()) &&
          isDouble(brController.text.trim()) &&
          isDouble(tgoTgpController.text.trim())) {
        double cr = double.parse(crController.text.trim());
        double br = double.parse(brController.text.trim());
        double tgoTgp = double.parse(tgoTgpController.text.trim());
        if (br >= 60 || tgoTgp >= 55 || cr <= 30) {
          _dose = 'contre-indiquée';
          return;
        } else if ((cr > 30 && cr < 50) || (tgoTgp > 30 && tgoTgp < 50)) {
          print(br);
          _dose = '25%';
          return;
        } else {
          _dose = '100%';
          return;
        }
      } else if (isDouble(crController.text.trim()) &&
          brController.text.isEmpty &&
          tgoTgpController.text.isEmpty) {
        double cr = double.parse(crController.text.trim());
        if (cr >= 60) {
          _dose = '100%';
          return;
        } else if (cr <= 30) {
          _dose = 'contre-indiquée';
          return;
        } else {
          _dose = '50%';
          return;
        }
      } else {
        _dose = '/';
        return;
      }
    });
  }

  //To test if string is a number
  bool isDouble(String string) {
    if (string == null || string.isEmpty) {
      return false;
    }
    final number = double.tryParse(string);

    if (number == null) {
      return false;
    }

    return true;
  }
}
