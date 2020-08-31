import 'package:flutter/material.dart';

class BillTitle extends StatelessWidget {
  final String text;
  BillTitle({@required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Text(this.text, style: TextStyle(fontSize: 15)),
    );
  }
}
