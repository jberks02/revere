import 'package:flutter/material.dart';

class RevereAppBar extends StatefulWidget {
  RevereAppBar({@required this.getPage});
  final getPage;
  @override
  _RevereAppBarState createState() => _RevereAppBarState(getPage: this.getPage);
}

class _RevereAppBarState extends State<RevereAppBar> {
  _RevereAppBarState({@required this.getPage});
  final getPage;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("anything"), //Text(this.getPage()),
      leading: IconButton(
        // padding: EdgeInsets.all(30),
        iconSize: 40,
        icon: Icon(
          Icons.view_list,
        ),
        alignment: Alignment.centerLeft,
        onPressed: () => {},
      ),
      actions: <Widget>[
        IconButton(
          iconSize: 30,
          icon: Icon(Icons.exit_to_app),
          onPressed: () => {},
        )
      ],
    );
  }
}
