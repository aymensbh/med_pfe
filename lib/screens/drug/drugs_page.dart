import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/drug.dart';
import 'package:med/screens/drug/add_drug.dart';

import 'edit_drug.dart';

class DrugsPage extends StatefulWidget {
  final bool selectMode;
  const DrugsPage({Key key, this.selectMode}) : super(key: key);
  @override
  _DrugsPageState createState() => _DrugsPageState();
}

class _DrugsPageState extends State<DrugsPage> {
  List<Drug> _drugsList = [];
  List<Drug> _duplicatedSearchItems = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.selectDrugs().then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _drugsList.add(Drug.fromMap(value[index]));
          _duplicatedSearchItems.add(Drug.fromMap(value[index]));
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
              hintText: 'Drugs',
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
                    .push(CupertinoPageRoute(builder: (context) => AddDrug()))
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _drugsList.add(value);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).accentColor,
                        duration: Duration(seconds: 1),
                        content: Text(
                          'Added ${value.name}',
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
      body: _drugsList.length == 0
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/drug.png',
                  width: 180,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'No Drugs Added!',
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
              itemCount: _drugsList.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      Card(
                        margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(18, 8, 18, 8),
                          title: Text(
                            _drugsList[index].name,
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
                            FontAwesomeIcons.box,
                            color: Colors.orange,
                          ),
                          onLongPress: () {
                            buildShowDialog(context).then((value) {
                              if (value != null) {
                                if (value) {
                                  DatabaseHelper.deleteDrug(
                                          _drugsList[index].id)
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
                            widget.selectMode == null
                                ? Navigator.of(context)
                                    .push(CupertinoPageRoute(
                                        builder: (context) => EditDrug(
                                              drug: _drugsList[index],
                                            )))
                                    .then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _drugsList[index] = value;
                                      });
                                    }
                                  })
                                : Navigator.of(context).pop(_drugsList[index]);
                          },
                        ),
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
            elevation: 1,
            title: Text(
              'Delete drug?',
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

  filterSearchResults(String query) {
    List<Drug> dummySearchList = [];
    dummySearchList.addAll(_drugsList);
    if (query.isNotEmpty) {
      List<Drug> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.name
            .toLowerCase()
            .trim()
            .contains(query.toLowerCase().trim())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _drugsList.clear();
        _drugsList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _drugsList.clear();
        _drugsList.addAll(_duplicatedSearchItems);
      });
    }
  }
}
