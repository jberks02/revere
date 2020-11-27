import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../loginComponents/loginButtons.dart';
import './ProPublicaString.dart';

class CreditsContainer extends StatelessWidget {
  String donationLink =
      'https://donate.propublica.org/give/141278/#!/donation/checkout';
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: ImageIcon(AssetImage('assets/ProPublicaLogo.png'),
                  color: Color(0xff195e83), size: 200),
            ),
            Expanded(
              flex: 1,
              child: LoginButton(
                  callback: (con) => {launch(this.donationLink)},
                  txt: 'Go to ProPublica donation page.',
                  ready: true),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  paragraph,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ));
  }
}
