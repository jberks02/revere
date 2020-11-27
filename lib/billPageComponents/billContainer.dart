import 'package:flutter/material.dart';
import '../serverRequests/dataRequests.dart';
import '../defaultInfoComponents/billTitle.dart';
import '../defaultInfoComponents/billDates.dart';
import '../defaultInfoComponents/userActions.dart';
import './ExpandBillInfo.dart';
import './ExpandedContent.dart';
import './billContainerHeader.dart';

class BillExpandableContainer extends StatefulWidget {
  BillExpandableContainer(
      {@required this.data,
      @required this.middleText,
      @required this.saveFunc,
      @required this.deleteFunc});
  final Map data;
  final String middleText;
  final saveFunc;
  final deleteFunc;
  @override
  _BillExpandableContainerState createState() => _BillExpandableContainerState(
      data: this.data,
      middleText: this.middleText,
      saveFunc: this.saveFunc,
      deleteFunc: deleteFunc);
}

class _BillExpandableContainerState extends State<BillExpandableContainer> {
  final request = Requests();
  final Map data;
  final String middleText;
  final saveFunc;
  final deleteFunc;
  Map expandedContent;
  bool expanded = false;
  bool loading = false;
  _BillExpandableContainerState(
      {@required this.data,
      @required this.middleText,
      @required this.saveFunc,
      @required this.deleteFunc});
  expandBillInfo() async {
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
        children: <Widget>[
          UserActions(
              saved: data['saved'],
              saveCall: saveFunc,
              deleteFunc: deleteFunc,
              bill_id: data['bill_id'],
              approveDisapprove: false),
          BillHeader(
            slug: data['bill_slug'],
            enacted: data['enacted'],
            active: data['active'],
          ),
          BillTitle(
            text: data['title'],
          ),
          Text("Action: ${data['action_id']}",
              style: TextStyle(
                  fontSize: 20, decoration: TextDecoration.underline)),
          BillTitle(text: data['description']),
          DatesRow(
            introDate: data['introduction_date'],
            lastAct: data['action_date'].split('T')[0],
            lastActHeader: 'Action Date',
          ),
          this.expanded == false
              ? Text('')
              : ExpandedContent(details: this.expandedContent['body']),
          ExpandContentButton(
              loading: this.loading,
              expanded: this.expanded,
              expandContent: this.expandBillInfo)
        ],
      ),
    );
  }
}
