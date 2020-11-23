import 'package:flutter/material.dart';
import '../billPageComponents/billContainerHeader.dart';
import '../defaultInfoComponents/billTitle.dart';
import '../billPageComponents/ExpandBillInfo.dart';
import 'package:url_launcher/url_launcher.dart';
import './eventsTimeLineList.dart';

class BillInfoExpandable extends StatefulWidget {
  @override
  BillInfoExpandable({@required this.bill});
  final Map bill;
  _BillInfoExpandableState createState() =>
      _BillInfoExpandableState(bill: this.bill);
}

class _BillInfoExpandableState extends State<BillInfoExpandable> {
  final Map bill;
  bool expanded = false;
  void openCloseBill() {
    setState(() {
      expanded = !expanded;
    });
  }

//TODO: add unsave button to this component to remove it from list
  _BillInfoExpandableState({@required this.bill});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 15, 5, 0),
      // padding: EdgeInsets.all(10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFF1D1E33),
        border: Border.all(width: 2, color: Colors.black54),
      ),
      child: Column(
        // children: [
        children: this.expanded == false
            ? [
                FlatButton(
                  onPressed: openCloseBill,
                  color: Colors.deepOrange,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  padding: EdgeInsets.all(0),
                  child: BillHeader(
                    active: bill['active'],
                    slug: bill['bill_slug'],
                    enacted: bill['enacted'],
                  ),
                ),
                Text(
                  'Title',
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
                BillTitle(text: bill['title']),
                ExpandContentButton(
                    expandContent: openCloseBill,
                    loading: false,
                    expanded: this.expanded)
              ]
            : [
                FlatButton(
                  onPressed: openCloseBill,
                  color: Colors.deepOrange,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  padding: EdgeInsets.all(0),
                  child: BillHeader(
                    active: bill['active'],
                    slug: bill['bill_slug'],
                    enacted: bill['enacted'],
                  ),
                ),
                Text(
                  'Summary',
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
                BillTitle(text: bill['summary']),
                Text(
                  'Title',
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
                BillTitle(
                  text: bill['title'],
                ),
                Text(
                  'Details',
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Text(
                    'Link to Full Bill Text:',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                InkWell(
                  child: Text(
                    bill['gov_url'],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () => launch(bill['gov_url']),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    'Time Line',
                    style: TextStyle(
                        fontSize: 20, decoration: TextDecoration.underline),
                  ),
                ),
                EventList(
                  events: bill['events'],
                ),
                ExpandContentButton(
                    expandContent: openCloseBill,
                    loading: false,
                    expanded: this.expanded),
              ],
      ),
    );
  }
}
