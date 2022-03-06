class CliquesResponse {
  CliquesResponse({
    required this.blockIds,
    required this.fitness,
    required this.isBlockclique,
  });
  late final List<String> blockIds;
  late final int fitness;
  late final bool isBlockclique;

  CliquesResponse.decode(Map<String, dynamic> json) {
    blockIds = List.castFrom<dynamic, String>(json['block_ids']);
    fitness = json['fitness'];
    isBlockclique = json['is_blockclique'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['block_ids'] = blockIds;
    _data['fitness'] = fitness;
    _data['is_blockclique'] = isBlockclique;
    return _data;
  }
}
