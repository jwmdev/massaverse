import 'dart:ffi';
import 'dart:typed_data';

import 'package:base_codecs/base_codecs.dart';
import 'package:hash/hash.dart';
import 'package:massaverse/crypto/secp256k1.dart';
import 'package:massaverse/crypto/util.dart';
import 'package:massaverse/crypto/varuint.dart';

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
  static String base58Encode(Uint8List data) {
    return base58CheckEncode(data);
  }

  //decodes given [data]  using base58 check decode
  static Uint8List base58Decode(String data) {
    return base58CheckDecode(data);
  }

  static String deducePrivateBase58Check(Uint8List data) {
    return base58Encode(data);
  }

// converts base58 private key into [PrivateKey] data type
  static PrivateKey parsePrivateBase58Check(String data) {
    final privb8 = base58Decode(data);
    final privHex = Util.byteToHex(privb8);
    return PrivateKey.fromHex(privHex);
  }

  static String deducePublicBase58Check(Uint8List data) {
    return base58Encode(data);
  }

// converts base58 public key into [byte] string
  static Uint8List parsePublicBase58Check(String data) {
    return base58Decode(data);
  }

  static Uint8List getPublicKeyFromPrivate(String hexKey) {
    var private = PrivateKey.fromHex(hexKey);
    var public = private.publicKey;
    var prefix = public.Y.isEven ? 0x02 : 0x03;
    var pubX = Util.bigIntToBytes(public.X);
    var pre = Util.intToBytes(prefix, 1);
    return Util.joinUint8Lists(pre, pubX);
  }

  static String getPublicBase58(PublicKey public) {
    var prefix = public.Y.isEven ? 0x02 : 0x03;
    var pubX = Util.bigIntToBytes(public.X);
    var pre = Util.intToBytes(prefix, 1);
    var pub = Util.joinUint8Lists(pre, pubX);
    return deducePublicBase58Check(pub);
  }

  static String deduceAddress(PublicKey pubKey) {
    final pub = Crypto.getPublicBase58(pubKey);
    var pubByte = Crypto.base58Decode(pub);
    return Crypto.base58Encode(Crypto.sha256(pubByte));
  }

// purseAddress purses the address in base58 and returns bytes of public key hash
  static Uint8List parseAddress(String address) {
    final pubKeyHash = base58Decode(address);
    if (pubKeyHash.length != 32) {
      throw "Invalid address.";
    }
    return pubKeyHash;
  }

  static int getAddressThread(String address) {
    return parseAddress(address)[0] >> 3;
  }

  /*  
  function sign_data(data, privkey) {
    return ecc.sign(hash_sha256(data), privkey);
}

function verify_data_signature(data, signature, pubkey) {
    return ecc.verify(hash_sha256(data), pubkey, signature)
}
  */

  static Signature signData(Uint8List data, PrivateKey privKey) {
    final dataHash = Crypto.sha256(data);
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

/*
function compute_bytes_compact(fee, expire_period, sender_pubkey, type_id, recipient_address, amount) {
    var encoded_fee = xbqcrypto.Buffer.from(xbqcrypto.varint_encode(fee))
    var encoded_expire_periode = xbqcrypto.Buffer.from(xbqcrypto.varint_encode(expire_period))
    var encoded_type_id = xbqcrypto.Buffer.from(xbqcrypto.varint_encode(type_id))
    var encoded_amount = xbqcrypto.Buffer.from(xbqcrypto.varint_encode(amount))
    sender_pubkey = xbqcrypto.base58check_decode(sender_pubkey)
    recipient_address = xbqcrypto.base58check_decode(recipient_address)
    return Buffer.concat([encoded_fee, encoded_expire_periode, sender_pubkey, encoded_type_id, recipient_address, encoded_amount])
}
*/

  static Uint8List computeBytesCompact(int fee, int expirePeriod,
      String senderPubKey, int typeID, String receiptientAddress, int amount) {
    final encodedFree = Varuint.encode(fee);
    final encodedExpirePeriod = Varuint.encode(expirePeriod);
    final encodedTypeID = Varuint.encode(typeID);
    final encodedAmount = Varuint.encode(amount);
    final senderPubKeyHex = Util.byteToHex(base58Decode(senderPubKey));
    final recipientAddressHex =
        Util.byteToHex(base58Decode(receiptientAddress));
    final data = encodedFree +
        encodedExpirePeriod +
        senderPubKeyHex +
        encodedTypeID +
        recipientAddressHex +
        encodedAmount;
    return Util.hexToBytes(data);
  }
}
