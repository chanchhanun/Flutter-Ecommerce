import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingImage extends StatelessWidget {
  LoadingImage({super.key, required this.height, required this.color});

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: color,
      child: Container(
        height: height,
        decoration: BoxDecoration(color: Colors.black),
      ),
    );
  }
}
