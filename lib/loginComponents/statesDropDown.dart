import 'package:flutter/material.dart';
import './listOfStates.dart';

class StatesDropDown extends StatelessWidget {
  final callback;
  final dropVal;
  final states = statesList;
  final int flexInt;
  final bool enabled;
  StatesDropDown(
      {@required this.callback,
      @required this.dropVal,
      this.flexInt,
      this.enabled});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: this.flexInt == null ? 0 : this.flexInt,
      child: Container(
        // color: Colors.white,
        margin: EdgeInsets.all(20),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            hint: Text(this.dropVal),
            isExpanded: true,
            isDense: false,
            dropdownColor: Colors.transparent,
            onChanged:
                this.enabled == true ? (sel) => this.callback(sel) : null,
            value: this.dropVal,
            items: states,
            iconSize: 40,
          ),
        ),
      ),
    );
  }
}
