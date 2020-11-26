import 'package:flutter/material.dart';

class Field extends StatelessWidget {
  Field(
      {@required this.hint,
      @required this.callback,
      @required this.obscure,
      this.colr,
      this.enable,
      this.fieldFlex});
  final int fieldFlex;
  final bool enable;
  final String hint;
  final Function callback;
  final bool obscure;
  final Color colr;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: this.fieldFlex == null ? 0 : this.fieldFlex,
      child: Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          enabled: this.enable == null ? true : this.enable,
          onChanged: (txt) => {this.callback(txt)},
          obscureText: this.obscure,
          decoration: InputDecoration(
              hintText: this.hint,
              fillColor: this.colr == null ? null : this.colr,
              filled: true,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
