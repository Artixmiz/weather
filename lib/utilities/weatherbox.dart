import 'package:flutter/material.dart';

class WeatherBox extends StatelessWidget {
  const WeatherBox({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 100,
    );
  }
}
