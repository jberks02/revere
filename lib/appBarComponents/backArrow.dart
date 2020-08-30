import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  final backPage;
  final cycle;
  BackArrow({@required this.backPage, @required this.cycle});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
      icon: Icon(Icons.arrow_back_ios, color: Colors.deepOrange),
      onPressed: () => backPage(cycle),
    ));
  }
}
