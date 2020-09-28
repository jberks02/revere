import 'package:flutter/material.dart';
import '../serverRequests/dataRequests.dart';
import '../billPageComponents/billContainer.dart';

class MostRecentVotesMain extends StatefulWidget {
  @override
  _MostRecentVotesMainState createState() => _MostRecentVotesMainState();
}

class _MostRecentVotesMainState extends State<MostRecentVotesMain> {
  final requestTools = Requests();
  List bills;
  bool loading = true;
  bool error = false;
  _MostRecentVotesMainState() {
    initializePage();
  }
  initializePage() async {
    try {
      final billList = await requestTools.mostRecentVotesBills();
      this.bills = billList['body'];
      loading = false;
      this.setState(() {});
    } catch (err) {
      print('failure to initialize most recent votes $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Text('Loading...');
    } else {
      return ListView.builder(
          itemCount: bills.length,
          itemBuilder: (context, index) {
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
                    child: Text('Bills By Latest Votes',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                  ),
                  BillExpandableContainer(
                      data: bills[index], middleText: 'Vote')
                ],
              );
            }
            return BillExpandableContainer(
                data: bills[index], middleText: 'Vote');
          });
    }
  }
}
