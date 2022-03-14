import 'dart:typed_data';

import 'package:massaverse/crypto/crypto.dart';
import 'package:massaverse/crypto/secp256k1.dart';

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
      _address = Crypto.getAddress(_publicKey);
      _addressThread = Crypto.getAddressThread(_address);
    } else {
      _privateKey = Crypto.getPrivateKeyFromBase58Check(privateKeyBase58);
      _publicKey = _privateKey.publicKey;
      _address = Crypto.getAddress(_publicKey);
      _addressThread = Crypto.getAddressThread(_address);
    }
  }

  String privateHex() {
    return _privateKey.toHex();
  }

// returns private key in base58 format
  String privateKey() {
    return Crypto.getBase58CheckFromPrivateKey(_privateKey);
  }

  String privateKeyHex() {
    return _privateKey.toHex();
  }

  String publicCompressedHex() {
    return _publicKey.toCompressedHex();
  }

  /// returns public key encoded in [hex] format
  String publicKeyHex() {
    return _publicKey.toHex();
  }

  /// returns public key encoded in [base58Check] format
  String publicKey() {
    return Crypto.getBase58CheckFromPublicKey(_publicKey);
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
