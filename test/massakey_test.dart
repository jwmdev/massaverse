import 'package:flutter_test/flutter_test.dart';
import 'package:massaverse/crypto/massakey.dart';

void main() {
  group('Massakey', () {
    const priv = "2QXSCQBGtKrHHBtraNbDhQEzNJ4kTJh5P7b1hfSMT4YPEkmjbH";
    const pub = "5F9xcai1kRyLvAPYiVYFx9oqrwJkn18G3syznDB75akZTQqTkG";
    const addr = "kfA75kiE5bTTxmhnghsK1xWeHFzMabcgUY1sf5aGnBgKnypne";

    test("Private key import /private key", () {
      var massaKey = MassaKey(priv);
      print("private: ${massaKey.privateKey()}");
      print("public: ${massaKey.publicKey()}");
      print("address: ${massaKey.address()}");
      expect(priv, massaKey.privateKey());
    });

    test("Private key import / public key", () {
      var massaKey = MassaKey(priv);
      print("public: ${massaKey.publicKey()}");
      expect(pub, massaKey.publicKey());
    });

    test("Private key import / address", () {
      var massaKey = MassaKey(priv);
      print("address: ${massaKey.address()}");
      expect(addr, massaKey.address());
    });

    test("Private key generation", () {
      var massaKey = MassaKey(null);
      print("private: ${massaKey.privateKey()}");
      print("public: ${massaKey.publicKey()}");
      print("address: ${massaKey.address()}");
    });

    test("public key generation", () {
      var massaKey = MassaKey(priv);
      expect(pub, massaKey.publicKey());
    });

    test("address generation", () {
      var massaKey = MassaKey(priv);
      expect(addr, massaKey.address());
    });
  });
}
