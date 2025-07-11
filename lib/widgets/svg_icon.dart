import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String assetPath;
  final double? size;
  final Color? color;

  const SvgIcon({
    required this.assetPath,
    this.size = 24,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      color: color ?? Theme.of(context).iconTheme.color,
    );
  }
}