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
          });
    }
  }
}
