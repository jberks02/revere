import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfo extends StatelessWidget {
  final String contactForm;
  final String phone;
  final String office;
  ContactInfo({
    @required this.contactForm,
    @required this.phone,
    @required this.office,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Contact Information",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                InkWell(
                    child: Text(
                      "Online contact form: link",
                    ),
                    onTap: () => launch(this.contactForm)),
                Text("Phone Number: ${this.phone}"),
                Text("Office: ${this.office}")
              ],
            ),
          )
        ],
      ),
    );
  }
}
