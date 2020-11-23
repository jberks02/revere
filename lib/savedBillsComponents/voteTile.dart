import 'package:flutter/material.dart';
import '../defaultInfoComponents/billTitle.dart';
import '../serverRequests/dataRequests.dart';
import '../defaultInfoComponents/billDates.dart';
import './pointVoteScrollable.dart';

class VoteTile extends StatefulWidget {
  @override
  VoteTile({@required this.data});
  final Map data;
  _VoteTileState createState() => _VoteTileState(data: data);
}

class _VoteTileState extends State<VoteTile> {
  final request = Requests();
  final Map data;
  bool loading = false;
  bool expanded = false;
  Map expandedContent;
  _VoteTileState({@required this.data});
//TODO: Add For and against button pushes to this tile
  @override
  Widget build(BuildContext context) {
    print(data['user_vote']);
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
        children: [
          Text(
            'Vote: ${data['vote_id']}',
            style:
                TextStyle(fontSize: 20, decoration: TextDecoration.underline),
          ),
          BillTitle(
            text: data['vote_question'],
          ),
          DatesRow(
              introString: 'Vote Time',
              introDate: data['vote_time'].toString(),
              lastAct: data['vote_date'].toString().split('T')[0],
              lastActHeader: 'Vote Date'),
          DatesRow(
            introString: 'Votes For',
            introDate: '${data['yes']}',
            lastActHeader: 'Votes Against',
            lastAct: '${data['no']}',
          ),
          PointVoteScroller(
              data: data['pointVote'], userVote: data['user_vote'])
        ],
      ),
    );
  }
}
