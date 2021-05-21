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
  String _dose = '0.0';
  Patient _patient;
  Drug _drug;
  bool _isCr = false, _isBr = false, _isTgoTgp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new Bilan'),
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
                            title: Text('Please fill info correctly!'),
                            elevation: 1,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Ok'))
                            ],
                          ));
                } else {
                  String bilanType = '';
                  if (_isCr) bilanType += 'CR ';
                  if (_isBr) bilanType += 'BR ';
                  if (_isTgoTgp) bilanType += 'TGO/TGP';
                  DatabaseHelper.insertBilan(Bilan(
                          id: null,
                          creationdate: DateFormat('yyyy-MM-dd – kk:mm')
                              .format(DateTime.now()),
                          doctorid: widget.doctorid,
                          dose: _dose,
                          drugid: _drug.id,
                          patientid: _patient.id,
                          type: bilanType))
                      .then((value) {
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
              contentPadding: EdgeInsets.fromLTRB(18, 8, 18, 8),
              title: Text(
                  _patient == null ? 'Select a Patient' : _patient.fullname,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      color: _patient == null ? Colors.grey : Colors.black)),
              trailing: Icon(
                _patient == null
                    ? FontAwesomeIcons.plus
                    : FontAwesomeIcons.check,
                color: _patient == null ? Colors.grey : Colors.teal,
                size: 18,
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
              contentPadding: EdgeInsets.fromLTRB(18, 8, 18, 8),
              title: Text(_drug == null ? 'Select a Drug' : _drug.name,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      color: _drug == null ? Colors.grey : Colors.black)),
              trailing: Icon(
                _drug == null ? FontAwesomeIcons.plus : FontAwesomeIcons.check,
                color: _drug == null ? Colors.grey : Colors.teal,
                size: 18,
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
            child: Column(
              children: [
                CheckboxListTile(
                  value: _isCr,
                  onChanged: (value) {
                    setState(() {
                      _isCr = value;
                    });
                  },
                  title: Text(
                    "CR",
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.black),
                  ),
                ),
                Divider(
                  height: 0,
                ),
                CheckboxListTile(
                  value: _isBr,
                  onChanged: (value) {
                    setState(() {
                      _isBr = value;
                    });
                  },
                  title: Text(
                    "BR",
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.black),
                  ),
                ),
                Divider(
                  height: 0,
                ),
                CheckboxListTile(
                  value: _isTgoTgp,
                  onChanged: (value) {
                    setState(() {
                      _isTgoTgp = value;
                    });
                  },
                  title: Text(
                    "TGO/TGP",
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Colors.black),
                  ),
                ),
                Divider(
                  height: 0,
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: TextField(
              keyboardType: TextInputType.number,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.black),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(18),
                  hintText: 'Enter value in ml',
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: .2))),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: ListTile(
              leading: Text(
                'Dose',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black),
              ),
              trailing: Text(
                ' $_dose ml',
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.orange),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: MaterialButton(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                color: Color(0xff34B4B7),
                elevation: 1,
                onPressed: _calculateDose,
                child: Text(
                  'Calculate Dose',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }

  _calculateDose() {
    setState(() {
      _dose = '10';
    });
  }

  // Widget _myRadioButton({String title, int value, Function onChanged}) {
  //   return RadioListTile(
  //     value: value,
  //     groupValue: _groupValue,
  //     onChanged: onChanged,
  //     title: Text(title),
  //   );
  // }
}
