import 'package:flutter/material.dart';
import '../serverRequests/dataRequests.dart';
import '../billVotesComponents/votesContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  static ScrollController _controller;
  _MostRecentVotesMainState() {
    initializePage();
    initializeScrollController();
  }
  initializeScrollController() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      double off = prefs.getDouble('votedOffset');
      if (off == null) {
        off = 0.00;
        prefs.setDouble('votedOffset', 0.00);
      }
      _controller = new ScrollController(initialScrollOffset: off);
      _controller.addListener(listen);
    } catch (err) {
      print('failure to initalize scroll controller in votes list: $err');
    }
  }

  initializePage() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var list = prefs.getString('votedList');
      if (list == null) {
        final billList = await requestTools.requestByUrl(
            requestTools.mostRecentlyVotedBills, 'mostrecent');
        this.bills = billList['body'];
        loading = false;
        prefs.setString('votedList', jsonEncode(this.bills));
        this.setState(() {});
      } else {
        loading = false;
        this.bills = jsonDecode(list);
        setState(() {});
      }
      // final billList = await requestTools.mostRecentVotesBills('mostrecent');

    } catch (err) {
      print('failure to initialize most recent votes $err');
    }
  }

  resetListToBeginning() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      prefs.setString('votedList', null);
      prefs.setDouble('votedOffset', 0.00);
      initializePage();
    } catch (err) {
      print('failure to reset voted data set: $err');
    }
  }

  void listen() async {
    var prefs = await SharedPreferences.getInstance();
    if (_controller.offset < -90.00 && this.loading == false) {
      resetListToBeginning();
      setState(() {
        this.loading = true;
      });
    }
    prefs.setDouble('votedOffset', _controller.offset);
  }

  getNextSeries() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      this.addingToList = true;
      String paramDate = bills[bills.length - 1]['vote_date']
          .split(',')[0]
          .replaceAll('/', '-');
      final addition = await this.requestTools.mostRecentVotesBills(paramDate);
      for (var ac in addition['body']) {
        this.bills.add(ac);
      }
      this.addingToList = false;
      prefs.setString('votedList', jsonEncode(this.bills));
      this.setState(() {});
    } catch (err) {
      print('Error with vote for get next series: $err');
    }
  }

  saveBill(billToUpdate) async {
    try {
      bool save = await this.requestTools.saveBillById(billToUpdate);
      if (save == false) {
        return false;
      } else {
        for (var bill in bills) {
          if (bill['bill_id'] == billToUpdate) {
            bill['saved'] = true;
          }
        }
        return true;
      }
    } catch (err) {
      print('Failure to save bill: $err');
      return false;
    }
  }

  deleteBill(billToUpdate) async {
    try {
      final remove = await this.requestTools.deleteBillFromSave(billToUpdate);
      bills.forEach((bi) {
        if (bi['bill_id'] == billToUpdate) {
          bi['saved'] = false;
        }
      });
      return true;
    } catch (err) {
      print('Failure to delete bill from favorites $err');
      return false;
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
            controller: _controller,
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
                    VotesContainerWithExpandable(
                        data: bills[index],
                        saveFunc: saveBill,
                        deleteFunc: deleteBill)
                  ],
                );
              } else {
                return VotesContainerWithExpandable(
                    data: bills[index],
                    saveFunc: saveBill,
                    deleteFunc: deleteBill);
              }
            }),
      );
    }
  }
}
