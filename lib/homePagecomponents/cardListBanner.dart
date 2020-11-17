import 'package:flutter/material.dart';

class CongBanner extends StatelessWidget {
  final info;
  CongBanner({@required this.info});
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return Container(
      width: cWidth,
      height: 50,
      // color: this.info['color'],
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: this.info['color'],
        border: Border.all(width: 2, color: Colors.black54),
      ),
      child: Text(
        '${this.info['CongCongressTitle']}',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 25),
      ),
    );
  }
}
