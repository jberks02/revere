import 'package:flutter/material.dart';

class FlatButHeader extends StatelessWidget {
  final icon;
  FlatButHeader({@required this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: icon,
        ),
        Expanded(
          flex: 1,
          child: Text('Expand',
              textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
        ),
        Expanded(flex: 1, child: icon),
      ],
    );
  }
}
