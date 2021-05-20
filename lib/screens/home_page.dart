import 'package:flutter/material.dart';
import 'package:med/entities/doctor.dart';

class HomePage extends StatefulWidget {
  final Doctor doctor;

  const HomePage({Key key, this.doctor}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
      ),
      appBar: AppBar(
        title: Text('Hello! dr. ${widget.doctor.name}'),
        actions: [
          IconButton(
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheet(
                        onClosing: () {},
                        builder: (context) {
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).pop(true);
                            },
                            leading: Text(
                              'Logout',
                              style: TextStyle(color: Colors.red),
                            ),
                            trailing: Icon(
                              Icons.exit_to_app,
                              color: Colors.red,
                            ),
                          );
                        })).then((value) {
                  if (value != null) {
                    Navigator.of(context).pushReplacementNamed('/doctors');
                  }
                });
              })
        ],
      ),
      body: ListView(
        children: [
          //TODO: Edit patient tile ************************************
          ListTile(
            contentPadding: EdgeInsets.all(12),
            leading: Icon(
              Icons.people,
              color: Colors.black,
            ),
            title: Text('Patients'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/patients');
            },
          ),
          Divider(
            height: 0,
          ),
          //TODO: Edit drugs tile **************************************
          ListTile(
            contentPadding: EdgeInsets.all(12),
            leading: Icon(
              Icons.inbox,
              color: Colors.black,
            ),
            title: Text('Drugs'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/drugs');
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            contentPadding: EdgeInsets.all(12),
            leading: Icon(
              Icons.file_copy_outlined,
              color: Colors.black,
            ),
            title: Text('Billon history'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pushNamed(context, '/billon');
            },
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
