import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../serverRequests/dataRequests.dart';

class UserActions extends StatefulWidget {
  UserActions(
      {@required this.saved,
      @required this.saveCall,
      @required this.bill_id,
      @required this.deleteFunc,
      @required this.approveDisapprove,
      this.userVote,
      this.voteId});
  bool saved;
  String bill_id;
  int voteId;
  bool userVote;
  bool approveDisapprove;
  final saveCall;
  final deleteFunc;
  @override
  _UserActionsState createState() => _UserActionsState(
      saved: this.saved,
      saveCall: this.saveCall,
      bill_id: this.bill_id,
      deleteFunc: this.deleteFunc,
      approveDisapprove: this.approveDisapprove,
      userVote: this.userVote,
      voteId: this.voteId);
}

class _UserActionsState extends State<UserActions> {
  _UserActionsState(
      {@required this.saved,
      @required this.saveCall,
      @required this.bill_id,
      @required this.deleteFunc,
      @required this.approveDisapprove,
      this.userVote,
      this.voteId});
  String bill_id;
  int voteId;
  bool saved;
  bool userVote;
  bool approveDisapprove;
  final saveCall;
  final deleteFunc;
  bool loading = false;
  saveButtonPressed() async {
    try {
      if (this.saved == false) {
        final saveResponse = await saveCall(this.bill_id);
        if (saveResponse == true) {
          setState(() {
            this.saved = true;
          });
        } else {
          setState(() {
            this.saved = false;
          });
        }
      } else {
        final deleteResponse = await deleteFunc(this.bill_id);
        if (deleteResponse != false) {
          setState(() {
            this.saved = false;
          });
        } else {
          setState(() {
            this.saved = true;
          });
        }
      }
    } catch (err) {
      print('Failure to save/delete for $bill_id : $err');
    }
  }

  forButtonPressed() async {
    try {
      if (this.userVote != true) {
        setState(() {
          this.userVote = true;
        });
        setUserVoteForLoad(true);
      } else {
        setState(() {
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
        setState(() {
          this.userVote = false;
        });
        setUserVoteForLoad(false);
      } else {
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
      String slug = this.bill_id.split('-')[0];
      int congressInt = int.parse(this.bill_id.split('-')[1]);
      final prefs = await SharedPreferences.getInstance();
      List dataSet = jsonDecode(prefs.getString('votedList'));
      print('$val');
      dataSet.forEach((vot) => {
            if (vot['bill_slug'] == slug &&
                vot['congress_int'] == congressInt &&
                vot['vote_id'] == this.voteId)
              {
                vot['for_bill'] = val,
              }
          });
      prefs.setString('votedList', jsonEncode(dataSet));
      final Map payload = {
        'bill_slug': slug,
        'congress_int': congressInt,
        'vote_id': this.voteId,
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
    return Container(
        child: Row(
      children: [
        Expanded(
          flex: 1,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: saveButtonPressed,
            child: Row(
              children: [
                Icon(
                    this.saved == null || this.saved == false
                        ? Icons.save
                        : Icons.download_done_outlined,
                    color: Colors.deepOrange,
                    size: 40),
                Text(
                  'Save Bill',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        this.approveDisapprove == true
            ? Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: FlatButton(
                          color:
                              this.userVote == true ? Colors.deepOrange : null,
                          child: Text('For', style: TextStyle(fontSize: 15)),
                          onPressed: forButtonPressed,
                        )),
                    Expanded(
                        flex: 1,
                        child: FlatButton(
                          color:
                              this.userVote == false ? Colors.deepOrange : null,
                          child:
                              Text('Against', style: TextStyle(fontSize: 15)),
                          onPressed: againstButtonPressed,
                        ))
                  ],
                ),
              )
            : Expanded(flex: 1, child: Text('')),
        // this.approveDisapprove == true
        // ? Expanded(
        //     flex: 2,
        //     child: FlatButton(
        //       child: Text('Against', style: TextStyle(fontSize: 15)),
        //       onPressed: () => {null},
        //     ))
        //     : Expanded(flex: 1, child: Text(''))
      ],
    ));
  }
}
