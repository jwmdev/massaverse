import 'package:flutter_test/flutter_test.dart';
import 'package:massaverse/crypto/massajs.dart';

main() {
  group('[calling_javascript]', () {
    test('calling functions', () {
      MassaJSCrypto mc = MassaJSCrypto();
      var tt = mc.toHex(45);
      print("massajs toHex(45) = $tt");

      //expect(answer, equals(42));
    });
  });
}
