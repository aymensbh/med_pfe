import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/doctor.dart';
import 'package:med/screens/home_page.dart';

import 'add_doctor.dart';
import 'edit_doctor.dart';

class DoctorsPage extends StatefulWidget {
  @override
  _DoctorsPageState createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  List<Doctor> _doctorList = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.selectDoctors().then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _doctorList.add(Doctor.fromMap(value[index]));
        });
      });
    }).catchError((onError) => print(onError));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Doctor'),
        actions: [
          IconButton(
              icon: Icon(
                FontAwesomeIcons.plus,
                size: 18,
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddDoctor()))
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _doctorList.add(value);
                    });
                  }
                });
              }),
        ],
      ),
      body: _doctorList.length == 0
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/doctor.png',
                  width: 180,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'No Doctors Added!',
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
              itemCount: _doctorList.length,
              itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(18, 8, 8, 8),
                      title: Text(
                        'dr.' + _doctorList[index].name,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.black),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.penAlt,
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => EditDoctor(
                                        doctor: _doctorList[index],
                                      )))
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                _doctorList[index] = value;
                              });
                            }
                          });
                        },
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text(
                          _doctorList[index].name[0],
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      onLongPress: () {
                        buildShowDialog(context).then((value) {
                          if (value != null) {
                            if (value) {
                              DatabaseHelper.deleteDoctor(_doctorList[index].id)
                                  .then((value) {
                                setState(() {
                                  _doctorList.remove(_doctorList[index]);
                                });
                              });
                            }
                          }
                        });
                      },
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage(
                                  doctor: _doctorList[index],
                                )));
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
              'Delete doctor?',
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
