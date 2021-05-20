import 'package:flutter/material.dart';
import 'package:med/entities/billon.dart';
import 'package:med/screens/billon/add_billon.dart';

class BillonPage extends StatefulWidget {
  @override
  _BillonPageState createState() => _BillonPageState();
}

class _BillonPageState extends State<BillonPage> {
  List<Billon> _billonList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Billon history'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddBillon()))
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      _billonList.add(value);
                    });
                  }
                });
              }),
          // TextButton(
          //     onPressed: () {},
          //     child: Text('Save', style: TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
