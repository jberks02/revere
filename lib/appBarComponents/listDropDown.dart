import 'package:flutter/material.dart';

class LeadingDropDown extends StatefulWidget {
  final logout;
  final pageChange;
  final cycle;
  LeadingDropDown({this.logout, this.pageChange, this.cycle});
  @override
  _LeadingDropDownState createState() => _LeadingDropDownState(
      logout: this.logout, pageChange: this.pageChange, cycle: this.cycle);
}

class _LeadingDropDownState extends State<LeadingDropDown> {
  final logout;
  final pageChange;
  final cycle;
  String dropdown;
  _LeadingDropDownState({this.logout, this.pageChange, this.cycle});
  List<PopupMenuEntry<dynamic>> dropList = [
    PopupMenuItem(child: Text('Logout'), value: "Logout"),
    PopupMenuItem(child: Text('Profile'), value: "Profile")
  ];
  changeSelect(val) {
    if (val == 'Logout')
      this.logout(this.cycle);
    else if (val == 'Profile') this.pageChange(val, cycle);
  }

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: PopupMenuButton(
        offset: Offset(0, 100),
        icon: Icon(Icons.portrait, size: 35, color: Colors.deepOrange),
        onSelected: (val) => changeSelect(val),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(child: Text('Profile'), value: "Profile"),
            PopupMenuItem(child: Text('Logout'), value: "Logout")
          ];
        },
      ),
    );
  }
}
