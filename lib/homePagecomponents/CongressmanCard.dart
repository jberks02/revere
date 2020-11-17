import 'dart:collection';
import 'package:flutter/material.dart';
import '../homePagecomponents/cardTopRow.dart';
import '../homePagecomponents/voteAndSocMedia.dart';
import '../homePagecomponents/cardContactInfo.dart';

class CongressManCard extends StatelessWidget {
  final LinkedHashMap info;
  CongressManCard({@required this.info});
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width;
    // print(this.info);
    return Container(
      width: cWidth,
      height: 400,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFF1D1E33),
        border: Border.all(width: 2, color: Colors.black54),
      ),
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BasicInfo(
              fullName: this.info['full_name'],
              title: this.info['title'],
              gender: this.info['gender'],
              nextElectionYear: this.info['next_election'],
              memberUrl: this.info['member_url'],
              party: this.info['party'],
              state: this.info['state']),
          VoteAndSocialMedia(
            totalVotes: this.info['total_votes_made'],
            missedVotes: this.info['missed_votes'],
            votesInPartyAlignment:
                this.info['vote_percentage_in_party_alignment'],
            facebook: this.info['facebook'],
            twitter: this.info['twitter'],
            youtube: this.info['youtube'],
          ),
          ContactInfo(
            contactForm: this.info['contact_form'],
            phone: this.info['phone'],
            office: this.info['office'],
          ),
        ],
      ),
    );
  }
}

// Text(
//             this.info['title'],
//             textAlign: TextAlign.center,
//           ),
