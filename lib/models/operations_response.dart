class OperationsResponse {
  OperationsResponse({
    required this.id,
    required this.inBlocks,
    required this.inPool,
    required this.isFinal,
    required this.operation,
  });
  late final String id;
  late final List<String> inBlocks;
  late final bool inPool;
  late final bool isFinal;
  late final Operation operation;

  OperationsResponse.decode(Map<String, dynamic> json) {
    id = json['id'];
    inBlocks = List.castFrom<dynamic, String>(json['in_blocks']);
    inPool = json['in_pool'];
    isFinal = json['is_final'];
    operation = Operation.decode(json['operation']);
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['in_blocks'] = inBlocks;
    _data['in_pool'] = inPool;
    _data['is_final'] = isFinal;
    _data['operation'] = operation.encode();
    return _data;
  }
}

class Operation {
  Operation({
    required this.content,
    required this.signature,
  });
  late final Content content;
  late final String signature;

  Operation.decode(Map<String, dynamic> json) {
    content = Content.decode(json['content']);
    signature = json['signature'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['content'] = content.encode();
    _data['signature'] = signature;
    return _data;
  }
}

class Content {
  Content({
    required this.expirePeriod,
    required this.fee,
    required this.op,
    required this.senderPublicKey,
  });
  late final int expirePeriod;
  late final int fee;
  late final Op op;
  late final String senderPublicKey;

  Content.decode(Map<String, dynamic> json) {
    expirePeriod = json['expire_period'];
    fee = int.parse(json['fee']);
    op = Op.decode(json['op']);
    senderPublicKey = json['sender_public_key'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['expire_period'] = expirePeriod;
    _data['fee'] = fee;
    _data['op'] = op.encode();
    _data['sender_public_key'] = senderPublicKey;
    return _data;
  }
}

class Op {
  Op({
    required this.transaction,
  });
  late final Transaction transaction;

  Op.decode(Map<String, dynamic> json) {
    transaction = Transaction.decode(json['Transaction']);
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['Transaction'] = transaction.encode();
    return _data;
  }
}

class Transaction {
  Transaction({
    required this.amount,
    required this.recipientAddress,
  });
  late final int amount;
  late final String recipientAddress;

  Transaction.decode(Map<String, dynamic> json) {
    amount = int.parse(json['amount']);
    recipientAddress = json['recipient_address'];
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['amount'] = amount;
    _data['recipient_address'] = recipientAddress;
    return _data;
  }
}
