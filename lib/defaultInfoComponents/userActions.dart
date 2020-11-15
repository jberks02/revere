import 'package:flutter/material.dart';

class UserActions extends StatefulWidget {
  UserActions(
      {@required this.saved,
      @required this.saveCall,
      @required this.bill_id,
      @required this.deleteFunc,
      @required this.approveDisapprove});
  bool saved;
  String bill_id;
  bool approveDisapprove;
  final saveCall;
  final deleteFunc;
  @override
  _UserActionsState createState() => _UserActionsState(
      saved: this.saved,
      saveCall: this.saveCall,
      bill_id: this.bill_id,
      deleteFunc: this.deleteFunc,
      approveDisapprove: this.approveDisapprove);
}

class _UserActionsState extends State<UserActions> {
  _UserActionsState(
      {@required this.saved,
      @required this.saveCall,
      @required this.bill_id,
      @required this.deleteFunc,
      @required this.approveDisapprove});
  bool saved;
  String bill_id;
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
            this.saved = true;
          });
        } else {
          setState(() {
            this.saved = false;
          });
        }
      }
    } catch (err) {
      print('Failure to save/delete for $bill_id : $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Expanded(
          flex: 2,
          child: FlatButton(
            onPressed: saveButtonPressed,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                      this.saved == null || this.saved == false
                          ? Icons.save
                          : Icons.download_done_outlined,
                      color: Colors.deepOrange,
                      size: 40),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Save Bill',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
        this.approveDisapprove == true
            ? Expanded(flex: 2, child: Text('approve/disapprove'))
            : Expanded(flex: 2, child: Text('')),
      ],
    ));
  }
}
