import 'package:flutter/material.dart';

class ContextMenuDivider extends StatelessWidget {
  final int width;
  const ContextMenuDivider({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: width.toDouble(),
      color: Colors.grey.withOpacity(0.1),
    );
  }
}
