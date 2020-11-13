import 'package:flutter/material.dart';
import '../serverRequests/dataRequests.dart';
import '../billPageComponents/billContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';

class MostRecentActions extends StatefulWidget {
  @override
  _MostRecentActionsState createState() => _MostRecentActionsState();
}

class _MostRecentActionsState extends State<MostRecentActions> {
  final requestTools = Requests();
  List bills;
  bool loading = true;
  bool addingToList = false;
  int initialScrollOffset = 0;
  static ScrollController _controller;

  _MostRecentActionsState() {
    initializePage();
    initializeScrollController();
  }
  initializeScrollController() async {
    var prefs = await SharedPreferences.getInstance();
    double off = prefs.getDouble('listIndex');
    if (off == null) {
      _controller = new ScrollController(initialScrollOffset: 0.00);
    } else {
      _controller = new ScrollController(initialScrollOffset: off);
    }
    _controller.addListener(listen);
  }

  void listen() async {
    var prefs = await SharedPreferences.getInstance();
    double off = prefs.getDouble('listIndex');
    if (off == null) {
      prefs.setDouble('listIndex', 0.00);
      off = 0.00;
    }
    if (_controller.offset > off + 25.0 || _controller.offset < off - 25.0) {
      prefs.setDouble('listIndex', _controller.offset);
    }
  }

  initializePage() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String initialBillString = prefs.getString('ActionList');
      String initialUpdateString = prefs.getString('ActionUpdateDate');
      DateTime today = new DateTime.now();
      DateTime lastLoad = initialUpdateString == null
          ? null
          : DateTime.parse(initialUpdateString);
      if (initialBillString == null ||
          today.day > lastLoad.day && today.month != lastLoad.month) {
        this.getBeginningOfList(prefs);
      } else {
        setState(() {
          this.bills = jsonDecode(initialBillString);
          this.initialScrollOffset = prefs.getDouble('listIndex') == null
              ? 0
              : prefs.getDouble('listIndex');
          loading = false;
        });
      }
    } catch (err) {
      print('Failure to Init most recent bills page: $err');
      var prefs = await SharedPreferences.getInstance();
      this.getBeginningOfList(prefs);
    }
  }

  getBeginningOfList(prefs) async {
    try {
      final billList = await this.requestTools.mostRecentBills('mostrecent');
      prefs.setString('ActionList', jsonEncode(billList));
      prefs.setString('ActionUpdateDate', DateTime.now().toString());
      prefs.getDouble('listIndex');
      setState(() {
        this.bills = billList;
        this.initialScrollOffset = 0;
        loading = false;
      });
    } catch (err) {
      print('Failure to start page for Actions: $err');
    }
  }

  getNextSeries() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      this.addingToList = true;
      String paramDate = bills[bills.length - 1]['latest_major_action']
          .split(',')[0]
          .replaceAll('/', '-');
      final addition = await this.requestTools.mostRecentBills(paramDate);
      for (var ac in addition) {
        this.bills.add(ac);
      }
      this.addingToList = false;
      prefs.setString('ActionList', jsonEncode(this.bills));
      this.setState(() {});
    } catch (err) {
      print('Failure to expand List for infinite scroll $err');
    }
  }

  saveBill(billToUpdate) async {
    bool save = await this.requestTools.saveBillById(billToUpdate);
    if (save == false) {
      return false;
    } else {
      for (var bill in bills) {
        if (bill['bill_id'] == billToUpdate) {
          bill.saved = true;
        }
      }
      setState(() {});
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Text('Loading...');
    } else {
      return Scrollbar(
        child: ListView.builder(
            itemCount: bills.length,
            key: ValueKey<int>(Random(DateTime.now().millisecondsSinceEpoch)
                .nextInt(4294967296)),
            controller: _controller,
            itemBuilder: (context, index) {
              // print(this.localCongMen[1][index]);
              // this.updateIndex();
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
                        data: bills[index],
                        middleText: 'Action',
                        saveFunc: saveBill)
                  ],
                );
              }
              // index -= 1;
              return BillExpandableContainer(
                  data: bills[index], middleText: 'Action', saveFunc: saveBill);
            }),
      );
    }
  }
}
