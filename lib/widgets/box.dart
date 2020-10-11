import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final Color color;
  final Widget child;
  final Function onTap;

  Box({
    @required this.color,
    this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        margin: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: this.color,
        ),
        child: this.child,
      ),
    );
  }
}
