import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  int _groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new'),
        actions: [
          IconButton(icon: Icon(Icons.check), onPressed: () {}),
          // TextButton(
          //     onPressed: () {},
          //     child: Text('Save', style: TextStyle(color: Colors.white))),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(12),
            title: Text('Select a Patient'),
            trailing: Icon(Icons.add),
            onTap: () {},
          ),
          Divider(
            height: 0,
          ),
          _myRadioButton(
            title: "CR",
            value: 0,
            onChanged: (newValue) => setState(() => _groupValue = newValue),
          ),
          Divider(
            height: 0,
          ),
          _myRadioButton(
            title: "BR",
            value: 1,
            onChanged: (newValue) => setState(() => _groupValue = newValue),
          ),
          Divider(
            height: 0,
          ),
          _myRadioButton(
            title: "TGO/TGP",
            value: 2,
            onChanged: (newValue) => setState(() => _groupValue = newValue),
          ),
          Divider(
            height: 0,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(18),
                hintText: 'Enter value in ml',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: .2))),
          ),
          Container(
            alignment: Alignment.center,
            height: 200,
            child: Text(
              'Result here',
              style: TextStyle(fontSize: 42),
            ),
          )
        ],
      ),
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }
}
