class StatusResponse {
  StatusResponse({
    required this.config,
    required this.connectedNodes,
    required this.consensusStats,
    required this.currentCycle,
    required this.currentTime,
    required this.lastSlot,
    required this.networkStats,
    required this.nextSlot,
    required this.nodeId,
    required this.nodeIp,
    required this.poolStats,
    required this.version,
  });
  late final Config config;
  //late final ConnectedNodes connectedNodes;
  late final Map<dynamic, dynamic> connectedNodes;
  late final ConsensusStats consensusStats;
  late final int currentCycle;
  late final int currentTime;
  late final LastSlot lastSlot;
  late final NetworkStats networkStats;
  late final NextSlot nextSlot;
  late final String nodeId;
  late final String nodeIp;
  late final PoolStats poolStats;
  late final String version;

  StatusResponse.decode(Map<String, dynamic> json) {
    config = Config.decode(json['config']);
    connectedNodes = json['connected_nodes'];
    consensusStats = ConsensusStats.decode(json['consensus_stats']);
    currentCycle = json['current_cycle'];
    currentTime = json['current_time'];
    lastSlot = LastSlot.decode(json['last_slot']);
    networkStats = NetworkStats.decode(json['network_stats']);
    nextSlot = NextSlot.decode(json['next_slot']);
    nodeId = json['node_id'];
    nodeIp = json['node_ip'];
    poolStats = PoolStats.decode(json['pool_stats']);
    version = json['version'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['config'] = config.encode();
    _data['connected_nodes'] = connectedNodes;
    _data['consensus_stats'] = consensusStats.encode();
    _data['current_cycle'] = currentCycle;
    _data['current_time'] = currentTime;
    _data['last_slot'] = lastSlot.encode();
    _data['network_stats'] = networkStats.encode();
    _data['next_slot'] = nextSlot.encode();
    _data['node_id'] = nodeId;
    _data['node_ip'] = nodeIp;
    _data['pool_stats'] = poolStats.encode();
    _data['version'] = version;
    return _data;
  }
}

class Config {
  Config({
    required this.blockReward,
    required this.deltaF0,
    required this.endTimestamp,
    required this.genesisTimestamp,
    required this.maxBlockSize,
    required this.operationValidityPeriods,
    required this.periodsPerCycle,
    required this.posLockCycles,
    required this.posLookbackCycles,
    required this.rollPrice,
    required this.t0,
    required this.threadCount,
  });
  late final String blockReward;
  late final int deltaF0;
  late final int endTimestamp;
  late final int genesisTimestamp;
  late final int maxBlockSize;
  late final int operationValidityPeriods;
  late final int periodsPerCycle;
  late final int posLockCycles;
  late final int posLookbackCycles;
  late final int rollPrice;
  late final int t0;
  late final int threadCount;

  Config.decode(Map<String, dynamic> json) {
    blockReward = json['block_reward'];
    deltaF0 = json['delta_f0'];
    endTimestamp = json['end_timestamp'];
    genesisTimestamp = json['genesis_timestamp'];
    maxBlockSize = json['max_block_size'];
    operationValidityPeriods = json['operation_validity_periods'];
    periodsPerCycle = json['periods_per_cycle'];
    posLockCycles = json['pos_lock_cycles'];
    posLookbackCycles = json['pos_lookback_cycles'];
    rollPrice = int.parse(json['roll_price']);
    t0 = json['t0'];
    threadCount = json['thread_count'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['block_reward'] = blockReward;
    _data['delta_f0'] = deltaF0;
    _data['end_timestamp'] = endTimestamp;
    _data['genesis_timestamp'] = genesisTimestamp;
    _data['max_block_size'] = maxBlockSize;
    _data['operation_validity_periods'] = operationValidityPeriods;
    _data['periods_per_cycle'] = periodsPerCycle;
    _data['pos_lock_cycles'] = posLockCycles;
    _data['pos_lookback_cycles'] = posLookbackCycles;
    _data['roll_price'] = rollPrice;
    _data['t0'] = t0;
    _data['thread_count'] = threadCount;
    return _data;
  }
}

class ConsensusStats {
  ConsensusStats({
    required this.cliqueCount,
    required this.endTimespan,
    required this.finalBlockCount,
    required this.finalOperationCount,
    required this.stakerCount,
    required this.staleBlockCount,
    required this.startTimespan,
  });
  late final int cliqueCount;
  late final int endTimespan;
  late final int finalBlockCount;
  late final int finalOperationCount;
  late final int stakerCount;
  late final int staleBlockCount;
  late final int startTimespan;

  ConsensusStats.decode(Map<String, dynamic> json) {
    cliqueCount = json['clique_count'];
    endTimespan = json['end_timespan'];
    finalBlockCount = json['final_block_count'];
    finalOperationCount = json['final_operation_count'];
    stakerCount = json['staker_count'];
    staleBlockCount = json['stale_block_count'];
    startTimespan = json['start_timespan'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['clique_count'] = cliqueCount;
    _data['end_timespan'] = endTimespan;
    _data['final_block_count'] = finalBlockCount;
    _data['final_operation_count'] = finalOperationCount;
    _data['staker_count'] = stakerCount;
    _data['stale_block_count'] = staleBlockCount;
    _data['start_timespan'] = startTimespan;
    return _data;
  }
}

class LastSlot {
  LastSlot({
    required this.period,
    required this.thread,
  });
  late final int period;
  late final int thread;

  LastSlot.decode(Map<String, dynamic> json) {
    period = json['period'];
    thread = json['thread'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['period'] = period;
    _data['thread'] = thread;
    return _data;
  }
}

class NetworkStats {
  NetworkStats({
    required this.activeNodeCount,
    required this.bannedPeerCount,
    required this.inConnectionCount,
    required this.knownPeerCount,
    required this.outConnectionCount,
  });
  late final int activeNodeCount;
  late final int bannedPeerCount;
  late final int inConnectionCount;
  late final int knownPeerCount;
  late final int outConnectionCount;

  NetworkStats.decode(Map<String, dynamic> json) {
    activeNodeCount = json['active_node_count'];
    bannedPeerCount = json['banned_peer_count'];
    inConnectionCount = json['in_connection_count'];
    knownPeerCount = json['known_peer_count'];
    outConnectionCount = json['out_connection_count'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['active_node_count'] = activeNodeCount;
    _data['banned_peer_count'] = bannedPeerCount;
    _data['in_connection_count'] = inConnectionCount;
    _data['known_peer_count'] = knownPeerCount;
    _data['out_connection_count'] = outConnectionCount;
    return _data;
  }
}

class NextSlot {
  NextSlot({
    required this.period,
    required this.thread,
  });
  late final int period;
  late final int thread;

  NextSlot.decode(Map<String, dynamic> json) {
    period = json['period'];
    thread = json['thread'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['period'] = period;
    _data['thread'] = thread;
    return _data;
  }
}

class PoolStats {
  PoolStats({
    required this.endorsementCount,
    required this.operationCount,
  });
  late final int endorsementCount;
  late final int operationCount;

  PoolStats.decode(Map<String, dynamic> json) {
    endorsementCount = json['endorsement_count'];
    operationCount = json['operation_count'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['endorsement_count'] = endorsementCount;
    _data['operation_count'] = operationCount;
    return _data;
  }
}
