import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../serverRequests/dataRequests.dart';
import '../savedBillsComponents/savedBillsContainer.dart';

class SavedBills extends StatefulWidget {
  @override
  _SavedBillsState createState() => _SavedBillsState();
}

class _SavedBillsState extends State<SavedBills> {
  bool loading = true;
  bool failed = false;
  final Function treeReq = Requests().userTree;
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
    if (failed == true) return Text('Failed...');
    if (loading == true) {
      return Text('Loading...');
    }
    return Scrollbar(
        controller: ScrollController(keepScrollOffset: true),
        child: ListView.builder(
          itemCount: data.length,
          controller: _controller,
          itemBuilder: (context, index) {
            return BillInfoExpandable(bill: data[index]);
          },
        ));
  }
}
// Container(
//         child: Column(
//           children: [for (var bill in data.keys) Text(data[bill]['title'])],
//         ),
//       ),
