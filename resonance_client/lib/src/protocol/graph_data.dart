/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'graph_node.dart' as _i2;
import 'graph_link.dart' as _i3;
import 'package:resonance_client/src/protocol/protocol.dart' as _i4;

abstract class GraphData implements _i1.SerializableModel {
  GraphData._({
    required this.nodes,
    required this.links,
  });

  factory GraphData({
    required List<_i2.GraphNode> nodes,
    required List<_i3.GraphLink> links,
  }) = _GraphDataImpl;

  factory GraphData.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphData(
      nodes: _i4.Protocol().deserialize<List<_i2.GraphNode>>(
        jsonSerialization['nodes'],
      ),
      links: _i4.Protocol().deserialize<List<_i3.GraphLink>>(
        jsonSerialization['links'],
      ),
    );
  }

  /// All nodes in the graph
  List<_i2.GraphNode> nodes;

  /// All links in the graph
  List<_i3.GraphLink> links;

  /// Returns a shallow copy of this [GraphData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphData copyWith({
    List<_i2.GraphNode>? nodes,
    List<_i3.GraphLink>? links,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphData',
      'nodes': nodes.toJson(valueToJson: (v) => v.toJson()),
      'links': links.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GraphDataImpl extends GraphData {
  _GraphDataImpl({
    required List<_i2.GraphNode> nodes,
    required List<_i3.GraphLink> links,
  }) : super._(
         nodes: nodes,
         links: links,
       );

  /// Returns a shallow copy of this [GraphData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphData copyWith({
    List<_i2.GraphNode>? nodes,
    List<_i3.GraphLink>? links,
  }) {
    return GraphData(
      nodes: nodes ?? this.nodes.map((e0) => e0.copyWith()).toList(),
      links: links ?? this.links.map((e0) => e0.copyWith()).toList(),
    );
  }
}
