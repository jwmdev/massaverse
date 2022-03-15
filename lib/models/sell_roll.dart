class SellRolls {
  late final String rolls;
  late final String fee;
  late final String recipientAddress;
  late final String senderPublicKey;
  late final int expirePeriod;
  late final SellRollsContent content;
  String? signature;

  SellRolls({
    required this.rolls,
    required this.fee,
    required this.recipientAddress,
    required this.senderPublicKey,
    required this.expirePeriod,
  }) {
    final roll = RollSell(rollCount: rolls);
    final operation = SellRollOp(roll: roll);
    content = SellRollsContent(
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

class SellRollsContent {
  SellRollsContent({
    required this.expirePeriod,
    required this.fee,
    required this.op,
    required this.senderPublicKey,
  });
  late final int expirePeriod;
  late final String fee;
  late final SellRollOp op;
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

class SellRollOp {
  SellRollOp({
    required this.roll,
  });
  late final RollSell roll;

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['RollSell'] = roll.encode();
    return _data;
  }
}

class RollSell {
  RollSell({
    required this.rollCount,
  });
  late final String rollCount;

  Map<String, dynamic> encode() {
    final _data = <String, dynamic>{};
    _data['roll_count'] = rollCount;
    return _data;
  }
}
