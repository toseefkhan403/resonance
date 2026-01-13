import 'package:flutter/material.dart';
import 'package:graphify/graphify.dart';

class GraphWebkitDep extends StatelessWidget {
  const GraphWebkitDep({super.key});

  static final webkitDep = {
    "type": "force",
    "categories": [
      {
        "name": "Lifestyle",
        "keyword": {},
        "base": "Lifestyle Base",
        "itemStyle": {"color": "#ffffff"},
      },
      {"name": "Philosophy", "keyword": {}, "base": "Philosophy Base"},
      {"name": "Money", "keyword": {}, "base": "Money Base"},
      {"name": "AI", "keyword": {}, "base": "AI Base"},
      {"name": "Other", "keyword": {}, "base": "Other Base"},
    ],
    "nodes": [
      {"name": "Lifestyle Base", "value": 3, "category": 0, "symbolSize": 20},
      {
        "name": "Daily Habits",
        "category": 0,
        "x": 212.76357,
        "y": 245.29176,
        "value": 9.485714,
        "symbolSize": 20,
      },
      {"name": "Health & Fitness", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Lifestyle Base", "value": 3, "category": 0},
      {"name": "Daily Habits", "value": 1, "category": 0},
      {"name": "Health & Fitness", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},
      {"name": "Minimalism", "value": 1, "category": 0},

      {"name": "Philosophy Base", "value": 6, "category": 1},
      {"name": "Stoicism", "value": 3, "category": 1},
      {"name": "Purpose of Life", "value": 4, "category": 1},
      {"name": "Decision Making", "value": 2, "category": 1},

      {"name": "Money Base", "value": 6, "category": 2},
      {"name": "Investing", "value": 4, "category": 2},
      {"name": "Personal Finance", "value": 3, "category": 2},
      {"name": "Financial Freedom", "value": 5, "category": 2},

      {"name": "AI Base", "value": 6, "category": 3},
      {"name": "Machine Learning", "value": 4, "category": 3},
      {"name": "Generative AI", "value": 5, "category": 3},
      {"name": "Automation", "value": 3, "category": 3},

      {"name": "Other Base", "value": 4, "category": 4},
      {"name": "Books", "value": 2, "category": 4},
      {"name": "Travel", "value": 2, "category": 4},
    ],
    "links": [
      {"source": 0, "target": 1},
      {"source": 0, "target": 2},
      {"source": 0, "target": 3},
      {"source": 0, "target": 4},
      {"source": 0, "target": 5},
      {"source": 0, "target": 6},
      {"source": 0, "target": 7},
      {"source": 0, "target": 8},
      {"source": 0, "target": 9},
      {"source": 0, "target": 10},
      {"source": 0, "target": 11},
      {"source": 0, "target": 12},
      {"source": 0, "target": 13},
      {"source": 0, "target": 14},
      {"source": 0, "target": 15},
      {"source": 0, "target": 16},
      {"source": 0, "target": 17},
      {"source": 0, "target": 18},
      {"source": 0, "target": 19},

      {"source": 8, "target": 9},
      {"source": 8, "target": 10},
      {"source": 8, "target": 11},

      {"source": 12, "target": 13},
      {"source": 12, "target": 14},
      {"source": 12, "target": 15},

      {"source": 16, "target": 17},
      {"source": 16, "target": 18},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return GraphifyView(
      controller: GraphifyController(),
      initialOptions: {
        'legend': const {
          'data': ['Lifestyle', 'Philosophy', 'Money', 'AI', 'Other'],
        },
        'series': [
          {
            'type': 'graph',
            'layout': 'force',
            'animation': false,
            'label': const {'position': 'right', 'formatter': '{b}'},
            'draggable': true,
            'data': (webkitDep['nodes'] as List).asMap().entries.map((entry) {
              var node = entry.value;
              node['id'] = entry.key;
              return node;
            }).toList(),
            'categories': webkitDep['categories'],
            'force': const {'edgeLength': 50, 'repulsion': 20, 'gravity': 0.2},
            'edges': webkitDep['links'],
            'roam': true,
          },
        ],
      },
      onChartClick: (chartId, eventData) {
        // Handle click events
        debugPrint('Dart Chart clicked: $eventData');

        if (eventData['dataType'] == 'node') {
          final nodeData = eventData['data'] as Map<String, dynamic>?;
          if (nodeData != null) {
            // todo
          }
        } else if (eventData['dataType'] == 'edge') {
          final edgeData = eventData['data'] as Map<String, dynamic>?;
          if (edgeData != null) {
            // todo
          }
        }
      },
      onChartHover: (chartId, eventData) {
        debugPrint('Dart Chart hover: $eventData');
        if (eventData['dataType'] == 'node') {
          final nodeData = eventData['data'] as Map<String, dynamic>?;
          if (nodeData != null) {}
        }
      },
      onChartHoverOut: (chartId, eventData) {
        // Handle hover out events
        debugPrint('Dart Chart hover out: $eventData');
        if (eventData['dataType'] == 'node') {
          final nodeData = eventData['data'] as Map<String, dynamic>?;
          if (nodeData != null) {}
        }
      },
    );
  }
}
