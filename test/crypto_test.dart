import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:massaverse/crypto/crypto.dart';
import 'package:massaverse/crypto/util.dart';

void main() {
  const privateKey = "26K5LobGsmCeuRm6YMifrsUqutZ8uKs8p34KgbZgC6ECPhMaoM";
  const publicKey = "6zpnyRf8ZLTeqWL1BVhB5sPByQqDJpJGtERQjF9Hc4yKjQA7ww";
  const address = "oj8ZWRWodDXm7UeEkm9XgC332kYXcEeFabEaUe7XjWkkjf5zU";

  const privateKey2 = "2QXSCQBGtKrHHBtraNbDhQEzNJ4kTJh5P7b1hfSMT4YPEkmjbH";
  const publicKey2 = "5F9xcai1kRyLvAPYiVYFx9oqrwJkn18G3syznDB75akZTQqTkG";
  const address2 = "kfA75kiE5bTTxmhnghsK1xWeHFzMabcgUY1sf5aGnBgKnypne";

  group('Crypto', () {
    test('test hash sha256', () {
      var hashHex =
          "60bf6c46a8f6d9a02bb5a0f1f8691eb0d7d0cf649424f4d385bdf31fc261b4be";
      var hash = Util.hexToBytes(hashHex);
      var result = Crypto.sha256(hash);
      Uint8List output = Uint8List.fromList([
        190,
        194,
        99,
        8,
        250,
        99,
        204,
        92,
        152,
        27,
        174,
        217,
        152,
        110,
        5,
        15,
        12,
        18,
        30,
        166,
        70,
        222,
        186,
        8,
        65,
        188,
        127,
        150,
        3,
        103,
        191,
        161
      ]);
      expect(result, output);
    });

    test("base58 encode and decode check", () {
      const encodedCheck =
          "5Kd3NBUAdUnhyzenEwVLy9pBKxSwXvE9FMPyR4UKZvpe6E3AgLr";

      var dec = Crypto.base58Decode(encodedCheck);

      expect(encodedCheck, Crypto.base58Encode(dec));
    });

    test("signature", () {
      const str = "this is a message to be tested";
      var data = Util.stringToBytesUtf8(str);
      var privKey = Crypto.parsePrivateBase58Check(privateKey);
      var sig = Crypto.signData(data, privKey);
      var valid = Crypto.verify(data, sig, privKey.publicKey);
      expect(true, valid);
    });
  });
}
