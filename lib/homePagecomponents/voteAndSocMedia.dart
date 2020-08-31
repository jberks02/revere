import 'package:flutter/material.dart';

class VoteAndSocialMedia extends StatelessWidget {
  final int totalVotes;
  final int missedVotes;
  final int votesInPartyAlignment;
  final String facebook;
  final String twitter;
  final String youtube;
  VoteAndSocialMedia({
    @required this.totalVotes,
    @required this.missedVotes,
    @required this.votesInPartyAlignment,
    @required this.facebook,
    @required this.twitter,
    @required this.youtube,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Vote Summary",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                  Text("Total Votes:",
                      style: TextStyle(decoration: TextDecoration.underline)),
                  Text("${this.totalVotes}"),
                  Text("Votes Missed:",
                      style: TextStyle(decoration: TextDecoration.underline)),
                  Text("${this.missedVotes}"),
                  Text("Party Aligned Votes:",
                      style: TextStyle(decoration: TextDecoration.underline)),
                  Text("${this.votesInPartyAlignment}%")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Social Media",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  Text("Facebook:",
                      style: TextStyle(decoration: TextDecoration.underline)),
                  Text(
                    "${this.facebook}",
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("Twitter:",
                      style: TextStyle(decoration: TextDecoration.underline)),
                  Text(
                    "@${this.twitter}",
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text("YouTube:",
                      style: TextStyle(decoration: TextDecoration.underline)),
                  Text(
                    "${this.youtube}",
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
