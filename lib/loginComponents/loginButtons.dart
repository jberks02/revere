import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  LoginButton({@required this.txt, @required this.callback, this.ready});
  final txt;
  final callback;
  final ready;
  colorCheck() =>
      this.ready == null || this.ready == true ? Colors.blue : Colors.grey;
  void funcCheck() =>
      this.ready == null || this.ready == true ? this.callback() : null;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      height: 60,
      width: 400,
      child: FlatButton(
        color: this.colorCheck(),
        onPressed: () => {this.funcCheck()},
        child: Text(
          this.txt,
          style: TextStyle(
            // color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
