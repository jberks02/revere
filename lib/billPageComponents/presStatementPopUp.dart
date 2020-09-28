import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PresidentStatementsPopUp extends StatelessWidget {
  PresidentStatementsPopUp({@required this.data});
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
        "Presidential Satements",
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
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.black)),
                  child: Column(
                    children: <Widget>[
                      Text(
                          det['stat_position'].length > 0
                              ? det['stat_position']
                              : 'Position Not Found',
                          style: TextStyle(fontSize: 15)),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: InkWell(
                            child: Text("Read Statement Here",
                                style: (TextStyle(
                                    decoration: TextDecoration.underline))),
                            onTap: () => launch(det['stat_url'])),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          det['would_sign'] == 'true'
                              ? 'Would Sign'
                              : 'Would Not Sign',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          det['veto_threat'] == 'true'
                              ? 'Under Threat of Veto'
                              : 'No Veto Threat',
                          textAlign: TextAlign.center,
                        ),
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
