import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './actionsPopUp.dart';

class ExpandedContent extends StatelessWidget {
  final Map details;
  ExpandedContent({@required this.details});
  @override
  Widget build(BuildContext context) {
    int actionLen = details['actions'].length;
    int voteLen = details['votes'].length;
    int statLen = details['presStat'].length;
    // print(this.details['actions']);
    tiggerActionDialog(cont) {
      showDialog(
          context: cont,
          builder: (BuildContext context) {
            return ActionPopup(data: details['actions']);
          });
    }

    return Container(
      // color: Colors.blue,//Color(0xFF1D1E33),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(1, 4))
                        ]),
                    child: FlatButton(
                        child: Text("Bill Link",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15)),
                        onPressed: () => launch(this.details['gov_url'])),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.3),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(1, 4))
                        ]),
                    child: FlatButton(
                        child: Text("Tracking Link",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15)),
                        onPressed: () => launch(this.details['govtrack_url'])),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(1, 4))
                      ]),
                  child: FlatButton(
                    onPressed: () => {tiggerActionDialog(context)},
                    child: Text("$actionLen action(s)",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15)),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(1, 4))
                      ]),
                  child: FlatButton(
                    onPressed: () => {null},
                    child: Text("$voteLen votes(s)",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15)),
                  ),
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(1, 4))
                ]),
            child: FlatButton(
                onPressed: () => {null},
                child: Text("$statLen Presidential Statements")),
          )
        ],
      ),
    );
  }
}
