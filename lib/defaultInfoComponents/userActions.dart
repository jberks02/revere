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
      this.userVote});
  bool saved;
  String bill_id;
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
      userVote: this.userVote);
}

class _UserActionsState extends State<UserActions> {
  _UserActionsState(
      {@required this.saved,
      @required this.saveCall,
      @required this.bill_id,
      @required this.deleteFunc,
      @required this.approveDisapprove,
      this.userVote});
  String bill_id;
  bool saved;
  bool userVote;
  bool approveDisapprove;
  bool forBill;
  bool againstBill;
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
      if (this.forBill != true) {
        setState(() {
          this.forBill = true;
          this.againstBill = false;
        });
      } else {
        setState(() {
          this.forBill = false;
        });
      }
    } catch (err) {
      print('Failure to vote for bill: $err');
    }
  }

  againstButtonPressed() async {
    try {
      if (this.againstBill != true) {
        setState(() {
          this.againstBill = true;
          this.forBill = false;
        });
      } else {
        setState(() {
          this.againstBill = false;
        });
      }
    } catch (err) {
      print('Failure to vote against bill: $err');
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
                              this.forBill == true ? Colors.deepOrange : null,
                          child: Text('For', style: TextStyle(fontSize: 15)),
                          onPressed: forButtonPressed,
                        )),
                    Expanded(
                        flex: 1,
                        child: FlatButton(
                          color: this.againstBill == true
                              ? Colors.deepOrange
                              : null,
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
