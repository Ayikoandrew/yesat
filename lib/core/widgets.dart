import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  final Widget Function(BuildContext, bool) builder;
  final double threshold;

  const ScrollReveal({super.key, required this.builder, this.threshold = 0.15});

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _isVisible = false;
  late final Key _visibilityKey;

  @override
  void initState() {
    super.initState();
    _visibilityKey = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _visibilityKey,
      onVisibilityChanged: (info) {
        if (info.visibleFraction > widget.threshold) {
          if (!_isVisible && mounted) {
            setState(() => _isVisible = true);
          }
        } else if (info.visibleFraction <= 0.01) {
          if (_isVisible && mounted) {
            setState(() => _isVisible = false);
          }
        }
      },
      child: widget.builder(context, _isVisible),
    );
  }
}
