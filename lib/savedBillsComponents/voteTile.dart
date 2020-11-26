import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
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
  bool userVote;

  _VoteTileState({@required this.data}) {
    this.userVote = this.data['for_bill'];
  }
  forButtonPressed() async {
    try {
      if (this.userVote != true) {
        if (this.userVote == null)
          data['for'] = data['for'] + 1;
        else {
          data['for'] = data['for'] + 1;
          data['against'] = data['against'] - 1;
        }
        setState(() {
          this.userVote = true;
        });
        setUserVoteForLoad(true);
      } else {
        setState(() {
          data['for'] = data['for'] - 1;
          this.userVote = null;
        });
        setUserVoteForLoad(null);
      }
    } catch (err) {
      print('Failure to vote for bill: $err');
    }
  }

  againstButtonPressed() async {
    try {
      if (this.userVote != false) {
        if (this.userVote == null)
          data['against'] = data['against'] + 1;
        else {
          data['against'] = data['against'] + 1;
          data['for'] = data['for'] - 1;
        }
        setState(() {
          this.userVote = false;
        });
        setUserVoteForLoad(false);
      } else {
        data['against'] = data['against'] - 1;
        setState(() {
          this.userVote = null;
        });
        setUserVoteForLoad(null);
      }
    } catch (err) {
      print('Failure to vote against bill: $err');
    }
  }

  setUserVoteForLoad(val) async {
    try {
      String slug = data['bill_slug'];
      int congressInt = data['congress_int'];
      final prefs = await SharedPreferences.getInstance();
      List dataSet = jsonDecode(prefs.getString('votedList'));
      dataSet.forEach((vot) => {
            if (vot['bill_slug'] == slug &&
                vot['congress_int'] == congressInt &&
                vot['vote_id'] == data['vote_id'])
              {
                vot['for_bill'] = val,
              }
          });
      prefs.setString('votedList', jsonEncode(dataSet));
      final Map payload = {
        'bill_slug': slug,
        'congress_int': congressInt,
        'vote_id': data['vote_id'],
        'for_bill': val,
        'action': val == null ? 'delete' : 'update'
      };
      await Requests().updateUserVote(payload);
    } catch (err) {
      print('Failure to change saved userVote value: $err');
    }
  }

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
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: FlatButton(
                    color:
                        this.userVote == true ? Colors.deepOrange : Colors.grey,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text('For', style: TextStyle(fontSize: 20))),
                        Expanded(
                            flex: 1,
                            child: Text(
                              '${data['for']}',
                              textAlign: TextAlign.right,
                            ))
                      ],
                    ),
                    onPressed: forButtonPressed,
                  )),
              Expanded(
                  flex: 1,
                  child: FlatButton(
                    color: this.userVote == false
                        ? Colors.deepOrange
                        : Colors.grey,
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text('Against',
                                style: TextStyle(fontSize: 20))),
                        Expanded(
                            flex: 1,
                            child: Text(
                              '${data['against']}',
                              textAlign: TextAlign.right,
                            ))
                      ],
                    ),
                    onPressed: againstButtonPressed,
                  ))
            ],
          ),
          Text(
            'Vote: ${data['vote_id']}',
            style:
                TextStyle(fontSize: 20, decoration: TextDecoration.underline),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Text(
              data['vote_question'],
              style: TextStyle(fontSize: 18),
            ),
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
          Text(
            'Chamber: ${data['vote_chamber']}',
            style:
                TextStyle(fontSize: 20, decoration: TextDecoration.underline),
          ),
          PointVoteScroller(
              data: data['pointVote'], userVote: data['user_vote'])
        ],
      ),
    );
  }
}
