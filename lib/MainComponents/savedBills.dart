import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../serverRequests/dataRequests.dart';
import '../savedBillsComponents/savedBillsContainer.dart';
import '../utilWidgets/loadingPage.dart';
import '../utilWidgets/failedLoad.dart';

class SavedBills extends StatefulWidget {
  @override
  _SavedBillsState createState() => _SavedBillsState();
}

class _SavedBillsState extends State<SavedBills> {
  bool loading = true;
  bool failed = false;
  final Function treeReq = Requests().userTree;
  final Function deleteBill = Requests().deleteBillFromSave;
  final sharedPrefs = SharedPreferences.getInstance();
  List data;
  static ScrollController _controller;
  _SavedBillsState() {
    initializeUserTree();
  }
  initializeUserTree() async {
    try {
      final prefs = await sharedPrefs;
      double off = prefs.getDouble('savedBillsOffset');
      if (off == null) {
        off = 0.00;
        prefs.setDouble('savedBillsOffset', 0.00);
      }
      _controller = new ScrollController(initialScrollOffset: off);
      _controller.addListener(listen);
      data = await this.treeReq();
      setState(() {
        loading = false;
        failed = data.isEmpty ? true : false;
      });
    } catch (err) {
      print('Failed to initialize user tree: $err');
    }
  }

  void deleteSwipedBill(billID, index) async {
    try {
      await this.deleteBill(billID);
      this.setState(() {
        data.removeAt(index);
      });
    } catch (err) {
      print('Failure to delete bill from favorites in Saved Bills: $err');
    }
  }

  listen() async {
    try {
      final prefs = await sharedPrefs;
      if (_controller.offset < -80.00 && loading == false) {
        setState(() {
          loading = true;
        });
        initializeUserTree();
      }
      prefs.setDouble('savedBillsOffset', _controller.offset);
    } catch (err) {
      print('listener failed to save position: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (failed == true) return FailedLoad(reload: this.initializeUserTree);
    if (loading == true) return LoadingPage();
    return Scrollbar(
        controller: ScrollController(keepScrollOffset: true),
        child: ListView.builder(
          itemCount: data.length,
          controller: _controller,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(data[index]['bill_id']),
              onDismissed: (direction) {
                this.deleteSwipedBill(data[index]['bill_id'], index);
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                        "${data[index]['bill_id']} removed from saved bills",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                );
              },
              background: Container(color: Colors.grey),
              // child: ListTile(title: Text('$data')),
              child: BillInfoExpandable(
                bill: data[index],
              ),
            );
          },
        ));
  }
}
// Container(
//         child: Column(
//           children: [for (var bill in data.keys) Text(data[bill]['title'])],
//         ),
//       ),
