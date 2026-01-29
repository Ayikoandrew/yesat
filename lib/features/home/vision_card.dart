import 'package:flutter/material.dart';
import 'package:yesat/core/theme.dart';

class VisionCard extends StatefulWidget {
  final VisionCard vision;
  const VisionCard({super.key, required this.vision});

  @override
  State<VisionCard> createState() => _VisionCardState();
}

class _VisionCardState extends State<VisionCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        isHovered = true;
      }),
      onExit: (_) => setState(() {
        isHovered = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isHovered ? Colors.white : WebTheme.creamSurface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
          border: Border.all(
            color: isHovered
                ? WebTheme.darkText.withValues(alpha: 0.1)
                : Colors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: WebTheme.creamBackground,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
