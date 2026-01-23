import 'package:flutter/material.dart';
import 'package:graphify/graphify.dart'; // Keep this import as it is used
import 'package:resonance_client/resonance_client.dart';
import 'package:resonance_flutter/main.dart'; // Access to global client

class ForceDirectedGraphScreen extends StatefulWidget {
  const ForceDirectedGraphScreen({super.key});

  @override
  State<ForceDirectedGraphScreen> createState() =>
      _ForceDirectedGraphScreenState();
}

class _ForceDirectedGraphScreenState extends State<ForceDirectedGraphScreen> {
  // Data State
  GraphData? _graphData;
  List<Speaker>? _speakers;
  bool _isLoading = true;
  String? _error;

  // Chat State
  Speaker? _selectedSpeaker;
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isStreaming = false;
  int _currentGranularityIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Parallel fetch
      final results = await Future.wait([
        client.graph.getGraphData(),
        client.conversation.listSpeakers(),
      ]);

      if (mounted) {
        final data = results[0] as GraphData;
        setState(() {
          _graphData = data;
          _speakers = results[1] as List<Speaker>;
          if (data.graphWithGranularity.isNotEmpty) {
            _currentGranularityIndex = data.graphWithGranularity.length - 1;
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _cycleGranularity() {
    if (_graphData == null || _graphData!.graphWithGranularity.isEmpty) return;
    setState(() {
      _currentGranularityIndex =
          (_currentGranularityIndex + 1) %
          _graphData!.graphWithGranularity.length;
    });
  }

  Future<void> _sendMessage() async {
    final text = _chatController.text.trim();
    if (text.isEmpty || _selectedSpeaker == null || _isStreaming) return;

    _chatController.clear();
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isStreaming = true;
      // Add placeholder for bot response
      _messages.add(ChatMessage(text: '', isUser: false));
    });
    _scrollToBottom();

    try {
      final stream = client.conversation.askQuestion(
        text,
        _selectedSpeaker!,
      );

      await for (var chunk in stream) {
        if (mounted) {
          setState(() {
            final lastMsg = _messages.last;
            lastMsg.text += chunk;
          });
          _scrollToBottom();
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add(ChatMessage(text: 'Error: $e', isUser: false));
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isStreaming = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Map<String, dynamic> _buildChartOptions() {
    if (_graphData == null || _graphData!.graphWithGranularity.isEmpty) {
      return {};
    }

    // Use the current granular level
    final index = _currentGranularityIndex.clamp(
      0,
      _graphData!.graphWithGranularity.length - 1,
    );
    final graph = _graphData!.graphWithGranularity[index].graph;

    final categories = graph.categories.map((c) => {'name': c.name}).toList();

    final nodes = graph.nodes.asMap().entries.map((entry) {
      final index = entry.key;
      final n = entry.value;
      return {
        // 'id': n.nodeId,
        'id': index,
        'name': n.name,
        'value': n.value,
        'category': n.category,
        'symbolSize': n.symbolSize,
        // Optional: pass other metadata if needed for tooltips
        'videoId': n.videoId,
        'summary': n.summary,
      };
    }).toList();

    final links = graph.links.map((l) {
      return {
        'source': l.source,
        'target': l.target,
      };
    }).toList();

    return {
      'legend': {
        'data': categories.map((c) => c['name']).toList(),
        'orient': 'vertical',
        'left': 'left',
      },
      'tooltip': {},
      'series': [
        {
          'type': 'graph',
          'layout': 'force',
          'animation': true,
          'label': {'position': 'right', 'formatter': '{b}'},
          'draggable': true,
          'data': nodes,
          'categories': categories,
          'force': {
            'edgeLength': 50,
            'repulsion': 100,
            'gravity': 0.1,
          },
          'edges': links,
          'roam': true,
          'lineStyle': {
            'color': 'source',
            'curveness': 0.3,
          },
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(child: Text('Error: $_error')),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          // Left Panel: Graph
          Expanded(
            flex: 3,
            child: ColoredBox(
              color: const Color(0xff100c2a),
              child: GraphifyView(
                // Force rebuild/update when granularity changes
                key: ValueKey('graph_$_currentGranularityIndex'),
                controller: GraphifyController(),
                initialOptions: _buildChartOptions(),
              ),
            ),
          ),
          // Divider
          Container(width: 1, color: Colors.grey[300]),
          // Right Panel: Chat & Speakers
          Expanded(
            flex: 1,
            child: Column(
              children: [
                if ((_graphData?.graphWithGranularity.length ?? 0) > 1)
                  FloatingActionButton.extended(
                    label: const Text('Cycle Granularity'),
                    icon: const Icon(Icons.grain),
                    onPressed: _cycleGranularity,
                  ),
                _buildSpeakerList(),
                const Divider(height: 1),
                _buildChatArea(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeakerList() {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select Speaker',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: _speakers == null || _speakers!.isEmpty
                ? const Center(child: Text('No speakers found'))
                : ListView.builder(
                    itemCount: _speakers!.length,
                    itemBuilder: (context, index) {
                      final speaker = _speakers![index];
                      return RadioListTile<Speaker>(
                        title: Text(speaker.name),
                        value: speaker,
                        groupValue: _selectedSpeaker,
                        onChanged: (Speaker? value) {
                          setState(() {
                            _selectedSpeaker = value;
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatArea() {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8),
                    constraints: const BoxConstraints(maxWidth: 240),
                    decoration: BoxDecoration(
                      color: msg.isUser
                          ? Theme.of(context).primaryColor.withOpacity(0.1)
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg.text),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    enabled: !_isStreaming && _selectedSpeaker != null,
                    decoration: const InputDecoration(
                      hintText: 'Ask a question...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: _isStreaming
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.send),
                  onPressed: _isStreaming || _selectedSpeaker == null
                      ? null
                      : _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
