import 'package:flutter/material.dart';
import '../serverRequests/dataRequests.dart';
import '../billPageComponents/billContainer.dart';

class MostRecentActions extends StatefulWidget {
  @override
  _MostRecentActionsState createState() => _MostRecentActionsState();
}

class _MostRecentActionsState extends State<MostRecentActions> {
  final requestTools = Requests();
  List bills;
  bool loading;
  bool addingToList = false;
  _MostRecentActionsState() {
    initializePage();
  }
  initializePage() async {
    try {
      final billList = await this.requestTools.mostRecentBills('mostrecent');
      setState(() {
        this.bills = billList;
      });
    } catch (err) {
      print('Failure to Init most recent bills page');
    }
  }

  getNextSeries() async {
    try {
      this.addingToList = true;
      String paramDate = bills[bills.length - 1]['latest_major_action']
          .split(',')[0]
          .replaceAll('/', '-');
      final addition = await this.requestTools.mostRecentBills(paramDate);
      for (var ac in addition) {
        this.bills.add(ac);
      }
      this.addingToList = false;
      this.setState(() {});
    } catch (err) {
      print('Failure to expand List for infinite scroll $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.bills == null) {
      return Text('Loading...');
    } else {
      print(bills.length);
      return Scrollbar(
        child: ListView.builder(
            itemCount: bills.length,
            itemBuilder: (context, index) {
              // print(this.localCongMen[1][index]);
              if (index > bills.length - 6 && addingToList == false)
                this.getNextSeries();
              if (index == 0) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      decoration: BoxDecoration(
                          color: Color(0xff0040ad),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text('Bills By Latest Acts',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20)),
                    ),
                    BillExpandableContainer(
                        data: bills[index], middleText: 'Action')
                  ],
                );
              }
              // index -= 1;
              return BillExpandableContainer(
                  data: bills[index], middleText: 'Action');
            }),
      );
    }
  }
}
