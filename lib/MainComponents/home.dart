import 'package:flutter/material.dart';
import '../serverRequests/dataRequests.dart';
import '../homePagecomponents/CongressmanCard.dart';
import '../homePagecomponents/cardListBanner.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool loadingLocalCongressMen = true;
  bool loadingMostRecentBills = true;
  bool loadingOutOfStateCong = true;
  final requestTools = Requests();
  List localCongMen;
  List allCongMen = [];
  Map outerCongMen = {'senators': [], 'representatives': []};
  _MainPageState() {
    this.retrieveCongMen();
  }
  retrieveCongMen() async {
    try {
      this.localCongMen = await this.requestTools.requestCongressMenInfo();
      this.loadingLocalCongressMen = false;
      allCongMen.add({
        "CongCongressTitle": 'Your U.S Senators',
        'color': Color(0xff0040ad)
      });
      for (var loc in this.localCongMen[0]) {
        allCongMen.add(loc);
      }
      allCongMen.add({
        "CongCongressTitle": 'Your U.S Representatives',
        'color': Color(0xffbf0d1f)
      });
      for (var loc in this.localCongMen[1]) {
        allCongMen.add(loc);
      }
      this.setState(() {});
      this.outerCongMen =
          await this.requestTools.requestOutOfStateCongressMen();
      allCongMen.add(
          {"CongCongressTitle": 'U.S Senators', 'color': Color(0xff0040ad)});
      for (var loc in this.outerCongMen['senators']) allCongMen.add(loc);
      allCongMen.add({
        "CongCongressTitle": 'U.S Representatives',
        'color': Color(0xffbf0d1f)
      });
      for (var loc in this.outerCongMen['representatives']) allCongMen.add(loc);
      this.setState(() {});
    } catch (err) {
      print('Failure in retriveCongMen method of the MainPage class: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    // for (var info in this.outerCongMen['representatives']) print(info);
    // print('break');
    if (this.allCongMen == null) {
      return Text('loading...');
    } else {
      return ListView.builder(
          itemCount: allCongMen.length,
          itemBuilder: (context, index) {
            // print(this.localCongMen[1][index]);
            if (allCongMen[index]['CongCongressTitle'] != null)
              return CongBanner(info: allCongMen[index]);
            else
              return CongressManCard(info: allCongMen[index]);
          });
    }
  }
}
