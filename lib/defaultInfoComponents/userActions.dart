import 'package:flutter/material.dart';

class UserActions extends StatefulWidget {
  @override
  _UserActionsState createState() => _UserActionsState();
}

class _UserActionsState extends State<UserActions> {
  bool saved;
  bool loading = false;
  // bool
  @override
  saveButtonPressed() {
    //TODO:send updated save status to data base or unsave
    //TODO:set state of save button to lit or unlit, will need to be back propogated to container
  }

  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        Expanded(
          flex: 2,
          child: FlatButton(
            onPressed: saveButtonPressed(),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(
                      this.saved == null || false
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
