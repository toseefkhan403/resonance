import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_indicator/live_indicator.dart';
import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/application/serverpod_client.dart';
import 'package:resonance_flutter/constants.dart';
import 'package:resonance_flutter/presentation/utils/resonance_colors.dart';
import 'package:resonance_flutter/presentation/utils/url_launcher.dart';
import 'package:resonance_flutter/presentation/widgets/animated_background.dart';
import 'package:resonance_flutter/presentation/widgets/cyberpunk_button.dart';
import 'package:resonance_flutter/presentation/widgets/hover_link_text.dart';
import 'package:resonance_flutter/presentation/widgets/resonance_header.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(serverpodClientProvider);

    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: Column(
            children: [
              const ResonanceHeader(),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),
                          _buildStatusBar(),
                          const SizedBox(height: 20),
                          _title(fontSize: 64),
                          const SizedBox(height: 10),
                          _buildSubtitle(),
                          const SizedBox(height: 60),
                          _buildLoginCard(context, client),
                          const SizedBox(height: 60),
                          _buildFooterStatus(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title({double fontSize = 24}) => AutoSizeText(
    'RESONANCE',
    maxLines: 1,
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

  Widget _buildLinkText(String text, {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: HoverLinkText(text: text, onTap: onTap),
    );
  }

  Widget _buildStatusBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF330000)),
        color: const Color(0xFF1A0505),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LiveIndicator(
            color: ResonanceColors.accent,
            spreadRadius: 5,
            waitDuration: Durations.long1,
          ),
          const SizedBox(width: 10),
          Flexible(
            child: AutoSizeText(
              'KNOWLEDGE GRAPH BUILDER',
              maxLines: 1,
              style: GoogleFonts.robotoMono(
                color: ResonanceColors.accent,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return AutoSizeText(
      '''Turn podcasts into structured knowledge graphs you can search, explore, and recall.'''
          .toUpperCase(),
      textAlign: TextAlign.center,
      maxLines: 2,
      style: GoogleFonts.rajdhani(
        color: ResonanceColors.accent,
        fontSize: 14,
        letterSpacing: 2,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildLoginCard(BuildContext context, Client client) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: ResonanceColors.primary.withValues(alpha: 0.6),
        border: Border.all(
          color: ResonanceColors.accentDark.withValues(alpha: 0.7),
        ),
      ),
      child: Stack(
        children: [
          // Corner accents
          Positioned(
            top: 0,
            left: 0,
            child: _buildCorner(isTop: true, isLeft: true),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: _buildCorner(isTop: false, isLeft: false),
          ),

          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                const AutoSizeText(
                  'ACCESS THE GRAPH',
                  maxLines: 1,
                  style: TextStyle(
                    color: ResonanceColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                AutoSizeText(
                  'AUTHORIZE CREDENTIALS TO INITIATE KNOWLEDGE MAPPING',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: GoogleFonts.rajdhani(
                    color: ResonanceColors.textGrey,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                GoogleSignInWidget(
                  client: client,
                  // need to pass empty scopes to avoid double popup issue
                  scopes: const [],
                  buttonWrapper:
                      ({
                        required child,
                        required onPressed,
                        required style,
                      }) => Stack(
                        children: [
                          Opacity(
                            opacity: 0.01,
                            child: child,
                          ),
                          CyberpunkButton(
                            onPressed: onPressed,
                            text: 'LOGIN WITH GOOGLE',
                            icon: Icons.g_mobiledata,
                          ),
                        ],
                      ),
                  onError: (error) {
                    debugPrint(error.toString());
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $error')),
                    );
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: ResonanceColors.accentDarker,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: GoogleFonts.rajdhani(
                          color: ResonanceColors.accentDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: ResonanceColors.accentDarker,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                CyberpunkButton(
                  onPressed: () {
                    context.go('/demo-graph');
                  },
                  text: 'EXPLORE DEMO GRAPH',
                  icon: Icons.grid_goldenratio,
                  isPrimary: false,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCorner({required bool isTop, required bool isLeft}) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        border: Border(
          top: isTop
              ? const BorderSide(color: Colors.redAccent, width: 2)
              : BorderSide.none,
          bottom: !isTop
              ? const BorderSide(color: Colors.redAccent, width: 2)
              : BorderSide.none,
          left: isLeft
              ? const BorderSide(color: Colors.redAccent, width: 2)
              : BorderSide.none,
          right: !isLeft
              ? const BorderSide(color: Colors.redAccent, width: 2)
              : BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildFooterStatus() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF111111))),
          ),
          child: Row(
            mainAxisAlignment: isSmallScreen
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (!isSmallScreen) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BUILT WITH',
                      style: GoogleFonts.rajdhani(
                        color: ResonanceColors.accent,
                        fontSize: 10,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'SERVERPOD & FLUTTER',
                      style: GoogleFonts.shareTechMono(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
              _buildLinkText(
                'VIEW ON GITHUB',
                onTap: () {
                  unawaited(
                    UrlLauncher.launchURLNewTab(ResonanceConstants.githubUrl),
                  );
                },
              ),
              _buildLinkText(
                'VIEW ON DEVPOST',
                onTap: () {
                  unawaited(
                    UrlLauncher.launchURLNewTab(ResonanceConstants.devpostUrl),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
