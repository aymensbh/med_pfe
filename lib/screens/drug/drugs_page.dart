import 'package:flutter/material.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/drug.dart';
import 'package:med/screens/drug/add_drug.dart';

import 'edit_drug.dart';

class DrugsPage extends StatefulWidget {
  @override
  _DrugsPageState createState() => _DrugsPageState();
}

class _DrugsPageState extends State<DrugsPage> {
  List<Drug> _drugsList = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.selectDrugs().then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _drugsList.add(Drug.fromMap(value[index]));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drugs'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddDrug()))
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _drugsList.add(value);
                    });
                  }
                });
              }),
          // TextButton(
          //     onPressed: () {},
          //     child: Text('Save', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: _drugsList.length == 0
          ? Center(
              child: Icon(
              Icons.people,
              size: 80,
            ))
          : ListView.builder(
              itemCount: _drugsList.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(12),
                        title: Text(_drugsList[index].name),
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
                                DatabaseHelper.deleteDrug(_drugsList[index].id)
                                    .then((value) {
                                  setState(() {
                                    _drugsList.remove(_drugsList[index]);
                                  });
                                });
                              }
                            }
                          });
                        },
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => EditDrug(
                                        drug: _drugsList[index],
                                      )))
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                _drugsList[index] = value;
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
