import 'package:dikimall/constants/colors.dart';
import 'package:flutter/material.dart';

class BoxShadowContainer extends StatelessWidget {
  final Widget child;
  final num height;
  final num width;
  const BoxShadowContainer({this.child, this.height, this.width});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        boxShadow: [
          BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 5,
              color: miracgolge //Colors.black.withOpacity(0.2),

              )
        ],
      ),
      height: height == null
          ? null //MediaQuery.of(context).size.height
          : height.toDouble(),
      width:
          width == null ? MediaQuery.of(context).size.width : width.toDouble(),
      child: child,
    );
  }
}
