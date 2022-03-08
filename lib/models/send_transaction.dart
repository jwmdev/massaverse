class SendTransaction {
  late final String amount;
  late final String fee;
  late final String recipientAddress;
  late final String senderPublicKey;
  late final int expirePeriod;
  late final Content content;
  String? signature;

  SendTransaction({
    required this.amount,
    required this.fee,
    required this.recipientAddress,
    required this.senderPublicKey,
    required this.expirePeriod,
  }) {
    final transaction =
        Transaction(amount: amount, recipientAddress: recipientAddress);
    final operation = Op(transaction: transaction);
    content = Content(
        expirePeriod: expirePeriod,
        fee: fee,
        op: operation,
        senderPublicKey: senderPublicKey);
  }

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['content'] = content.encode();
    if (signature != null) {
      _data['signature'] = signature;
    }
    return _data;
  }

//set signature
  setSignature(String signature) {
    this.signature = signature;
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
  late final String fee;
  late final Op op;
  late final String senderPublicKey;

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
  late final String amount;
  late final String recipientAddress;

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['amount'] = amount;
    _data['recipient_address'] = recipientAddress;
    return _data;
  }
}
