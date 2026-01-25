import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resonance_flutter/presentation/utils/resonance_colors.dart';

class ResonanceSidebar extends StatelessWidget {
  const ResonanceSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Container(
      width: 70,
      decoration: const BoxDecoration(
        border: Border(right: BorderSide(color: Color(0xFF333333))),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _SidebarButton(
            icon: Icons.podcasts,
            tooltip: 'Add Podcast',
            isActive: location == '/home',
            onTap: () => context.go('/home'),
          ),
          const SizedBox(height: 20),
          _SidebarButton(
            icon: Icons.hub,
            tooltip: 'View Graph',
            isActive: location == '/graph',
            onTap: () => context.go('/graph'),
          ),
          const SizedBox(height: 20),
          _SidebarButton(
            icon: Icons.list_outlined,
            tooltip: 'List Podcasts',
            onTap: () {
              unawaited(
                showDialog<void>(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('List Podcasts'),
                    content: Text(
                      'List of podcasts',
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          _SidebarButton(
            icon: Icons.save_alt,
            tooltip: 'Saves',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Save feature coming soon')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SidebarButton extends StatefulWidget {
  const _SidebarButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  final bool isActive;

  @override
  State<_SidebarButton> createState() => _SidebarButtonState();
}

class _SidebarButtonState extends State<_SidebarButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isActive || _isHovering;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected
                  ? ResonanceColors.accent.withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: isSelected ? ResonanceColors.accent : Colors.transparent,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: ResonanceColors.accent.withValues(alpha: 0.2),
                        blurRadius: 8,
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              widget.icon,
              size: 20,
              color: isSelected
                  ? ResonanceColors.accent
                  : ResonanceColors.accentDark,
            ),
          ),
        ),
      ),
    );
  }
}
