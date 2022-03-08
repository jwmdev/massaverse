import 'package:flutter_test/flutter_test.dart';
import 'package:massaverse/api/api_service.dart';
import 'package:massaverse/crypto/crypto.dart';
import 'package:massaverse/crypto/util.dart';
import 'package:massaverse/models/send_transaction.dart';

void main() {
  group('Massa API', () {
    final api = ApiService();

    const privateKey = "26K5LobGsmCeuRm6YMifrsUqutZ8uKs8p34KgbZgC6ECPhMaoM";
    const publicKey = "6zpnyRf8ZLTeqWL1BVhB5sPByQqDJpJGtERQjF9Hc4yKjQA7ww";
    const address = "oj8ZWRWodDXm7UeEkm9XgC332kYXcEeFabEaUe7XjWkkjf5zU";

    const privateKey2 = "2QXSCQBGtKrHHBtraNbDhQEzNJ4kTJh5P7b1hfSMT4YPEkmjbH";
    const publicKey2 = "5F9xcai1kRyLvAPYiVYFx9oqrwJkn18G3syznDB75akZTQqTkG";
    const address2 = "kfA75kiE5bTTxmhnghsK1xWeHFzMabcgUY1sf5aGnBgKnypne";

    test("Get status", () async {
      var resp = await api.getStatus();
      //print("status response: ${resp.connectedNodes}");
      //print("status response: ${resp.encode()}");
    });

    test("Get Cliques", () async {
      var resp = await api.getCliques();
      //print("cliques response: ${resp.encode()}");
    });

    test("Get Stakers", () async {
      var resp = await api.getStakers();
      /*resp.forEach((key, value) {
        print("$key: $value");
      });*/
    });

    test("Get Operations", () async {
      var op = ["2noLJA6j22CkimfJunP5YkceNywdqxfSjgAnWMCT8n4ECABM4D"];
      /*var op = [
        "nmSvH5NjcKVx3D5XHofezPkUbGprBjbFEw3PDxqDx8tcTCuYp",
        "Vdt7t1681p9fLUxejkZs8758T5uLdR7fpcFKuMuw3StgZEUG4"
      ];*/
      var resp = await api.getOperations(op);
      //print("operation response: ${resp.encode()}");
    });
    test("Get Endosement", () async {
      var endosement = ["ek1NWuumgfU2YkkAFkXkAsPFQvrCg5V2Zi15xmYy8434EU96v"];
      var resp = await api.getEndosements(endosement);
      //print("endosement response: ${resp}");
    });

    test("Get Block", () async {
      var block = "t5q4nHj96XBYcGJ7JT7F2x3bRxnQa7LKBjoqzcphgzmdknHtd";
      var resp = await api.getBlock(block);
      //print("block response: ${resp.encode()}");
    });

    test("Get Addresses", () async {
      var addr = [address];
      var resp = await api.getAddresses(addr);
      print("addresses response: ${resp}");
    });
    test("Send transactions", () async {
      String address = "";
      var amount = 10.98764;
      String amountString = Util.doubleToMassa(amount);
      var fee = 0.98764;
      String feeString = Util.doubleToMassa(fee);
      int expTime = 56987321;

      var tx = SendTransaction(
          amount: amountString,
          fee: feeString,
          recipientAddress: address2,
          senderPublicKey: publicKey,
          expirePeriod: expTime);
      var priv = Crypto.parsePrivateBase58Check(privateKey);
      var txEcoded = tx.encode();
      //var signature = Crypto.signData(txEncoded, priv);
      print("tx : ${tx.encode()}");
    });
  });
}
