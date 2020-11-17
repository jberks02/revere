import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BasicInfo extends StatelessWidget {
  final String fullName;
  final String title;
  final String gender;
  final String nextElectionYear;
  final String memberUrl;
  final String party;
  final String state;
  BasicInfo({
    @required this.fullName,
    @required this.title,
    @required this.gender,
    @required this.nextElectionYear,
    @required this.memberUrl,
    @required this.party,
    @required this.state,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Basic Info",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          Text(
            "Name: ${this.fullName}",
          ),
          Text(
            "Title: ${this.title}",
            textAlign: TextAlign.left,
          ),
          Text("Gender: ${this.gender}"),
          Text("Next Election: ${this.nextElectionYear}"),
          Text("Party: ${this.party}"),
          Text("State: ${this.state}"),
          InkWell(
              child: Text("${this.memberUrl}"),
              onTap: () => launch(this.memberUrl)),
        ],
      ),
    );
  }
}
