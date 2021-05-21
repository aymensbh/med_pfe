import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:med/entities/doctor.dart';
import 'package:med/screens/bilan/add_bilan.dart';
import 'package:med/widgets/custom_card.dart';

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
        child: Icon(FontAwesomeIcons.plus, size: 18, color: Colors.white),
        elevation: 2,
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddBilan(
                        doctorid: widget.doctor.id,
                      )));
        },
      ),
      appBar: AppBar(
        title: Text('Hello! dr. ${widget.doctor.name}'),
        actions: [
          IconButton(
              icon: Icon(FontAwesomeIcons.chevronDown, size: 18),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheet(
                        onClosing: () {},
                        builder: (context) {
                          return ListTile(
                            contentPadding: EdgeInsets.fromLTRB(18, 4, 18, 4),
                            onTap: () {
                              Navigator.of(context).pop(true);
                            },
                            leading: Text(
                              'Sign-out',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: Colors.red),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.signOutAlt,
                              size: 18,
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
      body: GridView(
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          CustomGridCard(
            imagePath: 'assets/images/patient.png',
            title: 'Patients',
            onTap: () {
              Navigator.pushNamed(context, '/patients');
            },
          ),
          CustomGridCard(
            imagePath: 'assets/images/drug.png',
            title: 'Drugs',
            onTap: () {
              Navigator.pushNamed(context, '/drugs');
            },
          ),
          CustomGridCard(
            imagePath: 'assets/images/bilan.png',
            title: 'Bilan history',
            onTap: () {
              Navigator.pushNamed(context, '/bilan');
            },
          ),
        ],
      ),
    );
  }
}
