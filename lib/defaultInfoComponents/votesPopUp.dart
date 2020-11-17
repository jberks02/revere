import 'package:flutter/material.dart';

class VotePopUp extends StatelessWidget {
  VotePopUp({@required this.data});
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
        "Votes",
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
                      Text("Vote Chamber: ${det['vote_chamber']}"),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text("Yes: ${det['yes']}",
                                style: TextStyle(fontSize: 13)),
                            Text("No: ${det['no']}",
                                style: TextStyle(fontSize: 13)),
                            Text("Didn't Vote: ${det['no_vote']}",
                                style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                              'Vote Date: ${det['vote_date'].split('T')[0]}')),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          det['vote_question'],
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
