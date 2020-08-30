import 'package:flutter/material.dart';
import '../loginComponents/textField.dart';
import '../loginComponents/loginButtons.dart';

class LoginMain extends StatefulWidget {
  final tools;
  final pickScreen;
  LoginMain({this.tools, this.pickScreen});
  @override
  _LoginMainState createState() =>
      _LoginMainState(tools: this.tools, pickScreen: this.pickScreen);
}

class _LoginMainState extends State<LoginMain> {
  String user;
  String pass;
  final tools;
  final pickScreen;
  void updateUser(user) {
    this.user = user;
  }

  void updatePass(pass) {
    this.pass = pass;
  }

  void loginAction() => this.tools.login(this.user, this.pass, this.pickScreen);
  void signUpAction() => this.tools.newPage('Sign Up', this.pickScreen);
  _LoginMainState({this.tools, this.pickScreen});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Field(hint: 'User Name', callback: this.updateUser, obscure: false),
          Field(hint: 'Password', callback: this.updatePass, obscure: true),
          LoginButton(txt: 'Sign In', callback: this.loginAction),
          LoginButton(txt: 'Create New Account', callback: this.signUpAction)
        ],
      ),
    );
  }
}
