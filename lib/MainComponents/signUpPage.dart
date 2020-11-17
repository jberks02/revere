import 'package:flutter/material.dart';
import '../loginComponents/loginButtons.dart';
import '../loginComponents/textField.dart';
import '../loginComponents/statesDropDown.dart';

class SignUpPage extends StatefulWidget {
  final tools;
  final cycle;
  SignUpPage({@required this.tools, @required this.cycle});
  @override
  _SignUpPageState createState() =>
      _SignUpPageState(tools: this.tools, cycle: this.cycle);
}

class _SignUpPageState extends State<SignUpPage> {
  final tools;
  final cycle;
  String user;
  String pass;
  String cPass;
  String state;
  String email;
  String name;
  bool loading = false;
  bool varsReady = false;
  signUp() async {
    try {
      setState(() {
        this.loading = true;
      });
      final signup =
          await this.tools.signUp(user, pass, email, state, name, cycle);
      print(signup);
    } catch (err) {
      print('Failure on sign Up function in SingUpPage widget: $err');
    }
  }

  checkReady() {
    int val = 0;
    if (this.user != null) val++;
    if (this.pass != null) val++;
    if (this.cPass != null) val++;
    if (this.state != null) val++;
    if (this.email != null) val++;
    if (this.name != null) val++;
    if (this.pass == this.cPass) val++;
    if (val >= 7) {
      setState(() {
        this.varsReady = true;
      });
    } else {
      setState(() {});
    }
  }

  _SignUpPageState({@required this.tools, @required this.cycle});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Field(
              hint: 'Display Name',
              callback: (txt) => {this.name = txt, checkReady()},
              obscure: false),
          Field(
              hint: 'User Name',
              callback: (txt) => {this.user = txt, checkReady()},
              obscure: false),
          Field(
              hint: 'Password',
              callback: (txt) => {this.pass = txt, checkReady()},
              obscure: true),
          Field(
              hint: 'Confirm Password',
              callback: (txt) => {this.cPass = txt, checkReady()},
              obscure: true,
              colr: this.cPass != null && this.cPass != this.pass
                  ? Colors.redAccent
                  : null),
          Field(
              hint: 'Email',
              callback: (txt) => {this.email = txt, checkReady()},
              obscure: false),
          StatesDropDown(
              dropVal: this.state,
              callback: (sel) => {
                    this.state = sel,
                    setState(() {
                      checkReady();
                    })
                  }),
          LoginButton(txt: 'Sign Up', callback: this.signUp, ready: varsReady)
        ],
      ),
    );
  }
}
