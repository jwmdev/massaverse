import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:massaverse/api/api_service.dart';
import 'package:massaverse/crypto/crypto.dart';
import 'package:massaverse/models/send_transaction.dart';

void main() {
  group('Massa API', () {
    final api = ApiService();

    const privateKey = "27LUESeV2XNL6aEExPV8u9P9y5pMKkkxwg9LvqAQqmc9q7U3F4";
    const publicKey = "77qKMXz2vmMPfHx6ioUATs9Ms1WXWbwjZUwmL1L5esqZefsFQJ";
    const address = "94rmBAS7frtUKvSoKsWg5UGLLFKVS1yqpXAkr1kZg7DxVTdfv";

    const privateKey2 = "2QXSCQBGtKrHHBtraNbDhQEzNJ4kTJh5P7b1hfSMT4YPEkmjbH";
    const publicKey2 = "5F9xcai1kRyLvAPYiVYFx9oqrwJkn18G3syznDB75akZTQqTkG";
    const address2 = "kfA75kiE5bTTxmhnghsK1xWeHFzMabcgUY1sf5aGnBgKnypne";

    /* test("Import wallet", () async {
      var mk = MassaKey(privateKey);
      print("private: ${mk.privateKey()}");
      print("public: ${mk.publicKey()}");
      print("address: ${mk.address()}");
      var resp = await api.getStatus();
      //print("info response: ${resp.encode()}");
    });
    test("Get info", () async {
      var resp = await api.getStatus();
      //print("info response: ${resp.encode()}");
    });
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
      if (resp != null) {
        //print("addresses response: ${resp}");
      } else {
        // print("no info obtained");
      }
    });*/
    test("Send transactions", () async {
      String address = "";
      var amount = Decimal.parse("15.0");
      var fee = Decimal.parse("0.1");

      //var info = await api.getInfo();
      //if (info == null) return;
      int expirePeriod = 61557 + 20; // info.lastPeriod + 5;

      var tx = SendTransaction(
          amount: amount.toString(),
          fee: fee.toString(),
          recipientAddress: address2,
          senderPublicKey: publicKey,
          expirePeriod: expirePeriod);
      Crypto.signTransaction(tx, privateKey);
      print("tx : ${tx.encode()}");

      var resp = await api.sendTransaction(tx);
      print("send transaction respons: $resp");
    });
  });
}
