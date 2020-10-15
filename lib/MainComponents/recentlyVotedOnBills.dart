import 'package:flutter/material.dart';
import '../serverRequests/dataRequests.dart';
import '../billVotesComponents/votesContainer.dart';

class MostRecentVotesMain extends StatefulWidget {
  @override
  _MostRecentVotesMainState createState() => _MostRecentVotesMainState();
}

class _MostRecentVotesMainState extends State<MostRecentVotesMain> {
  final requestTools = Requests();
  List bills;
  bool loading = true;
  bool error = false;
  bool addingToList = false;
  _MostRecentVotesMainState() {
    initializePage();
  }
  initializePage() async {
    try {
      // final billList = await requestTools.mostRecentVotesBills('mostrecent');
      final billList = await requestTools.requestByUrl(
          requestTools.mostRecentlyVotedBills, 'mostrecent');
      this.bills = billList['body'];
      loading = false;
      this.setState(() {});
    } catch (err) {
      print('failure to initialize most recent votes $err');
    }
  }

  getNextSeries() async {
    try {
      this.addingToList = true;
      String paramDate = bills[bills.length - 1]['vote_date']
          .split(',')[0]
          .replaceAll('/', '-');
      final addition = await this.requestTools.mostRecentVotesBills(paramDate);
      for (var ac in addition['body']) {
        this.bills.add(ac);
      }
      this.addingToList = false;
      this.setState(() {});
    } catch (err) {
      print('Error with vote for get next series: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Text('Loading...');
    } else {
      return Scrollbar(
        controller: ScrollController(keepScrollOffset: true),
        child: ListView.builder(
            itemCount: bills.length,
            itemBuilder: (context, index) {
              if (index > bills.length - 6 && addingToList == false) {
                this.getNextSeries();
              }
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
                    VotesContainerWithExpandable(data: bills[index])
                  ],
                );
              } else {
                return VotesContainerWithExpandable(data: bills[index]);
              }
            }),
      );
    }
  }
}
