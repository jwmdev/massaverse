import 'dart:typed_data';

import 'package:base_codecs/base_codecs.dart' as bc;
import 'package:decimal/decimal.dart';
import 'package:hash/hash.dart';
import 'package:massaverse/crypto/secp256k1.dart';
import 'package:massaverse/crypto/util.dart';
import 'package:massaverse/crypto/varuint.dart';
import 'package:massaverse/models/send_transaction.dart';

class Crypto {
  static Uint8List sha256(Uint8List hash) {
    var sha256 = SHA256();
    return sha256.update(hash).digest();
  }

  static Uint8List ripemd160(Uint8List hash) {
    var rmd = RIPEMD160();
    return rmd.update(hash).digest();
  }

  static Uint8List ripmed160sha256(Uint8List hash) {
    return ripemd160(sha256(hash));
  }

//base58Encode encodes the input string into base58 check encode
  static String base58CheckEncode(Uint8List data) {
    return bc.base58CheckEncode(data);
  }

  //decodes given [data]  using base58 check decode
  static Uint8List base58CheckDecode(String data) {
    return bc.base58CheckDecode(data);
  }

  /// converts base58 private key into [PrivateKey] data type
  static PrivateKey getPrivateKeyFromBase58Check(String privKey) {
    final privb8 = base58CheckDecode(privKey);
    final privHex = Util.byteToHex(privb8);
    return PrivateKey.fromHex(privHex);
  }

  /// converts [PrivateKey] into base58check string
  static String getBase58CheckFromPrivateKey(PrivateKey privKey) {
    final privKeyHex = privKey.toHex();
    return base58CheckEncode(Util.hexToBytes(privKeyHex));
  }

  /// converts [PrivateKey] into [Uint8List] bytes
  static Uint8List getBytesFromPrivateKey(PrivateKey privKey) {
    final privKeyHex = privKey.toHex();
    return Util.hexToBytes(privKeyHex);
  }

  /// get [PublicKey] from [Base58Check] private key
  static PublicKey getPublicKeyFromBase58CheckPrivateKey(String privKey) {
    final priv = getPrivateKeyFromBase58Check(privKey);
    return priv.publicKey;
  }

  static Uint8List getPublicKeyFromPrivateKeyHex(String hexKey) {
    var private = PrivateKey.fromHex(hexKey);
    var public = private.publicKey;
    var prefix = public.Y.isEven ? 0x02 : 0x03;
    var pubX = Util.bigIntToBytes(public.X);
    var pre = Util.intToBytes(prefix, 1);
    return Util.joinUint8Lists(pre, pubX);
  }

  static String getBase58CheckFromPublicKey(PublicKey public) {
    var prefix = public.Y.isEven ? 0x02 : 0x03;
    var pubX = Util.bigIntToBytes(public.X);
    var pre = Util.intToBytes(prefix, 1);
    var pub = Util.joinUint8Lists(pre, pubX);
    return base58CheckEncode(pub);
  }

  static String getAddress(PublicKey pubKey) {
    final pub = getBase58CheckFromPublicKey(pubKey);
    var pubByte = base58CheckDecode(pub);
    return base58CheckEncode(sha256(pubByte));
  }

  /// purseAddress purses the address in base58 and returns bytes of public key hash
  static Uint8List parseAddress(String address) {
    final pubKeyHash = base58CheckDecode(address);
    if (pubKeyHash.length != 32) {
      throw "Invalid address.";
    }
    return pubKeyHash;
  }

  static int getAddressThread(String address) {
    return parseAddress(address)[0] >> 3;
  }

  static Signature signData(Uint8List data, PrivateKey privKey) {
    final dataHash = sha256(data);
    final hexHash = Util.byteToHex(dataHash);
    return privKey.signature(hexHash);
  }

  static bool verify(Uint8List data, Signature signature, PublicKey pubKey) {
    final dataHash = Crypto.sha256(data);
    final hexHash = Util.byteToHex(dataHash);
    return signature.verify(pubKey, hexHash);
  }

  static int getTimestamp() {
    var date = DateTime.now().millisecondsSinceEpoch / 1000;
    return date.floor() - 1514764800;
  }

  static signTransaction(SendTransaction tx, String privateKey) {
    var feeInt =
        int.parse((Decimal.parse(tx.fee) * Decimal.parse("1e9")).toString());
    var amountInt =
        int.parse((Decimal.parse(tx.amount) * Decimal.parse("1e9")).toString());
    var encodedData = computeBytesCompact(feeInt, tx.expirePeriod,
        tx.senderPublicKey, 0, tx.recipientAddress, amountInt);

    var privKey = Crypto.getPrivateKeyFromBase58Check(privateKey);
    var signature = Crypto.signData(encodedData, privKey);
    var ss = signature.toRawHex();
    tx.signature = base58CheckEncode(Util.hexToBytes(ss));
  }

  static Uint8List computeBytesCompact(int fee, int expirePeriod,
      String senderPubKey, int typeID, String receiptientAddress, int amount) {
    final encodedFee = Varint.encode(fee);
    final encodedExpirePeriod = Varint.encode(expirePeriod);
    final encodedTypeID = Varint.encode(typeID);
    final encodedAmount = Varint.encode(amount);
    final senderPubKeyHex = base58CheckDecode(senderPubKey);
    final recipientAddressHex = base58CheckDecode(receiptientAddress);
    final data = encodedFee +
        encodedExpirePeriod +
        senderPubKeyHex +
        encodedTypeID +
        recipientAddressHex +
        encodedAmount;
    return Uint8List.fromList(data);
  }
}
