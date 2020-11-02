import 'package:flutter/material.dart';

class BillHeader extends StatelessWidget {
  BillHeader(
      {@required this.slug, @required this.enacted, @required this.active});
  final slug;
  final enacted;
  final active;
  enactedMessage(txt) {
    if (txt == 'null' || txt == 'false')
      return "Enacted: No";
    else
      return "Enacted: Yes";
  }

  activeMessage(txt) {
    if (txt == 'false' || txt == 'null')
      return "Active: No";
    else
      return "Active: Yes";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Text(this.enactedMessage(this.enacted),
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20))),
          Expanded(
            flex: 1,
            child: Text(this.slug,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25, decoration: TextDecoration.underline)),
          ),
          Expanded(
              flex: 1,
              child: Text(this.activeMessage(this.active),
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)))
        ],
      ),
    );
  }
}
