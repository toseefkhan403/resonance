import 'package:flutter/material.dart';
import 'package:resonance_flutter/presentation/widgets/resonance_header.dart';
import 'package:resonance_flutter/presentation/widgets/resonance_sidebar.dart';

class ResonanceLayout extends StatelessWidget {
  const ResonanceLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ResonanceHeader(),
          Expanded(
            child: Row(
              children: [
                const ResonanceSidebar(),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
