import 'package:device_info/device_info.dart';

class UrlContainer {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  bool physicalDevice;
  String congressmenInfoUrl =
      'http://localhost:8080/Vigil/member/congressmen/info';
  String validateCookieUrl =
      'http://localhost:8080/Vigil/member/validateCookie';
  String congressmenOutOfStateUrl =
      'http://localhost:8080/Vigil/member/congressmen/other';
  String mostRecentlyActedOnBills =
      'http://localhost:8080/Vigil/member/bills/mostRecentActions/';
  String billDetailsUrl = "http://localhost:8080/Vigil/member/bills/details";
  String mostRecentlyVotedBills =
      "http://localhost:8080/Vigil/member/bills/mostRecentVotes/";
  String mostRecentPresStatement =
      "http://localhost:8080/Vigil/member/bills/mostRecentPresidentialStatement/";
  String deleteUserFavorite =
      'http://localhost:8080/Vigil/member/userPreferences/delete/favorite';
  String updateUserFavorite =
      'http://localhost:8080/Vigil/member/userPreferences/save/favorite';
  String updateUserVoteAddress =
      "http://localhost:8080/Vigil/member/userPreferences/update/vote";
  iosInitStrut() async {
    try {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      physicalDevice = iosInfo.isPhysicalDevice;
      if (this.physicalDevice == false) {
        print('ios is not physical');
        this.congressmenInfoUrl =
            'http://localhost:8080/Vigil/member/congressmen/info';
        this.validateCookieUrl =
            'http://localhost:8080/Vigil/member/validateCookie';
        this.congressmenOutOfStateUrl =
            'http://localhost:8080/Vigil/member/congressmen/other';
        this.mostRecentlyActedOnBills =
            'http://localhost:8080/Vigil/member/bills/mostRecentActions/';
        this.billDetailsUrl =
            "http://localhost:8080/Vigil/member/bills/details";
        this.mostRecentlyVotedBills =
            "http://localhost:8080/Vigil/member/bills/mostRecentVotes/";
        this.mostRecentPresStatement =
            "http://localhost:8080/Vigil/member/bills/mostRecentPresidentialStatement/";
        this.deleteUserFavorite =
            'localhost:8080/Vigil/member/userPreferences/delete/favorite';
        this.updateUserFavorite =
            'localhost:8080/Vigil/member/userPreferences/save/favorite';
      } else {
        this.congressmenInfoUrl =
            'http://192.168.0.2:8080/Vigil/member/congressmen/info';
        this.validateCookieUrl =
            'http://192.168.0.2:8080/Vigil/member/validateCookie';
        this.congressmenOutOfStateUrl =
            'http://192.168.0.2:8080/Vigil/member/congressmen/other';
        this.mostRecentlyActedOnBills =
            'http://192.168.0.2:8080/Vigil/member/bills/mostRecentActions/';
        this.billDetailsUrl =
            "http://192.168.0.2:8080/Vigil/member/bills/details";
        this.mostRecentlyVotedBills =
            "http://192.168.0.2:8080/Vigil/member/bills/mostRecentVotes/";
        this.mostRecentPresStatement =
            "http://192.168.0.2:8080/Vigil/member/bills/mostRecentPresidentialStatement/";
        this.deleteUserFavorite =
            'localhost:8080/Vigil/member/userPreferences/delete/favorite';
        this.updateUserFavorite =
            'localhost:8080/Vigil/member/userPreferences/save/favorite';
      }
    } catch (err) {
      print('Failure to get IOS device info Attempting Android Init');
      this.androidInitStrut();
    }
  }

  androidInitStrut() async {
    try {
      AndroidDeviceInfo andInfo = await deviceInfo.androidInfo;
      physicalDevice = andInfo.isPhysicalDevice;
      if (this.physicalDevice == false) {
        this.congressmenInfoUrl =
            'http://localhost:8080/Vigil/member/congressmen/info';
        this.validateCookieUrl =
            'http://localhost:8080/Vigil/member/validateCookie';
        this.congressmenOutOfStateUrl =
            'http://localhost:8080/Vigil/member/congressmen/other';
        this.mostRecentlyActedOnBills =
            'http://localhost:8080/Vigil/member/bills/mostRecentActions/';
        this.billDetailsUrl =
            "http://localhost:8080/Vigil/member/bills/details";
        this.mostRecentlyVotedBills =
            "http://localhost:8080/Vigil/member/bills/mostRecentVotes/";
        this.mostRecentPresStatement =
            "http://localhost:8080/Vigil/member/bills/mostRecentPresidentialStatement/";
        this.deleteUserFavorite =
            'localhost:8080/Vigil/member/userPreferences/delete/favorite';
        this.updateUserFavorite =
            'localhost:8080/Vigil/member/userPreferences/save/favorite';
      } else {
        this.congressmenInfoUrl =
            'http://localhost:8080/Vigil/member/congressmen/info';
        this.validateCookieUrl =
            'http://localhost:8080/Vigil/member/validateCookie';
        this.congressmenOutOfStateUrl =
            'http://localhost:8080/Vigil/member/congressmen/other';
        this.mostRecentlyActedOnBills =
            'http://localhost:8080/Vigil/member/bills/mostRecentActions/';
        this.billDetailsUrl =
            "http://localhost:8080/Vigil/member/bills/details";
        this.mostRecentlyVotedBills =
            "http://localhost:8080/Vigil/member/bills/mostRecentVotes/";
        this.mostRecentPresStatement =
            "http://localhost:8080/Vigil/member/bills/mostRecentPresidentialStatement/";
        this.deleteUserFavorite =
            'localhost:8080/Vigil/member/userPreferences/delete/favorite';
        this.updateUserFavorite =
            'localhost:8080/Vigil/member/userPreferences/save/favorite';
      }
    } catch (err) {
      print('Failure to get android device info');
    }
  }
}
