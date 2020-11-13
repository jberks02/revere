import 'package:flutter/material.dart';

class UserActions extends StatefulWidget {
  UserActions(
      {@required this.saved, @required this.saveCall, @required this.bill_id});
  bool saved;
  String bill_id;
  final saveCall;
  @override
  _UserActionsState createState() => _UserActionsState(
      saved: this.saved, saveCall: this.saveCall, bill_id: this.bill_id);
}

class _UserActionsState extends State<UserActions> {
  _UserActionsState(
      {@required this.saved, @required this.saveCall, @required this.bill_id});
  bool saved;
  String bill_id;
  final saveCall;
  bool loading = false;
  // bool
  saveButtonPressed() async {
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
        Expanded(flex: 2, child: Text('approve/disapprove')),
      ],
    ));
  }
}
