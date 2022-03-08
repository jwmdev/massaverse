class AddressResponse {
  AddressResponse({
    required this.address,
    required this.blockDraws,
    required this.blocksCreated,
    required this.endorsementDraws,
    required this.involvedInEndorsements,
    required this.involvedInOperations,
    required this.ledgerInfo,
    required this.productionStats,
    required this.rolls,
    required this.sceLedgerInfo,
    required this.thread,
  });
  late final String address;
  late final List<dynamic> blockDraws;
  late final List<dynamic> blocksCreated;
  late final List<dynamic> endorsementDraws;
  late final List<dynamic> involvedInEndorsements;
  late final List<String> involvedInOperations;
  late final LedgerInfo ledgerInfo;
  late final List<ProductionStats> productionStats;
  late final Rolls rolls;
  late final SceLedgerInfo sceLedgerInfo;
  late final int thread;

  AddressResponse.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    blockDraws = List.castFrom<dynamic, dynamic>(json['block_draws']);
    blocksCreated = List.castFrom<dynamic, dynamic>(json['blocks_created']);
    endorsementDraws =
        List.castFrom<dynamic, dynamic>(json['endorsement_draws']);
    involvedInEndorsements =
        List.castFrom<dynamic, dynamic>(json['involved_in_endorsements']);
    involvedInOperations =
        List.castFrom<dynamic, String>(json['involved_in_operations']);
    ledgerInfo = LedgerInfo.fromJson(json['ledger_info']);
    productionStats = List.from(json['production_stats'])
        .map((e) => ProductionStats.fromJson(e))
        .toList();
    rolls = Rolls.fromJson(json['rolls']);
    sceLedgerInfo = SceLedgerInfo.fromJson(json['sce_ledger_info']);
    thread = json['thread'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['address'] = address;
    _data['block_draws'] = blockDraws;
    _data['blocks_created'] = blocksCreated;
    _data['endorsement_draws'] = endorsementDraws;
    _data['involved_in_endorsements'] = involvedInEndorsements;
    _data['involved_in_operations'] = involvedInOperations;
    _data['ledger_info'] = ledgerInfo.toJson();
    _data['production_stats'] = productionStats.map((e) => e.toJson()).toList();
    _data['rolls'] = rolls.toJson();
    _data['sce_ledger_info'] = sceLedgerInfo.toJson();
    _data['thread'] = thread;
    return _data;
  }
}

class LedgerInfo {
  LedgerInfo({
    required this.candidateLedgerInfo,
    required this.finalLedgerInfo,
    required this.lockedBalance,
  });
  late final CandidateLedgerInfo candidateLedgerInfo;
  late final FinalLedgerInfo finalLedgerInfo;
  late final int lockedBalance;

  LedgerInfo.fromJson(Map<String, dynamic> json) {
    candidateLedgerInfo =
        CandidateLedgerInfo.fromJson(json['candidate_ledger_info']);
    finalLedgerInfo = FinalLedgerInfo.fromJson(json['final_ledger_info']);
    lockedBalance = json['locked_balance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['candidate_ledger_info'] = candidateLedgerInfo.toJson();
    _data['final_ledger_info'] = finalLedgerInfo.toJson();
    _data['locked_balance'] = lockedBalance;
    return _data;
  }
}

class CandidateLedgerInfo {
  CandidateLedgerInfo({
    required this.balance,
  });
  late final double balance;

  CandidateLedgerInfo.fromJson(Map<String, dynamic> json) {
    balance = double.parse(json['balance']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['balance'] = balance;
    return _data;
  }
}

class FinalLedgerInfo {
  FinalLedgerInfo({
    required this.balance,
  });
  late final double balance;

  FinalLedgerInfo.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['balance'] = balance;
    return _data;
  }
}

class ProductionStats {
  ProductionStats({
    required this.cycle,
    required this.isFinal,
    required this.nokCount,
    required this.okCount,
  });
  late final int cycle;
  late final bool isFinal;
  late final int nokCount;
  late final int okCount;

  ProductionStats.fromJson(Map<String, dynamic> json) {
    cycle = int.parse(json['cycle']);
    isFinal = json['is_final'];
    nokCount = int.parse(json['nok_count']);
    okCount = int.parse(json['ok_count']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cycle'] = cycle;
    _data['is_final'] = isFinal;
    _data['nok_count'] = nokCount;
    _data['ok_count'] = okCount;
    return _data;
  }
}

class Rolls {
  Rolls({
    required this.activeRolls,
    required this.candidateRolls,
    required this.finalRolls,
  });
  late final int activeRolls;
  late final int candidateRolls;
  late final int finalRolls;

  Rolls.fromJson(Map<String, dynamic> json) {
    activeRolls = int.parse(json['active_rolls']);
    candidateRolls = int.parse(json['candidate_rolls']);
    finalRolls = int.parse(json['final_rolls']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['active_rolls'] = activeRolls;
    _data['candidate_rolls'] = candidateRolls;
    _data['final_rolls'] = finalRolls;
    return _data;
  }
}

class SceLedgerInfo {
  SceLedgerInfo({
    required this.balance,
    required this.datastore,
    this.module,
  });
  late final int balance;
  late final Datastore datastore;
  late final Null module;

  SceLedgerInfo.fromJson(Map<String, dynamic> json) {
    balance = int.parse(json['balance']);
    datastore = Datastore.fromJson(json['datastore']);
    module = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['balance'] = balance;
    _data['datastore'] = datastore.toJson();
    _data['module'] = module;
    return _data;
  }
}

class Datastore {
  Datastore();

  Datastore.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}
