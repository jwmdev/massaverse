import 'dart:typed_data';

import 'package:massaverse/crypto/crypto.dart';
import 'package:massaverse/crypto/util.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/ecc/api.dart';

class MassaKey {
  late AsymmetricKeyPair<ECPublicKey, ECPrivateKey> _keyPair;
  late String _address;
  late int _addressThread;

  MassaKey(String? privateKeyBase58) {
    //generate a new private key if null is provided
    if (privateKeyBase58 == null) {
      _keyPair = Crypto.generateEcKeyPair();
      _address = Crypto.getAddress(_keyPair.publicKey);
      _addressThread = Crypto.getAddressThread(_address);
    } else {
      var privKey = Crypto.getPrivateKeyFromBase58(privateKeyBase58);
      var pubKey = Crypto.getPublicKeyFromPrivate(privKey);
      _keyPair = AsymmetricKeyPair(pubKey, privKey);
      _address = Crypto.getAddress(pubKey);
      _addressThread = Crypto.getAddressThread(_address);
    }
  }

// returns private key in base58 format
  String privateKey() {
    return Crypto.getBase58FromPrivateKey(_keyPair.privateKey);
  }

  String publicKey() {
    return Crypto.getBase58PublicKey(_keyPair.publicKey);
  }

  String address() {
    return _address;
  }

  int addressThread() {
    return _addressThread;
  }

  Signature signData(Uint8List data) {
    return Crypto.signData(_keyPair.privateKey, data);
  }

  /*bool verify(Uint8List data, Signature signature) {
    return Crypto.verify(data, signature, _publicKey);
  }*/
}
