import 'dart:typed_data';

import 'package:massaverse/crypto/crypto.dart';
import 'package:massaverse/crypto/secp256k1.dart';
import 'package:massaverse/crypto/util.dart';

class MassaKey {
  late PrivateKey _privateKey;
  late PublicKey _publicKey;
  late String _address;
  late int _addressThread;

  MassaKey(String? privateKeyBase58) {
    //generate a new private key if null is provided
    if (privateKeyBase58 == null) {
      _privateKey = PrivateKey.generate();
      _publicKey = _privateKey.publicKey;
      _address = Crypto.deduceAddress(_publicKey);
      _addressThread = Crypto.getAddressThread(_address);
    } else {
      //check if it correct hex string
      //if (!Util.isHexString(privateKeyHex)) {
      //  throw ("the provide key is not the correct hex string");
      //}
      var privb8 = Crypto.parsePrivateBase58Check(privateKeyBase58);
      var privHex = Util.byteToHex(privb8);
      _privateKey = PrivateKey.fromHex(privHex);
      _publicKey = _privateKey.publicKey;
      _address = Crypto.deduceAddress(_publicKey);
      _addressThread = Crypto.getAddressThread(_address);
    }
  }

  String privateHex() {
    return _privateKey.toHex();
  }

// returns private key in base58 format
  String privateKey() {
    return Crypto.deducePrivateBase58Check(
        Util.hexToBytes(_privateKey.toHex()));
  }

  String publicCompressedHex() {
    return _publicKey.toCompressedHex();
  }

  String publicHex() {
    return _publicKey.toHex();
  }

  String publicKey() {
    return Crypto.getPublicBase58(_publicKey);
  }

  String address() {
    return _address;
  }

  int addressThread() {
    return _addressThread;
  }

  Signature signData(Uint8List data) {
    return Crypto.signData(data, _privateKey);
  }

  bool verify(Uint8List data, Signature signature) {
    return Crypto.verify(data, signature, _publicKey);
  }
}
