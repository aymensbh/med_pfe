import 'package:flutter/material.dart';
import 'package:med/backend/database_helper.dart';
import 'package:med/entities/bilan_details.dart';

class ViewBilan extends StatefulWidget {
  final int bilanid;

  const ViewBilan({Key key, this.bilanid}) : super(key: key);

  @override
  _ViewBilanState createState() => _ViewBilanState();
}

class _ViewBilanState extends State<ViewBilan> {
  List<BilanDetail> _bilanDetailsList = [];
  @override
  void initState() {
    super.initState();
    DatabaseHelper.selectBilanDetails(widget.bilanid).then((value) {
      List.generate(value.length, (index) {
        setState(() {
          _bilanDetailsList.add(BilanDetail.fromMap(value[index]));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Bilan'),
      ),
      body: _bilanDetailsList.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Card(
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(18, 8, 18, 8),
                      title: Text(
                        'Bilan N°' + widget.bilanid.toString(),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      trailing: Text(
                        _bilanDetailsList[0].creationdate,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.black),
                      ),
                    )),
                Card(
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(18, 8, 18, 8),
                      title: Text(
                        'Patient',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      trailing: Text(
                        _bilanDetailsList[0].patientFullname,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.black),
                      ),
                    )),
                Card(
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(18, 8, 18, 8),
                      title: Text(
                        'Médicament',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      trailing: Text(
                        _bilanDetailsList[0].drugName,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.black),
                      ),
                    )),
                Card(
                    color: Theme.of(context).accentColor,
                    margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                    child: ListTile(
                      contentPadding: EdgeInsets.fromLTRB(18, 8, 18, 8),
                      title: Text(
                        'Dose administé',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.white),
                      ),
                      trailing: Text(
                        _bilanDetailsList[0].dose,
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(color: Colors.white),
                      ),
                    )),
              ],
            ),
    );
  }
}
