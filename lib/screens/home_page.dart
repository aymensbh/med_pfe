import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
      ),
      appBar: AppBar(
        title: Text('your title here!'),
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
        ],
      ),
    );
  }
}
