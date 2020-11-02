import 'package:flutter/material.dart';
import 'twoTxtColumn.dart';

class DatesRow extends StatelessWidget {
  final String lastAct;
  final String introDate;
  final String lastActHeader;
  DatesRow(
      {@required this.lastAct,
      @required this.introDate,
      @required this.lastActHeader});
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return Container(
      width: cWidth,
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TitleDate(date: this.lastAct, title: this.lastActHeader),
          TitleDate(date: this.introDate, title: 'Introduction'),
        ],
      ),
    );
  }
}
