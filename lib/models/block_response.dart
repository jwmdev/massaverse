class BlockResponse {
  TopContent? content;
  String? id;
  BlockResponse({content, id});

  BlockResponse.decode(Map<String, dynamic> json) {
    content =
        json['content'] != null ? TopContent.decode(json['content']) : null;
    id = json['id'];
  }
  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.encode();
    }
    data['id'] = id;
    return data;
  }
}

class TopContent {
  Block? block;
  bool? isFinal;
  bool? isInBlockclique;
  bool? isStale;

  TopContent({this.block, this.isFinal, this.isInBlockclique, this.isStale});

  TopContent.decode(Map<String, dynamic> json) {
    block = json['block'] != null ? Block.decode(json['block']) : null;
    isFinal = json['is_final'];
    isInBlockclique = json['is_in_blockclique'];
    isStale = json['is_stale'];
  }

  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (block != null) {
      data['block'] = block!.encode();
    }
    data['is_final'] = isFinal;
    data['is_in_blockclique'] = isInBlockclique;
    data['is_stale'] = isStale;
    return data;
  }
}

class Block {
  Header? header;
  List<Operations>? operations;

  Block({this.header, this.operations});

  Block.decode(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.decode(json['header']) : null;
    if (json['operations'] != null) {
      operations = <Operations>[];
      json['operations'].forEach((v) {
        operations!.add(Operations.decode(v));
      });
    }
  }

  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (header != null) {
      data['header'] = header!.encode();
    }
    if (operations != null) {
      data['operations'] = operations!.map((v) => v.encode()).toList();
    }
    return data;
  }
}

class Header {
  HeaderContent? headerContent;
  String? signature;

  Header({this.headerContent, this.signature});

  Header.decode(Map<String, dynamic> json) {
    headerContent =
        json['content'] != null ? HeaderContent.decode(json['content']) : null;
    signature = json['signature'];
  }
  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (headerContent != null) {
      data['content'] = headerContent!.encode();
    }
    data['signature'] = signature;
    return data;
  }
}

class HeaderContent {
  String? creator;
  List<Endorsement>? endorsements;
  String? operationMerkleRoot;
  List<String>? parents;
  Slot? slot;

  HeaderContent(
      {this.creator,
      this.endorsements,
      this.operationMerkleRoot,
      this.parents,
      this.slot});

  HeaderContent.decode(Map<String, dynamic> json) {
    creator = json['creator'];
    if (json['endorsements'] != null) {
      endorsements = <Endorsement>[];
      json['endorsements'].forEach((v) {
        endorsements!.add(Endorsement.decode(v));
      });
    }
    operationMerkleRoot = json['operation_merkle_root'];
    parents = json['parents'].cast<String>();
    slot = json['slot'] != null ? Slot.decode(json['slot']) : null;
  }
  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['creator'] = creator;
    if (endorsements != null) {
      data['endorsements'] = endorsements!.map((v) => v.encode()).toList();
    }
    data['operation_merkle_root'] = operationMerkleRoot;
    data['parents'] = parents;
    if (slot != null) {
      data['slot'] = slot!.encode();
    }
    return data;
  }
}

class Endorsement {
  EndosementContent? content;
  String? signature;

  Endorsement({this.content, this.signature});

  Endorsement.decode(Map<String, dynamic> json) {
    content = json['content'] != null
        ? EndosementContent.decode(json['content'])
        : null;
    signature = json['signature'];
  }
  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.encode();
    }
    data['signature'] = signature;
    return data;
  }
}

class EndosementContent {
  String? endorsedBlock;
  int? index;
  String? senderPublicKey;
  Slot? slot;

  EndosementContent(
      {this.endorsedBlock, this.index, this.senderPublicKey, this.slot});

  EndosementContent.decode(Map<String, dynamic> json) {
    endorsedBlock = json['endorsed_block'];
    index = json['index'];
    senderPublicKey = json['sender_public_key'];
    slot = json['slot'] != null ? Slot.decode(json['slot']) : null;
  }

  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['endorsed_block'] = endorsedBlock;
    data['index'] = index;
    data['sender_public_key'] = senderPublicKey;
    if (slot != null) {
      data['slot'] = slot!.encode();
    }
    return data;
  }
}

class Slot {
  int? period;
  int? thread;

  Slot({this.period, this.thread});

  Slot.decode(Map<String, dynamic> json) {
    period = json['period'];
    thread = json['thread'];
  }

  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period'] = period;
    data['thread'] = thread;
    return data;
  }
}

class OperationContent {
  int? expirePeriod;
  int? fee;
  Op? op;
  String? senderPublicKey;

  OperationContent(
      {this.expirePeriod, this.fee, this.op, this.senderPublicKey});

  OperationContent.decode(Map<String, dynamic> json) {
    expirePeriod = json['expire_period'];
    fee = int.parse(json['fee']);
    op = json['op'] != null ? Op.decode(json['op']) : null;
    senderPublicKey = json['sender_public_key'];
  }

  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expire_period'] = expirePeriod;
    data['fee'] = fee;
    if (op != null) {
      data['op'] = op!.encode();
    }
    data['sender_public_key'] = senderPublicKey;
    return data;
  }
}

class Op {
  Transaction? transaction;

  Op({this.transaction});

  Op.decode(Map<String, dynamic> json) {
    transaction = json['Transaction'] != null
        ? Transaction.decode(json['Transaction'])
        : null;
  }

  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (transaction != null) {
      data['Transaction'] = transaction!.encode();
    }
    return data;
  }
}

class Transaction {
  double? amount;
  String? recipientAddress;

  Transaction({this.amount, this.recipientAddress});

  Transaction.decode(Map<String, dynamic> json) {
    amount = double.parse(json['amount']);
    recipientAddress = json['recipient_address'];
  }

  Map<String, dynamic> encode() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['recipient_address'] = recipientAddress;
    return data;
  }
}

class Operations {
  Operations({
    required this.content,
    required this.signature,
  });
  late final OperationContent content;
  late final String signature;

  Operations.decode(Map<String, dynamic> json) {
    content = OperationContent.decode(json['content']);
    signature = json['signature'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['content'] = content.encode();
    _data['signature'] = signature;
    return _data;
  }
}
