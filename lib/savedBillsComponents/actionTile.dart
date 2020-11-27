import 'package:flutter/material.dart';
import '../serverRequests/dataRequests.dart';
import '../defaultInfoComponents/billTitle.dart';
import '../defaultInfoComponents/billDates.dart';

// class ActionTile extends StatefulWidget {
//   ActionTile({@required this.data, @required this.middleText});
//   final Map data;
//   final String middleText;
//   @override
//   _ActionTileState createState() => _ActionTileState(
//         data: this.data,
//         middleText: this.middleText,
//       );
// }

class ActionTile extends StatelessWidget {
  final request = Requests();
  final Map data;
  final String middleText;
  Map expandedContent;
  bool expanded = false;
  bool loading = false;
  ActionTile({
    @required this.data,
    @required this.middleText,
  });

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    return Container(
      width: cWidth,
      margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blue[900],
        border: Border.all(width: 2, color: Colors.black54),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Action: ${data['action_id']}",
              style: TextStyle(
                  fontSize: 20, decoration: TextDecoration.underline)),
          DatesRow(
            introString: 'Action Date',
            introDate: data['action_date'].split('T')[0],
            lastAct: data['action_chamber'],
            lastActHeader: 'Chamber',
          ),
          BillTitle(text: data['description']),
        ],
      ),
    );
  }
}
