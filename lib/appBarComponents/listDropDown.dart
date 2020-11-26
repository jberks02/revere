import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  changeSelect(val) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool logged = prefs.getBool('logged');
      print("page name in drop down: $val");
      if (logged == true) {
        if (val == 'Logout')
          this.logout(this.cycle);
        else
          this.pageChange(val, cycle);
      }
    } catch (err) {
      print('failure to change selected page: $err');
    }
  }

//TODO: Debug issue where going to the saved bills page clears all history and makes back button useless
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
            PopupMenuItem(child: Text('Saved Bills'), value: "Saved Bills"),
            PopupMenuItem(child: Text('Profile'), value: 'Profile'),
            PopupMenuItem(child: Text('Logout'), value: "Logout")
          ];
        },
      ),
    );
  }
}
