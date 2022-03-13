import 'dart:typed_data';

class Varint {
  static const _allButMSB = 0x7f;
  static const _justMSB = 0x80;

  static int decode(List<int> bytes) {
    int result = 0;
    int currentShift = 0;
    int bytesPopped = 0;
    for (int i = 0; i < bytes.length; i++) {
      bytesPopped++;
      final current = bytes[i] & Varint._allButMSB;
      result |= current << currentShift;

      if ((bytes[i] & Varint._justMSB) != Varint._justMSB) {
        bytes.removeRange(0, bytesPopped);
        return result;
      }

      currentShift += 7;
    }

    throw ArgumentError('Byte array did not contain valid varints.');
  }

  static Uint8List encode(value) {
    Uint8List buff = Uint8List(10);
    buff.fillRange(0, 10, 0);

    int currentIndex = 0;
    if (value == 0) {
      return Uint8List.fromList([0]);
    }

    while (value != 0) {
      var byteVal = value & Varint._allButMSB;
      value >>= 7;

      if (value != 0) byteVal |= Varint._justMSB;
      buff[currentIndex++] = byteVal;
    }

    return buff.sublist(0, currentIndex);
  }
}
/*
 0-249 	         the same number
 250 (0xfa) 	 as uint16
 251 (0xfb) 	 as uint32
 252 (0xfc) 	 as uint64
 253 (0xfd) 	 as uint128
 254 (0xfe) 	 as uint256
 255 (0xff) 	 as uint512
 

class Varuint {
  ///
  ///encode encode integer [value] into a string
  ///
  static String encode(int value) {
    if (value <= 249) {
      return intToHex(value, 1);
    } else if (value <= pow(2, 16)) {
      return intToHex(250, 1) + intToHex(value, 2);
    } else if (value <= pow(2, 32)) {
      return intToHex(251, 1) + intToHex(value, 4);
    } else {
      return intToHex(252, 1) + intToHex(value, 8);
    }
  }

  ///
  ///intHex converts an interger [value] into string
  ///
  static String intToHex(int value, int len) {
    if (value < 0 || value == 0) return "00";

    //int len = (value.bitLength / 8).ceil();
    //print("Len " + len.toString() + " value = " + value.toString());
    Uint8List list = Uint8List(len);
    for (var i = 0; i < len; i++) {
      list[i] = (value % 256);
      value = value ~/ 256;
    }
    return Util.byteToHex(list);
  }

  static String encode2(int value) {
    const int minInt =
        (double.infinity is int) ? -double.infinity as int : (-1 << 63);
    const int maxInt =
        (double.infinity is int) ? double.infinity as int : ~minInt;

    if (value > maxInt) {
      throw ("could not encode varint, given number is out of range");
    }

    const MSB = 0x80;
    const REST = 0x7F;
    const MSBALL = ~REST;
    var INT = pow(2, 31);

    List<int> result = [];

    while (value >= INT) {
      result.add((value & 0xFF) | MSB);
      value = value ~/ 128;
    }

    while ((value & MSBALL) > 0) {
      result.add((value & 0xFF) | MSB);
      value >>>= 7;
    }
    result.add(value | 0);

    Uint8List data = Uint8List.fromList(result);
    return Util.byteToHex(data);
  }
}*/


