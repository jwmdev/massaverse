import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';

class MassaJSCrypto {
  late JavascriptRuntime fjs; //flutter javascript runtime
  late String jsFuncs;
  MassaJSCrypto() {
    fjs = getJavascriptRuntime();
    loadJS(); //load secp256k1 library
  }

  void loadJS() async {
    jsFuncs = await rootBundle.loadString("assets/massajs/bn_secp256k1.js");
  }

  String toHex(int value) {
    var result = fjs.evaluate(jsFuncs + """toHex($value) """);
    return result.stringResult;
  }
}
