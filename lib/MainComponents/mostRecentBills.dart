import 'package:flutter/material.dart';
import '../serverRequests/dataRequests.dart';
import '../billPageComponents/billContainer.dart';

class MostRecentBills extends StatefulWidget {
  @override
  _MostRecentBillsState createState() => _MostRecentBillsState();
}

class _MostRecentBillsState extends State<MostRecentBills> {
  final requestTools = Requests();
  List bills;
  bool loading;
  _MostRecentBillsState() {
    initializePage();
  }
  initializePage() async {
    try {
      final billList = await this.requestTools.mostRecentBills();
      setState(() {
        this.bills = billList;
      });
    } catch (err) {
      print('Failure to Init most recent bills page');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.bills == null) {
      return Text('Loading...');
    } else {
      return ListView.builder(
          itemCount: bills.length,
          itemBuilder: (context, index) {
            // print(this.localCongMen[1][index]);
            return BillExpandableContainer(data: bills[index]);
          });
    }
  }
}
