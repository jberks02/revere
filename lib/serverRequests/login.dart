import 'package:http/http.dart' as req;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserInformation {
  String userName;
  String pass;
  bool logged;
  String pageName;
  String name;
  String email;
  String cookie;
  UserInformation() {
    setNewInfo();
  }
  setNewInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      this.userName = prefs.getString('user');
      this.pass = prefs.getString('pass');
      this.logged = prefs.getBool('logged');
      this.pageName = prefs.getString('page');
      this.name = prefs.getString('name');
      this.cookie = prefs.getString('cookie');
      if (this.pageName == null && this.logged != null) this.pageName = "Vigil";
      if (this.pageName == null && this.logged == null) this.pageName = "Login";
    } catch (err) {
      print("Failure on setNewInfo in User information $err");
    }
  }

  setScreenToSignUp(setup) => setup(() {
        this.pageName = 'Sign Up';
      });
  login(String id, String pass, pick) async {
    try {
      final save = await SharedPreferences.getInstance();
      final Object info = {"id": id, "pass": pass};
      final success =
          await req.post('http://localhost:8080/login/user', body: info);
      if (success.statusCode == 200) {
        utf8.encode(json.encode(success.headers));
        var bod = json.decode(success.body)['body'];
        final headerKey = "cookie";
        final header = success.headers['set-cookie'];
        await save.setString(headerKey, header);
        await save.setString('user', id);
        await save.setString('pass', pass);
        await save.setBool('logged', true);
        await save.setString('name', bod['name']);
        await save.setString('email', bod['email']);
        await save.setString('state', bod['state']);
        await save.setString('page', 'Vigil');
        if (pick != null) {
          pick(() {
            this.setNewInfo();
          });
        }
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print('Failure to login: $err');
      return false;
    }
  }

  logout(Function route) async {
    try {
      final sto = await SharedPreferences.getInstance();
      sto.setString('user', null);
      sto.setString('pass', null);
      sto.setString('cookie', null);
      sto.setString('page', 'Login');
      sto.setBool('logged', false);
      this.newPage('Login', route);
      route(() {
        this.setNewInfo();
      });
      return true;
    } catch (err) {
      print('Failed to Logout $err');
      return false;
    }
  }

  signUp(user, pass, email, state, name, cycle) async {
    try {
      final Map newUser = {
        "userID": user,
        "pass": pass,
        "email": email,
        "State": state,
        "name": name
      };
      final request =
          await req.post("http://localhost:8080/login/newUser", body: newUser);
      if (request.statusCode == 200) {
        final save = await SharedPreferences.getInstance();
        utf8.encode(json.encode(request.headers));
        final headerKey = "cookie";
        final header = request.headers['set-cookie'];
        await save.setString(headerKey, header);
        await save.setString('user', user);
        await save.setString('pass', pass);
        await save.setBool('logged', true);
        await save.setString('page', 'Vigil');
        await save.setString('email', email);
        await save.setString('name', name);
        cycle(() {
          this.setNewInfo();
        });
      } else {
        final stat = request.body;
        print('Failure on sign up request: $stat');
      }
    } catch (err) {
      print('Failure to sign Up due to error: $err');
      return false;
    }
  }

  getPage() {
    if (this.pageName == null)
      return "Login";
    else
      return this.pageName;
  }

  newPage(page, cycle) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // await this.handlePageHistory(page, true);
      List<String> pageHistory = prefs.getStringList('pageHistory');
      if (pageHistory == null) {
        pageHistory = ['Vigil'];
      } else {
        pageHistory[0] = 'Vigil';
      }
      pageHistory.add(page);
      final toWrite = pageHistory.toSet().toList();
      prefs.setStringList('pageHistory', toWrite);
      prefs.setString('page', page);
      cycle(() {
        this.setNewInfo();
      });
    } catch (err) {
      print('Failure to set new page: $err');
    }
  }

  backPage(cycle) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List pageHistory = prefs.getStringList('pageHistory');
      if (pageHistory.length > 1) {
        final int prev = pageHistory.length - 2;
        final String prevPage = pageHistory[prev];
        pageHistory.removeLast();
        prefs.setStringList('pageHistory', pageHistory);
        prefs.setString('page', prevPage);
        await setNewInfo();
        cycle(() {});
        return prevPage;
      } else {
        return false;
      }
    } catch (err) {
      print('Failed to go pack a page: $err');
      return false;
    }
  }
}
