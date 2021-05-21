import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/bilan.dart';

class BilanPage extends StatefulWidget {
  @override
  _BilanPageState createState() => _BilanPageState();
}

class _BilanPageState extends State<BilanPage> {
  List<Bilan> _bilanList = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.selectBilan().then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _bilanList.add(Bilan.fromMap(value[index]));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bilan history'),
      ),
      // actions: [
      //   IconButton(
      //       icon: Icon(Icons.add),
      //       onPressed: () {
      //         Navigator.of(context)
      //             .push(MaterialPageRoute(builder: (context) => AddBilan()))
      //             .then((value) {
      //           if (value != null) {
      //             setState(() {
      //               _bilanList.add(value);
      //             });
      //           }
      //         });
      //       }),
      //   // TextButton(
      //   //     onPressed: () {},
      //   //     child: Text('Save', style: TextStyle(color: Colors.white))),
      // ],

      body: _bilanList.length == 0
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/bilan.png',
                  width: 180,
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  'No Bilan Added!',
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
              itemCount: _bilanList.length,
              itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(18, 8, 18, 8),
                      title: Text(_bilanList[index].creationdate,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(color: Colors.black)),
                      subtitle: Text('dose: ' + _bilanList[index].dose + 'ml',
                          style: Theme.of(context).textTheme.headline3),
                      trailing: Icon(
                        FontAwesomeIcons.arrowRight,
                        size: 18,
                      ),
                      leading: Icon(
                        FontAwesomeIcons.paperclip,
                        color: Colors.teal,
                        size: 18,
                      ),
                      onLongPress: () {
                        buildShowDialog(context).then((value) {
                          if (value != null) {
                            if (value) {
                              DatabaseHelper.deleteBilan(_bilanList[index].id)
                                  .then((value) {
                                setState(() {
                                  _bilanList.remove(_bilanList[index]);
                                });
                              });
                            }
                          }
                        });
                      },
                      // onTap: () {
                      //   Navigator.of(context)
                      //       .push(MaterialPageRoute(
                      //           builder: (context) => EditDrug(
                      //                 drug: _drugsList[index],
                      //               )))
                      //       .then((value) {
                      //     if (value != null) {
                      //       setState(() {
                      //         _drugsList[index] = value;
                      //       });
                      //     }
                      //   });
                      // },
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
              'Delete bilan?',
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
