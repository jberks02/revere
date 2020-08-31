import 'package:flutter/material.dart';
import './listOfStates.dart';

class StatesDropDown extends StatelessWidget {
  final callback;
  final dropVal;
  final states = statesList;
  StatesDropDown({@required this.callback, @required this.dropVal});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Container(
        // color: Colors.white,
        margin: EdgeInsets.all(20),
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            hint: Text("Choose Your State"),
            isExpanded: true,
            isDense: false,
            dropdownColor: Colors.transparent,
            onChanged: (sel) => this.callback(sel),
            value: this.dropVal,
            // iconEnabledColor: Colors.black,
            items: states,
            iconSize: 40,
          ),
        ),
      ),
    );
  }
}
// TextField(
//           onChanged: (sel) => {print('we selected: $sel')},
//           obscureText: false,
//           decoration: InputDecoration(
//               hintText: 'Choose Your State',
//               fillColor: Colors.white,
//               filled: true,
//               border: InputBorder.none),
//         )
