import 'package:flutter/material.dart';

class SpinningLoadIcon extends StatefulWidget {
  @override
  _SpinningLoadIconState createState() => _SpinningLoadIconState();
}

class _SpinningLoadIconState extends State<SpinningLoadIcon>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.center,
      turns: _controller,
      child: Icon(Icons.refresh),
    );
  }
}
