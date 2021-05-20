import 'package:flutter/material.dart';
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
        title: Text('Login'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
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
          // TextButton(
          //     onPressed: () {},
          //     child: Text('Save', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: _doctorList.length == 0
          ? Center(
              child: Icon(
              Icons.people,
              size: 80,
            ))
          : ListView.builder(
              itemCount: _doctorList.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(12),
                        title: Text('dr.' + _doctorList[index].name),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.edit,
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
                        leading: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        onLongPress: () {
                          buildShowDialog(context).then((value) {
                            if (value != null) {
                              if (value) {
                                DatabaseHelper.deleteDoctor(
                                        _doctorList[index].id)
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
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        doctor: _doctorList[index],
                                      )));
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
