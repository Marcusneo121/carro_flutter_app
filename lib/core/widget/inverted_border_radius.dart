import 'package:flutter/material.dart';

class CustomCornerClipPath extends CustomClipper<Path> {
  final double cornerR;
  const CustomCornerClipPath({this.cornerR = 16.0});

  @override
  Path getClip(Size size) => Path()
    ..lineTo(size.width, 0)
    ..lineTo(
      size.width,
      size.height - cornerR,
    )
    ..arcToPoint(
      Offset(
        size.width - cornerR,
        size.height,
      ),
      radius: Radius.circular(cornerR),
      clockwise: false,
    )
    ..lineTo(0, size.height);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
