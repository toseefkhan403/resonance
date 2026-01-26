import 'package:flutter/material.dart';
import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/presentation/utils/resonance_colors.dart';
import 'package:resonance_flutter/presentation/widgets/resonance_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class NodeInfoDialog extends StatelessWidget {
  const NodeInfoDialog({
    required this.node,
    this.speakerName,
    super.key,
  });

  final GraphNodeDisplay node;
  final String? speakerName;

  @override
  Widget build(BuildContext context) {
    return ResonanceDialog(
      title: 'Node Info',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Name', node.name),
          const SizedBox(height: 12),
          _buildInfoRow(
            'Primary Speaker',
            speakerName ?? 'ID: ${node.primarySpeakerId}',
          ),
          const SizedBox(height: 12),
          const Text(
            'Summary',
            style: TextStyle(
              color: ResonanceColors.accent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            node.summary,
            style: const TextStyle(
              color: ResonanceColors.textGrey,
              height: 1.4,
            ),
          ),
          if (node.references.isNotEmpty) ...[
            const SizedBox(height: 20),
            const Text(
              'References',
              style: TextStyle(
                color: ResonanceColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: node.references.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final ref = node.references[index];
                  final startTimeInt = ref.startTime;
                  final youtubeUrl =
                      'https://www.youtube.com/watch?v=${node.videoId}&t=$startTimeInt';

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '"${ref.verbatimQuote}"',
                        style: const TextStyle(
                          color: ResonanceColors.textGrey,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      InkWell(
                        onTap: () async {
                          final uri = Uri.parse(youtubeUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.play_circle_outline,
                              size: 16,
                              color: ResonanceColors.accent,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '''Watch at ${formatDuration(Duration(seconds: startTimeInt))}''',
                              style: const TextStyle(
                                color: ResonanceColors.accent,
                                decoration: TextDecoration.underline,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: ResonanceColors.accent,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
