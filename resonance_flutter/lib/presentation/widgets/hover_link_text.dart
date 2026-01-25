// create a clickable text that changes color on hover
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resonance_flutter/presentation/utils/resonance_colors.dart';

class HoverLinkText extends StatefulWidget {
  const HoverLinkText({required this.text, required this.onTap, super.key});

  final String text;
  final VoidCallback onTap;

  @override
  State<HoverLinkText> createState() => _HoverLinkTextState();
}

class _HoverLinkTextState extends State<HoverLinkText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: GoogleFonts.rajdhani(
            color: _isHovered
                ? ResonanceColors.accent
                : ResonanceColors.textGrey,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            fontSize: 12,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
