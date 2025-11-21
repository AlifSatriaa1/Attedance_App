import 'package:flutter/material.dart';

class RippleAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double minRadius;
  final Color color;
  final int ripplesCount;

  const RippleAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2000),
    this.minRadius = 60,
    this.color = Colors.white,
    this.ripplesCount = 3,
  });

  @override
  State<RippleAnimation> createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ...List.generate(
          widget.ripplesCount,
          (index) => AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final delay = index / widget.ripplesCount;
              final value = (_controller.value + delay) % 1.0;
              
              return Container(
                width: widget.minRadius * (1 + value * 2),
                height: widget.minRadius * (1 + value * 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.color.withOpacity(1 - value),
                    width: 2,
                  ),
                ),
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}
