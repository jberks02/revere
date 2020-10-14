import 'package:flutter/material.dart';
import 'package:revere/billPageComponents/ExpandedContent.dart';
import '../billPageComponents/billContainerHeader.dart';
import '../billPageComponents/billTitle.dart';
import '../billPageComponents/billDates.dart';
import '../billPageComponents/ExpandBillInfo.dart';
import '../serverRequests/dataRequests.dart';

class VotesContainerWithExpandable extends StatefulWidget {
  @override
  VotesContainerWithExpandable({@required this.data});
  final Map data;
  _VotesContainerWithExpandableState createState() =>
      _VotesContainerWithExpandableState(data: data);
}

class _VotesContainerWithExpandableState
    extends State<VotesContainerWithExpandable> {
  final request = Requests();
  final Map data;
  bool loading = false;
  bool expanded = false;
  Map expandedContent;
  _VotesContainerWithExpandableState({@required this.data});
  expandVoteInfo() async {
    try {
      if (this.expanded == false) {
        this.setState(() {
          this.loading = true;
        });
        this.expandedContent = await this
            .request
            .completeBillDetails(data['bill_slug'], data['congress_int']);
        // await new Future.delayed(Duration(milliseconds: 1000));
        this.setState(() {
          this.loading = false;
          this.expanded = true;
        });
      } else if (this.expanded == true) {
        this.setState(() {
          this.expanded = false;
        });
      }
    } catch (err) {
      print('failure to expand bill info: $err');
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
        color: Color(0xFF1D1E33),
        border: Border.all(width: 2, color: Colors.black54),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BillHeader(
            slug: data['bill_slug'],
            enacted: data['enacted'],
            active: data['active'],
          ),
          BillTitle(
            text: data['title'],
          ),
          Text(
            'Vote Question',
            style:
                TextStyle(fontSize: 20, decoration: TextDecoration.underline),
          ),
          BillTitle(
            text: data['vote_question'],
          ),
          DatesRow(
              introDate: data['introduction_date'].split('T')[0],
              lastAct: data['vote_date'].split('T')[0],
              lastActHeader: 'Vote Date'),
          this.expanded == false
              ? Text('')
              : ExpandedContent(details: this.expandedContent['body']),
          ExpandContentButton(
              loading: this.loading,
              expanded: this.expanded,
              expandContent: this.expandVoteInfo)
        ],
      ),
    );
  }
}
