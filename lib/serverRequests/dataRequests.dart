import 'package:http/http.dart' as req;
import 'dart:convert';
import './login.dart';
import './urlClass.dart';

class Requests extends UserInformation with UrlContainer {
  Requests() {
    this.validateCookie();
  }
  updateUserVote(payload) async {
    try {
      bool cookieReady = await validateCookie();
      if (cookieReady == true) {
        print(payload);
        final update = await req.post(this.updateUserVoteAddress,
            headers: {
              'cookie': this.cookie,
              'Content-Type': 'application/json'
            },
            body: json.encode(payload));
        print(update.body);
        if (update.statusCode == 200)
          return true;
        else
          return false;
      } else {
        return false;
      }
    } catch (err) {
      print('Failure to save user vote:  $err');
      return false;
    }
  }

  deleteBillFromSave(bill) async {
    try {
      bool cookieReady = await validateCookie();
      if (cookieReady == true) {
        final Map sentData = {'bill': bill};
        final update = await req.post(this.deleteUserFavorite,
            headers: {'cookie': this.cookie}, body: sentData);
        if (update.statusCode == 200) {
          return json.decode(update.body);
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (err) {
      print('failure to delete bill from db by id $err');
      return false;
    }
  }

  saveBillById(bill) async {
    try {
      bool cookieReady = await validateCookie();
      if (cookieReady == true) {
        final Map sentData = {'bill': bill};
        final update = await req.post(this.updateUserFavorite,
            headers: {'cookie': this.cookie}, body: sentData);
        if (update.statusCode == 200) {
          final Map details = json.decode(update.body);
          if (details['code'] == 200)
            return true;
          else
            return false;
        } else {
          return false;
        }
      } else
        return false;
    } catch (err) {
      print('Failure to save bill in Requests: $err');
      return false;
    }
  }

  requestOutOfStateCongressMen() async {
    try {
      bool cookieReady = await validateCookie();
      if (cookieReady == true) {
        final outCong = await req.get(this.congressmenOutOfStateUrl, headers: {
          'Content-Type': 'application/json',
          'cookie': this.cookie
        });
        if (outCong.statusCode == 200) {
          final data = json.decode(outCong.body);
          return data;
        } else {
          print(
              'request for out of state congressmen failed: ${outCong.statusCode} ${outCong.body}');
          return false;
        }
      } else {
        return false;
      }
    } catch (err) {
      print('Failure to get out of state congressmen $err');
    }
  }

  mostRecentBills(date) async {
    try {
      bool cookieReady = await validateCookie();
      if (cookieReady == true) {
        final billList = await req.get(this.mostRecentlyActedOnBills + date,
            headers: {
              'Content-Type': 'application/json',
              'cookie': this.cookie
            });
        if (billList.statusCode == 200) {
          final data = json.decode(billList.body);
          return data['body'];
        } else {
          print(
              'Failed request for most recently acted on bills ${billList.statusCode} ${billList.body}');
          return false;
        }
      } else {
        return false;
      }
    } catch (err) {
      print('Failure on most recent bill request: $err');
    }
  }

  requestCongressMenInfo() async {
    try {
      bool cookieReady = await this.validateCookie();
      if (cookieReady == true) {
        final cong = await req.get(this.congressmenInfoUrl, headers: {
          'Content-Type': 'application/json',
          'cookie': this.cookie
        });
        if (cong.statusCode == 200) {
          final data = json.decode(cong.body);
          final senators = data['senators'];
          final representatives = data['representatives'];
          return [senators, representatives];
        } else {
          print(
              'request for congressmen failed: ${cong.statusCode} ${cong.body}');
          return false;
        }
      } else {
        return false;
      }
    } catch (err) {
      print('Failure to retrieve congressmen info: $err');
    }
  }

  completeBillDetails(slug, congress) async {
    try {
      bool cookieReady = await this.validateCookie();
      final Map sentData = {'slug': slug, 'congInt': congress.toString()};
      if (cookieReady == true) {
        final billDetails = await req.post(this.billDetailsUrl,
            headers: {'cookie': this.cookie}, body: sentData);
        if (billDetails.statusCode == 200) {
          final Map deets = json.decode(billDetails.body);
          return deets;
        } else {
          print(
              'Request came back with bad status code: ${billDetails.statusCode} ${billDetails.body}');
        }
      } else {
        return false;
      }
    } catch (err) {
      print('Failure to get complete bill details: $err');
    }
  }

  mostRecentVotesBills(date) async {
    try {
      bool cookieReady = await this.validateCookie();
      if (cookieReady == true) {
        final billVotes = await req.get(this.mostRecentlyVotedBills + date,
            headers: {
              "Content-Type": "application/json",
              "cookie": this.cookie
            });
        if (billVotes.statusCode == 200) {
          final Map votes = json.decode(billVotes.body);
          return votes;
        } else {
          print(
              "Request for bill votes came back with a bad status code: ${billVotes.statusCode} ${billVotes.body}");
          if (billVotes.statusCode == 403) {
            print('place to go to login');
          }
        }
      } else {
        return false;
      }
    } catch (err) {
      print('Failure to get most recent Vote bills: $err');
    }
  }

  requestByUrl(url, date) async {
    try {
      bool cookieReady = await this.validateCookie();
      if (cookieReady == true) {
        final dataReq = await req.get(url + date, headers: {
          "Content-Type": "application/json",
          "cookie": this.cookie
        });
        if (dataReq.statusCode == 200) {
          final Map dataArr = json.decode(dataReq.body);
          return dataArr;
        } else {
          print(
              "Failure to get good status code from url request: ${dataReq.body}");
        }
      } else {
        return false;
      }
    } catch (err) {
      print('Failure to process url at validation stage');
    }
  }

  validateCookie() async {
    try {
      final val = await req.get(this.validateCookieUrl,
          headers: {'Content-Type': 'application/json', 'cookie': this.cookie});
      if (val.statusCode == 200) {
        return true;
      } else {
        await this.setNewInfo();
        return await this.login(this.userName, this.pass, null);
      }
    } catch (err) {
      print('Failure in validate cookie function: $err');
      return false;
    }
  }
}
