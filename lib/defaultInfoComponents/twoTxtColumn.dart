import 'package:flutter/material.dart';

class TitleDate extends StatelessWidget {
  final String date;
  final String title;
  TitleDate({
    @required this.date,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(this.title,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontSize: 17, decoration: TextDecoration.underline)),
            ),
            Text(
              this.date.split(',')[0],
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
