import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/bilan.dart';
import 'package:med/screens/bilan/view_bilan.dart';

class BilanPage extends StatefulWidget {
  final int doctorid;

  const BilanPage({Key key, this.doctorid}) : super(key: key);
  @override
  _BilanPageState createState() => _BilanPageState();
}

class _BilanPageState extends State<BilanPage> {
  List<Bilan> _bilanList = [];
  List<Bilan> _duplicatedSearchItems = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.selectBilan(widget.doctorid).then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _bilanList.add(Bilan.fromMap(value[index]));
          _duplicatedSearchItems.add(Bilan.fromMap(value[index]));
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
              hintText: 'Bilans Historique',
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
      ),
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
                  'Aucun Bilan ajouté',
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
                      subtitle: Text('dose: ' + _bilanList[index].dose,
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
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => ViewBilan(
                                  bilanid: _bilanList[index].id,
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
    List<Bilan> dummySearchList = [];
    dummySearchList.addAll(_bilanList);
    if (query.isNotEmpty) {
      List<Bilan> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.dose
                .toLowerCase()
                .trim()
                .contains(query.toLowerCase().trim()) ||
            item.creationdate
                .toLowerCase()
                .trim()
                .contains(query.toLowerCase().trim())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _bilanList.clear();
        _bilanList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _bilanList.clear();
        _bilanList.addAll(_duplicatedSearchItems);
      });
    }
  }
}
