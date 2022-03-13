class MassaInfo {
  int? cliqueCount;
  int? currentCycle;
  int? finalBlockCount;
  int? finalOperationCount;
  int? lastPeriod;
  int? nStakers;
  int? staleBlockCount;
  int? timespan;
  String? version;

  MassaInfo(
      {this.cliqueCount,
      this.currentCycle,
      this.finalBlockCount,
      this.finalOperationCount,
      this.lastPeriod,
      this.nStakers,
      this.staleBlockCount,
      this.timespan,
      this.version});

  MassaInfo.decode(Map<String, dynamic> json) {
    cliqueCount = json['clique_count'];
    currentCycle = json['current_cycle'];
    finalBlockCount = json['final_block_count'];
    finalOperationCount = json['final_operation_count'];
    lastPeriod = json['last_period'];
    nStakers = json['n_stakers'];
    staleBlockCount = json['stale_block_count'];
    timespan = json['timespan'];
    version = json['version'];
  }

  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['clique_count'] = cliqueCount;
    data['current_cycle'] = currentCycle;
    data['final_block_count'] = finalBlockCount;
    data['final_operation_count'] = finalOperationCount;
    data['last_period'] = lastPeriod;
    data['n_stakers'] = nStakers;
    data['stale_block_count'] = staleBlockCount;
    data['timespan'] = timespan;
    data['version'] = version;
    return data;
  }
}
