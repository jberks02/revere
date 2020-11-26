import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../loginComponents/textField.dart';
import '../loginComponents/statesDropDown.dart';
import '../loginComponents/loginButtons.dart';
import '../serverRequests/login.dart';

class ProfileContainer extends StatefulWidget {
  @override
  _ProfileContainerState createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  String newEmail;
  String newState;
  String newDisplayName;
  final Function updateUserDetails = UserInformation().setNewProfileInfo;
  void toggleEnabled(tiggle) {
    bool allowOpen;
    if (tiggle['enabled'] == true)
      allowOpen = true;
    else
      allowOpen = checkForOpenLocks();
    if (allowOpen == true) {
      this.setState(() {
        tiggle['enabled'] = tiggle['enabled'] == true ? false : true;
      });
    }
  }

  updateUserInformation(unUseable) async {
    try {
      Map payload = {
        'dName': this.newDisplayName == null
            ? this.dName['info']
            : this.newDisplayName,
        'email': this.newEmail == null ? this.email['info'] : this.newEmail,
        'state': this.newState == null ? this.state['info'] : this.newState
      };
      await this.updateUserDetails(payload);
      await this.initProfileData();
      setState(() {
        this.newDisplayName = null;
        this.newEmail = null;
        this.newState = null;
      });
      // return true;
    } catch (err) {
      print('Failure in profile container to update user info: $err');
    }
  }

  checkForOpenLocks() {
    if (this.email['enabled'] == true)
      return false;
    else if (this.dName['enabled'] == true)
      return false;
    else if (this.state['enabled'] == true)
      return false;
    else
      return true;
  }

  checkForUpdateButtonReady() {
    bool openLocks = checkForOpenLocks();
    if (openLocks == false)
      return false;
    else if (this.newDisplayName != null ||
        this.newEmail != null ||
        this.newState != null)
      return true;
    else
      return false;
  }

  void setNewEmail(val) => this.setState(() {
        this.newEmail = val == '' ? null : val;
      });

  void setNewDisplayName(val) => this.setState(() {
        this.newDisplayName = val == '' ? null : val;
      });
  void setNewState(val) => this.setState(() {
        this.newState = this.state['info'] == val ? null : val;
      });

  Map email = {
    'info': '*****',
    'enabled': false,
    'callback': (val) => {null}
  };
  Map dName = {
    'info': '*****',
    'enabled': false,
    'callback': (val) => {null}
  };
  Map state = {
    'info': 'AR',
    'enabled': false,
    'callback': (val) => {null}
  };
  _ProfileContainerState() {
    initProfileData();
  }
  initProfileData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      this.dName['info'] = prefs.getString('name');
      this.dName['callback'] = (val) => {this.setNewDisplayName(val)};
      this.state['info'] = prefs.getString('state');
      this.state['callback'] = (val) => {this.setNewState(val)};
      this.email['info'] = prefs.getString('email');
      this.email['callback'] = (val) => {this.setNewEmail(val)};
      this.setState(() {});
    } catch (err) {
      print('Failed to init profile page: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Row(
          children: [
            Field(
                fieldFlex: 6,
                enable: this.dName['enabled'],
                callback: this.dName['callback'],
                hint: this.dName['info'],
                obscure: false,
                colr: null),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () => {toggleEnabled(this.dName)},
                child: Icon(this.dName['enabled'] == false
                    ? Icons.lock
                    : Icons.lock_open),
              ),
            )
          ],
        ),
        Row(
          children: [
            StatesDropDown(
                dropVal:
                    this.newState == null ? this.state['info'] : this.newState,
                callback: this.state['callback'],
                flexInt: 6,
                enabled: this.state['enabled']),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () => {toggleEnabled(this.state)},
                child: Icon(this.state['enabled'] == false
                    ? Icons.lock
                    : Icons.lock_open),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Field(
                fieldFlex: 6,
                enable: this.email['enabled'],
                callback: this.email['callback'],
                hint: this.email['info'],
                obscure: false,
                colr: null),
            Expanded(
              flex: 1,
              child: FlatButton(
                onPressed: () => {toggleEnabled(this.email)},
                child: Icon(this.email['enabled'] == false
                    ? Icons.lock
                    : Icons.lock_open),
              ),
            )
          ],
        ),
        LoginButton(
            txt: 'Update Information',
            callback: this.updateUserInformation,
            ready: checkForUpdateButtonReady())
      ],
    ));
  }
}
