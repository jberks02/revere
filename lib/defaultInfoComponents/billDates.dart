import 'package:flutter/material.dart';
import 'twoTxtColumn.dart';

class DatesRow extends StatelessWidget {
  final String lastAct;
  final String introDate;
  final String lastActHeader;
  final String introString;
  DatesRow(
      {@required this.lastAct,
      @required this.introDate,
      @required this.lastActHeader,
      this.introString});
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return Container(
      width: cWidth,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TitleDate(date: this.lastAct, title: this.lastActHeader),
          TitleDate(
              date: this.introDate,
              title:
                  this.introString == null ? 'Introduction' : this.introString),
        ],
      ),
    );
  }
}
