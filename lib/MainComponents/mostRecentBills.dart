import 'package:flutter/material.dart';
import 'package:revere/utilWidgets/failedLoad.dart';
import '../serverRequests/dataRequests.dart';
import '../billPageComponents/billContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../utilWidgets/loadingPage.dart';
import '../utilWidgets/failedLoad.dart';

class MostRecentActions extends StatefulWidget {
  @override
  _MostRecentActionsState createState() => _MostRecentActionsState();
}

class _MostRecentActionsState extends State<MostRecentActions> {
  final requestTools = Requests();
  List bills;
  bool loading = true;
  bool failed = false;
  bool addingToList = false;
  static ScrollController _controller;

  _MostRecentActionsState() {
    initializePage();
    initializeScrollController();
  }
  initializeScrollController() async {
    var prefs = await SharedPreferences.getInstance();
    double off = prefs.getDouble('listIndex');
    if (off == null) {
      _controller = new ScrollController(
          initialScrollOffset: 0.00, keepScrollOffset: true);
    } else {
      _controller = new ScrollController(
          initialScrollOffset: off, keepScrollOffset: true);
    }
    _controller.addListener(listen);
  }

  void listen() async {
    var prefs = await SharedPreferences.getInstance();
    if (_controller.offset < -90.00 && this.loading == false) {
      this.getBeginningOfList(prefs);
    } else {
      prefs.setDouble('listIndex', _controller.offset);
    }
  }

  initializePage() async {
    try {
      failed = false;
      var prefs = await SharedPreferences.getInstance();
      String initialBillString = prefs.getString('ActionList');
      if (initialBillString == null) {
        this.getBeginningOfList(prefs);
      } else {
        setState(() {
          this.bills = jsonDecode(initialBillString);
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
      print('begginning of list');
      this.setState(() {
        loading = true;
        this.bills = null;
      });
      prefs.setString('ActionList', null);
      final billList = await this.requestTools.mostRecentBills('mostrecent');
      if (billList == false) {
        setState(() {
          loading = false;
          failed = true;
        });
      } else {
        prefs.setString('ActionList', jsonEncode(billList));
        prefs.setString('ActionUpdateDate', DateTime.now().toString());
        setState(() {
          this.bills = billList;
          loading = false;
        });
      }
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
    try {
      final prefs = await SharedPreferences.getInstance();
      await this.requestTools.saveBillById(billToUpdate);
      bills.forEach((bill) {
        if (bill['bill_id'] == billToUpdate) {
          bill['saved'] = true;
        }
      });
      prefs.setString('ActionList', jsonEncode(this.bills));
      return true;
    } catch (err) {
      print('Failure to save bill: $err');
      return false;
    }
  }

  deleteBill(billToUpdate) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await this.requestTools.deleteBillFromSave(billToUpdate);
      bills.forEach((bi) {
        if (bi['bill_id'] == billToUpdate) {
          bi['saved'] = false;
        }
      });
      prefs.setString('ActionList', jsonEncode(this.bills));
      return true;
    } catch (err) {
      print('Failure to delete bill from favorites $err');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (failed == true) {
      return FailedLoad(reload: this.initializePage);
    } else if (loading == true || this.bills == null) {
      return LoadingPage();
    } else {
      return Scrollbar(
        child: ListView.builder(
            controller: _controller,
            itemCount: bills.length,
            itemBuilder: (context, index) {
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
                        saveFunc: saveBill,
                        deleteFunc: deleteBill)
                  ],
                );
              }
              // index -= 1;
              return BillExpandableContainer(
                  data: bills[index],
                  middleText: 'Action',
                  saveFunc: saveBill,
                  deleteFunc: deleteBill);
            }),
      );
    }
  }
}
