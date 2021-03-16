import 'package:flutter/material.dart';

class StyleButton extends StatelessWidget {
  final Function? onTap;
  final double? width;
  final double? height;
  final Widget? child;

  StyleButton({this.onTap, this.width, this.height, this.child});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: onTap as void Function()?,
        child: Container(
          width: width,
          height: height,
          child: child,
        ),
      ),
    );
  }
}
