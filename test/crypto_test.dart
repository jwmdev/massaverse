import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:massaverse/crypto/crypto.dart';
import 'package:massaverse/crypto/util.dart';

void main() {
  group('Crypto', () {
    test('test hash sha256', () {
      //String privateKeyHex = "VgrspMAX6zKVUHL3dDiyLy8RffCKGDprwvatv5Azz9cDwGAj8";
      //String publicKey = "6nwo2GeQhSmdGfazqMyCFJs75REQ8QEKsHUvd7iUiq8dadVHgf";
      //String address = "";
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
  });
}
