import 'package:flutter_test/flutter_test.dart';
import 'package:massaverse/api/api_service.dart';

void main() {
  group('Massa API', () {
    final api = ApiService();
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
      var block = "2t33YdKV6JVNBiCh4aL696GzoqC4JdiLb2of9WiCkNbv5Ci562";
      var resp = await api.getBlock(block);
      print("block response: ${resp.encode()}");
    });
  });
}
