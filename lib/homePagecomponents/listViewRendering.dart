import 'package:flutter/material.dart';
import '../homePagecomponents/CongressmanCard.dart';

class ListViewRenderingTool extends StatelessWidget {
  final bulk;
  ListViewRenderingTool({@required this.bulk});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: this.bulk.length,
        itemBuilder: (context, index) {
          // print(this.localCongMen[1][index]);
          return CongressManCard(info: this.bulk[index]);
        });
  }
}
