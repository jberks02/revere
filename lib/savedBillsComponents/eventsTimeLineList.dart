import 'package:flutter/material.dart';
import './actionTile.dart';
import './voteTile.dart';

class EventList extends StatelessWidget {
  final List events;
  EventList({@required this.events});
  getWidgetArray() {
    List<Widget> eventList = [];
    events.forEach((event) {
      if (event['action_id'] != null) {
        eventList.add(ActionTile(data: event, middleText: 'Action'));
      } else if (event['vote_id'] != null) {
        eventList.add(VoteTile(data: event));
      } else {
        eventList.add(Text('Presidential Statement'));
      }
    });
    return eventList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getWidgetArray(),
    );
  }
}
