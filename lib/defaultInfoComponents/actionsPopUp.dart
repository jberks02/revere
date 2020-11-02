import 'package:flutter/material.dart';

class ActionPopup extends StatelessWidget {
  ActionPopup({@required this.data});
  final List data;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: FlatButton(
            child: Text('Close'),
            color: Colors.blue,
            onPressed: () => Navigator.of(context).pop(),
          ),
        )
      ],
      title: Text(
        "Actions",
        textAlign: TextAlign.center,
      ),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              for (var det in data)
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Column(
                    children: <Widget>[
                      Text("Initiated By: ${det['action_chamber']}"),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text("Type: ${det['action_type']}")),
                            Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(
                                    "Date: ${det['action_date'].split('T')[0]}")),
                          ],
                        ),
                      ),
                      Text(
                        det['description'],
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
