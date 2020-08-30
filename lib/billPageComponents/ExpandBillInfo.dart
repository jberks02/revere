import 'package:flutter/material.dart';
import './flatButtonHeader.dart';
import '../utilWidgets/spingLoad.dart';

class ExpandContentButton extends StatelessWidget {
  ExpandContentButton(
      {@required this.loading,
      @required this.expanded,
      @required this.expandContent});
  final Widget up = Icon(Icons.arrow_upward);
  final Widget down = Icon(Icons.arrow_downward);
  final Widget load = SpinningLoadIcon();
  final expandContent;
  final bool loading;
  final bool expanded;
  pickIcons() {
    if (loading == true) {
      return load;
    } else if (expanded == false) {
      return down;
    } else {
      return up;
    }
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0)),
          color: Colors.blue),
      width: cWidth,
      child: Column(
        children: <Widget>[
          FlatButton(
              child: FlatButHeader(
                icon: pickIcons(),
              ),
              onPressed: () => {this.expandContent()}),
        ],
      ),
    );
  }
}
