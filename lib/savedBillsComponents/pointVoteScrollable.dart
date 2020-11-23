import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../defaultInfoComponents/billDates.dart';

class PointVoteScroller extends StatefulWidget {
  final List data;
  final bool userVote;
  PointVoteScroller({this.data, this.userVote});
  @override
  _PointVoteScrollerState createState() =>
      _PointVoteScrollerState(data: this.data, userVote: this.userVote);
}

class _PointVoteScrollerState extends State<PointVoteScroller> {
  bool loading = false;
  bool failed = false;
  String state;
  bool userVote;
  final sharedPrefs = SharedPreferences.getInstance();
  final List data;
  static ScrollController _controller;
  _PointVoteScrollerState({this.data, this.userVote}) {
    initializeUserTree();
  }
  initializeUserTree() async {
    try {
      final prefs = await sharedPrefs;
      double off = prefs.getDouble('savedPointVoteOffset');
      if (off == null) {
        off = 0.00;
        prefs.setDouble('savedPointVoteOffset', 0.00);
      }
      _controller = new ScrollController(initialScrollOffset: off);
      _controller.addListener(listen);
      setState(() {
        loading = false;
        failed = data.isEmpty ? true : false;
        this.state = prefs.getString('state');
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
      prefs.setDouble('savedPointVoteOffset', _controller.offset);
    } catch (err) {
      print('listener failed to save position: $err');
    }
  }

  getColorBasedOnUserVote(pos) {
    bool congVote = pos == 'Yes' ? true : false;
    if (userVote == null) {
      return Colors.transparent;
    } else if (userVote == congVote) {
      return Colors.blue;
    } else {
      return Colors.pink[900];
    }
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    if (failed == true) return Text('Failed...');
    if (loading == true) {
      return Text('Loading...');
    }
    return Container(
      height: 400,
      width: cWidth,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: Scrollbar(
          controller: ScrollController(keepScrollOffset: true),
          child: ListView.builder(
            itemCount: data.length,
            controller: _controller,
            itemBuilder: (context, index) {
              Map voter = data[index];
              return Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: this.state == voter['state']
                        ? Border.all(width: 2, color: Colors.amber)
                        : Border.all(width: 2, color: Colors.black54),
                    borderRadius: BorderRadius.circular(15),
                    color: getColorBasedOnUserVote(voter['vote_position'])),
                child: Column(
                  children: [
                    DatesRow(
                        introString: 'Name',
                        introDate: voter['full_name'],
                        lastAct: voter['member_party'].toString().split('T')[0],
                        lastActHeader: 'Party'),
                    DatesRow(
                      introString: 'State',
                      introDate: voter['state'],
                      lastActHeader: 'Title',
                      lastAct: voter['title'],
                    ),
                    Text('Vote Position: ${voter['vote_position']}',
                        style: TextStyle(
                            decoration: TextDecoration.underline, fontSize: 15))
                  ],
                ),
              );
            },
          )),
    );
  }
}
// Container(
//         child: Column(
//           children: [for (var bill in data.keys) Text(data[bill]['title'])],
//         ),
//       ),
