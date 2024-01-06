import 'package:flutter/material.dart';

class ImageCoordinateDetector {
  Offset _handleTapDown(BuildContext context, TapDownDetails details) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset localPosition = renderBox.globalToLocal(details.globalPosition);

    return localPosition;
  }
}