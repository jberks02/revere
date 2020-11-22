import 'package:flutter/material.dart';

class EventList extends StatelessWidget {
  final List events;
  EventList({@required this.events});
  getWidgetArray() {
    List<Widget> eventList = [];
    events.forEach((event) {
      print(event);
      if (event['action_id'] != null) {
        eventList.add(Text('action butt'));
      } else {
        eventList.add(Text('vote butt'));
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
