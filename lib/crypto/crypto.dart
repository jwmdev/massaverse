import 'dart:math';
import 'dart:typed_data';
import 'package:base_codecs/base_codecs.dart';
import 'package:crypto/crypto.dart';
import 'package:decimal/decimal.dart';
import 'package:massaverse/crypto/util.dart';
import 'package:massaverse/crypto/varuint.dart';
import 'package:massaverse/models/send_transaction.dart';
import 'package:pointycastle/export.dart';

class Crypto {
  ////
  ///EC Domain parameters for [secp256k1] curve
  ///The private key starts with 3074
  ///
  static final ECDomainParameters k1Domain = ECDomainParameters('secp256k1');

  ///
  /// Generates a elliptic curve [AsymmetricKeyPair].
  /// The default curve is **secp256k1**
  ///

  static AsymmetricKeyPair<ECPublicKey, ECPrivateKey> generateEcKeyPair(
      {String curve = 'secp256k1'}) {
    var ecDomainParameters = ECDomainParameters(curve);
    var keyParams = ECKeyGeneratorParameters(ecDomainParameters);

    var secureRandom = _getSecureRandom();

    var rngParams = ParametersWithRandom(keyParams, secureRandom);
    var generator = ECKeyGenerator();
    generator.init(rngParams);

    var keypair = generator.generateKeyPair();
    return AsymmetricKeyPair<ECPublicKey, ECPrivateKey>(
        keypair.publicKey as ECPublicKey, keypair.privateKey as ECPrivateKey);
  }

  ///
  /// sign the [data] using private key [privateKey] and returns
  /// the ec signature in DER format
  ///
  static ECSignature signData(ECPrivateKey privateKey, Uint8List data,
      {String algorithmName = 'SHA-256/DET-ECDSA'}) {
    var signer = Signer(algorithmName);
    signer.init(true, PrivateKeyParameter<ECPrivateKey>(privateKey));
    return signer.generateSignature(data) as ECSignature;
  }

  ///
  /// verify the signature given the public key
  /// TODO: Handle DER format of signature and public key
  ///
  static bool verify(Uint8List data, ECSignature signature, ECPublicKey pubKey,
      {String algorithmName = 'SHA-256/DET-ECDSA'}) {
    var signer = Signer(algorithmName);
    signer.init(false, PublicKeyParameter<ECPublicKey>(pubKey));
    //var digest = singleDigest(data);

    return signer.verifySignature(data, signature);
  }

  static String getAddress(ECPublicKey pubKey) {
    final pub = getBase58PublicKey(pubKey);
    var pubByte = base58Decode(pub);
    return Crypto.base58Encode(sha256Digest(pubByte));
  }

  static ECPrivateKey getPrivateKeyFromBase58(String privKey) {
    var privKeyDecoded = base58Decode(privKey);
    //var privHex = Util.byteToHex(privKeyDecoded);
    var d = Util.byteToBigInt(privKeyDecoded);
    return ECPrivateKey(d, k1Domain);
  }

  static ECPublicKey getPublicKeyFromPrivate(ECPrivateKey privKey) {
    return _publicKeyFromPrivateKey(privKey);
  }

  ///
  ///get [ECPublicKey] from [privateKey]
  ///
  static ECPublicKey _publicKeyFromPrivateKey(ECPrivateKey privateKey) {
    ECPoint? Q = privateKey.parameters!.G * privateKey.d;
    return ECPublicKey(Q, privateKey.parameters);
  }

  static String getBase58FromPrivateKey(ECPrivateKey privKey) {
    var b = Util.bigIntToBytes(privKey.d!);
    return base58Encode(b);
  }

  ///
  /// Returns a base58check encoded public key from [ECPublicKey] pubKey
  ///
  static String getBase58PublicKey(ECPublicKey pubKey) {
    var pubX = _getPubX(pubKey);
    var pubY = _getPubY(pubKey);
    var prefix = pubY!.isEven ? 0x02 : 0x03;
    var pubXBytes = Util.bigIntToBytes(pubX!);
    var pre = Util.intToBytes(prefix, 1);
    var pub = Util.joinUint8Lists(pre, pubXBytes);
    return base58Encode(pub);
  }

