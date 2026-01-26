import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:resonance_flutter/presentation/utils/resonance_colors.dart';
import 'package:resonance_flutter/presentation/widgets/hover_link_text.dart';
import 'package:resonance_flutter/presentation/widgets/resonance_dialog.dart';

class ResonanceHeader extends StatelessWidget {
  const ResonanceHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var location = '';
    try {
      location = GoRouterState.of(context).uri.toString();
    } catch (_) {}

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF333333))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svg/logo.svg',
            width: 28,
            height: 28,
          ),
          const SizedBox(width: 12),
          _title(),
          const Spacer(),
          _buildLinkText(
            'WHAT IS RESONANCE',
            onTap: () {
              // todo_add yt link
              unawaited(
                showDialog<void>(
                  context: context,
                  builder: (context) => const ResonanceDialog(
                    title: 'What is Resonance?',
                    child: Text(
                      '''Resonance extracts structured knowledge from podcasts and organizes it into an interactive graph. Each idea is connected, source-grounded, and queryable, turning passive listening into a durable, explorable knowledge system.''',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
          _buildLinkText(
            'DEMO GRAPH',
            isActive: location == '/demo-graph',
            onTap: () {
              context.go('/demo-graph');
            },
          ),
        ],
      ),
    );
  }

  Widget _title({double fontSize = 24}) => Text(
    'RESONANCE',
    style: TextStyle(
      color: ResonanceColors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: 4,
      shadows: [
        BoxShadow(
          color: ResonanceColors.accent.withValues(alpha: 0.8),
          blurRadius: 8,
        ),
        BoxShadow(
          color: ResonanceColors.accent.withValues(alpha: 0.4),
          blurRadius: 20,
        ),
      ],
    ),
  );

  Widget _buildLinkText(
    String text, {
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HoverLinkText(text: text, onTap: onTap, isActive: isActive),
    );
  }
}
