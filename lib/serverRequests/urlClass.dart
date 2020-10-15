import 'package:device_info/device_info.dart';

class UrlContainer {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  bool physicalDevice;
  Map<String, String> urls;
  UrlContainer() {
    iosInitStrut();
  }

  iosInitStrut() async {
    try {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      physicalDevice = iosInfo.isPhysicalDevice;
      if (this.physicalDevice == false) {
        this.urls = {
          'congressmenInfoUrl':
              'http://localhost:8080/Vigil/member/congressmen/info',
          'validateCookieUrl':
              'http://localhost:8080/Vigil/member/validateCookie',
          'congressmenOutOfStateUrl':
              'http://localhost:8080/Vigil/member/congressmen/other',
          'mostRecentlyActedOnBills':
              'http://localhost:8080/Vigil/member/bills/mostRecentActions/',
          'billDetailsUrl': "http://localhost:8080/Vigil/member/bills/details",
          'mostRecentlyVotedBills':
              "http://localhost:8080/Vigil/member/bills/mostRecentVotes/",
          'mostRecentPresStatement':
              "http://localhost:8080/Vigil/member/bills/mostRecentPresidentialStatement/",
        };
      } else {
        this.urls = {
          'congressmenInfoUrl':
              'http://localhost:8080/Vigil/member/congressmen/info',
          'validateCookieUrl':
              'http://localhost:8080/Vigil/member/validateCookie',
          'congressmenOutOfStateUrl':
              'http://localhost:8080/Vigil/member/congressmen/other',
          'mostRecentlyActedOnBills':
              'http://localhost:8080/Vigil/member/bills/mostRecentActions/',
          'billDetailsUrl': "http://localhost:8080/Vigil/member/bills/details",
          'mostRecentlyVotedBills':
              "http://localhost:8080/Vigil/member/bills/mostRecentVotes/",
          'mostRecentPresStatement':
              "http://localhost:8080/Vigil/member/bills/mostRecentPresidentialStatement/",
        };
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
        this.urls = {
          'congressmenInfoUrl':
              'http://localhost:8080/Vigil/member/congressmen/info',
          'validateCookieUrl':
              'http://localhost:8080/Vigil/member/validateCookie',
          'congressmenOutOfStateUrl':
              'http://localhost:8080/Vigil/member/congressmen/other',
          'mostRecentlyActedOnBills':
              'http://localhost:8080/Vigil/member/bills/mostRecentActions/',
          'billDetailsUrl': "http://localhost:8080/Vigil/member/bills/details",
          'mostRecentlyVotedBills':
              "http://localhost:8080/Vigil/member/bills/mostRecentVotes/",
          'mostRecentPresStatement':
              "http://localhost:8080/Vigil/member/bills/mostRecentPresidentialStatement/",
        };
      } else {
        this.urls = {
          'congressmenInfoUrl':
              'http://localhost:8080/Vigil/member/congressmen/info',
          'validateCookieUrl':
              'http://localhost:8080/Vigil/member/validateCookie',
          'congressmenOutOfStateUrl':
              'http://localhost:8080/Vigil/member/congressmen/other',
          'mostRecentlyActedOnBills':
              'http://localhost:8080/Vigil/member/bills/mostRecentActions/',
          'billDetailsUrl': "http://localhost:8080/Vigil/member/bills/details",
          'mostRecentlyVotedBills':
              "http://localhost:8080/Vigil/member/bills/mostRecentVotes/",
          'mostRecentPresStatement':
              "http://localhost:8080/Vigil/member/bills/mostRecentPresidentialStatement/",
        };
        print(urls);
      }
    } catch (err) {
      print('Failure to get android device info $err');
    }
  }
}
