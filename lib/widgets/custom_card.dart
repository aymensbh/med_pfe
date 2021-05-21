import 'package:flutter/material.dart';

class CustomGridCard extends StatelessWidget {
  final String title, imagePath;
  final Function onTap;

  const CustomGridCard({Key key, this.title, this.imagePath, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onTap,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange, width: 2)),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  imagePath,
                ),
                radius: 48,
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
