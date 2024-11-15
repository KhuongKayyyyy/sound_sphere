import 'package:flutter/material.dart';

class AutoScrollingText extends StatefulWidget {
  final String text;
  final double width;
  final TextStyle textStyle;

  const AutoScrollingText({
    super.key,
    required this.text,
    required this.width,
    required this.textStyle,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AutoScrollingTextState createState() => _AutoScrollingTextState();
}

class _AutoScrollingTextState extends State<AutoScrollingText>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _startScrolling();
  }

  void _startScrolling() {
    _animationController.repeat();
    _animationController.addListener(() {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.offset + 1,
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        );

        // Reset the scroll position when it reaches the end
        if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(0);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Text(
              widget.text,
              style: widget.textStyle,
            ),
            const SizedBox(width: 50),
            Text(
              widget.text,
              style: widget.textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
