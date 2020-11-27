import 'package:flutter/material.dart';

class FailedLoad extends StatelessWidget {
  final Function reload;
  FailedLoad({@required this.reload});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            FlatButton(
                onPressed: this.reload,
                child: Icon(Icons.wifi_off, size: 150, color: Colors.red)),
            Container(
              margin: EdgeInsets.all(40),
              child: Text(
                  "We couldn't complete this request at this time. Please make sure you're connected to the internet. Tap the icon above to retry loading this page.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30)),
            )
          ],
        ));
  }
}
