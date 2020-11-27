import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/line_scale_pulse_out_indicator.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Loading(
          indicator: LineScalePulseOutIndicator(),
          size: 100.0,
          color: Colors.deepOrange),
    );
  }
}
