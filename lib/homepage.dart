import 'package:flutter/material.dart';
import './serverRequests/login.dart';
import './MainComponents/loginPage.dart';
import './MainComponents/home.dart';
import './MainComponents/signUpPage.dart';
import './appBarComponents/listDropDown.dart';
import './appBarComponents/backArrow.dart';
import './MainComponents/mostRecentBills.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tools = UserInformation();
  pickScreen(page) {
    if (page == "Login")
      return LoginMain(tools: this.tools, pickScreen: setState);
    else if (page == "Vigil")
      return PageView(
        controller: PageController(initialPage: 2),
        children: <Widget>[
          LoginMain(tools: this.tools, pickScreen: setState),
          MainPage(),
          MostRecentBills()
        ],
      );
    else if (page == "Sign Up")
      return SignUpPage(tools: this.tools, cycle: setState);
    else
      return LoginMain(tools: this.tools, pickScreen: setState);
  }

  _HomePageState() {
    this.setPageAndHome();
  }
  setPageAndHome() async {
    await this.tools.setNewInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.tools.getPage()), //Text(this.getPage()),
        leading: BackArrow(backPage: this.tools.backPage, cycle: setState),
        actions: <Widget>[
          LeadingDropDown(
              logout: this.tools.logout,
              pageChange: this.tools.newPage,
              cycle: setState)
        ],
      ),
      body: this.pickScreen(this.tools.pageName),
    );
  }
}