  static String getBase58PublicKeyFromPrivate(ECPrivateKey privKey) {
    var pubKey = _publicKeyFromPrivateKey(privKey);
    return getBase58PublicKey(pubKey);
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

  static signTransaction(SendTransaction tx, String privateKey) {
    var feeInt =
        int.parse((Decimal.parse(tx.fee) * Decimal.parse("1e9")).toString());
    print("parsed fee: 1100000000 ? $feeInt");
    var amountInt =
        int.parse((Decimal.parse(tx.amount) * Decimal.parse("1e9")).toString());

    print("parsed amount: 10987640000 ? $amountInt");

    var encodedData = Crypto.computeBytesCompact(feeInt, tx.expirePeriod,
        tx.senderPublicKey, 0, tx.recipientAddress, amountInt);
    print("encoded data: $encodedData");

    var privKey = Crypto.getPrivateKeyFromBase58(privateKey);
    var dataHash = sha256Digest(encodedData);
    print("hash: $dataHash");
    var signature = signData(privKey, encodedData);
    var r = Util.bigIntToBytes(signature.r);
    var rb58 = base58Encode(r);

    var s = Util.bigIntToBytes(signature.s);
    var sb58 = base58Encode(s);

    var rHex = Util.byteToHex(r);
    var sHex = Util.byteToHex(s);
    print("r = $rHex");
    print("s = $sHex");
    var sig = r + s;
    tx.signature = base58Encode(Uint8List.fromList(sig));
  }

  static Uint8List computeBytesCompact(int fee, int expirePeriod,
      String senderPubKey, int typeID, String receiptientAddress, int amount) {
    final encodedFee = Varint.encode(fee);
    final encodedExpirePeriod = Varint.encode(expirePeriod);
    final encodedTypeID = Varint.encode(typeID);
    final encodedAmount = Varint.encode(amount);
    final senderPubKeyHex = base58Decode(senderPubKey);
    final recipientAddressHex = base58Decode(receiptientAddress);
    final data = encodedFee +
        encodedExpirePeriod +
        senderPubKeyHex +
        encodedTypeID +
        recipientAddressHex +
        encodedAmount;
    return Uint8List.fromList(data);
  }

//----------------supporting functions ---------------------
  ///
  /// Get a SHA256 hash bytes for the given [bytes].
  ///
  static Uint8List sha256Digest(Uint8List bytes) =>
      SHA256Digest().process(bytes);

  ///
  /// Get a SHA256 hash string for the given [bytes].
  ///
  static String sha256DigestString(Uint8List bytes) {
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  ///
  /// Calculates the RIPEMD-160 hash of the given [bytes].
  ///
  static Uint8List ripemd160Digest(Uint8List bytes) =>
      RIPEMD160Digest().process(bytes);

  static Uint8List ripmed160sha256(Uint8List hash) {
    return ripemd160Digest(sha256Digest(hash));
  }

//base58Encode encodes the input string into base58 check encode
  static String base58Encode(Uint8List data) {
    return base58CheckEncode(data);
  }

  //decodes given [data]  using base58 check decode
  static Uint8List base58Decode(String data) {
    return base58CheckDecode(data);
  }

  ///
  /// Generates a secure [FortunaRandom]
  ///
  static SecureRandom _getSecureRandom() {
    var _secureRandom = FortunaRandom();
    var random = Random.secure();
    var seeds = <int>[];
    for (var i = 0; i < 32; i++) {
      seeds.add(random.nextInt(255));
    }
    _secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
    return _secureRandom;
  }

  ///
  /// Generate random bytes with [len] length
  /// Could be used for Initialization Vector (IV).
  ///
  static Uint8List _getSecureRandomBytes(int len) {
    var _secureRandom = FortunaRandom();

    final seedSource = Random.secure();
    final seeds = <int>[];
    for (int i = 0; i < 32; i++) {
      seeds.add(seedSource.nextInt(255));
    }
    _secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

    final iv = _secureRandom.nextBytes(len);
    return iv;
  }

  static int getTimestamp() {
    var date = DateTime.now().millisecondsSinceEpoch / 1000;
    return date.floor() - 1514764800;
  }

  /// Represent bytes in hexadecimal
  /// If a [separator] is provided, it is placed the hexadecimal characters
  /// representing each byte. Otherwise, all the hexadecimal characters are
  /// simply concatenated together.
  ///
  static String bin2hex(Uint8List bytes,
      {required String separator, int? wrap}) {
    var len = 0;
    final buf = StringBuffer();
    for (final b in bytes) {
      final s = b.toRadixString(16);
      if (buf.isNotEmpty && separator != "") {
        buf.write(separator);
        len += separator.length;
      }

      if (wrap != null && wrap < len + 2) {
        buf.write('\n');
        len = 0;
      }

      buf.write('${(s.length == 1) ? '0' : ''}$s');
      len += 2;
    }
    return buf.toString();
  }

  ///
  /// Decode a hexadecimal string [hexStr] into a sequence of bytes.
  ///

  static Uint8List hex2bin(String hexStr) {
    if (hexStr.length % 2 != 0) {
      throw const FormatException(
          'not an even number of hexadecimal characters');
    }
    final result = Uint8List(hexStr.length ~/ 2);
    for (int i = 0; i < result.length; i++) {
      result[i] = int.parse(hexStr.substring(2 * i, 2 * (i + 1)), radix: 16);
    }
    return result;
  }

  ///
  ///get [x] coordinate of the public key [pubKey]
  ///
  static BigInt? _getPubX(ECPublicKey pubKey) {
    return pubKey.Q!.x!.toBigInteger();
  }

  ///
  ///get [y] coordinate of the public key [pubKey]
  ///
  static BigInt? _getPubY(ECPublicKey pubKey) {
    return pubKey.Q!.y!.toBigInteger();
  }
}
