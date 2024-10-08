import 'dart:math';
import 'dart:typed_data';

extension IntExtension on int {
  String toHexString() {
    // return '0x' + toRadixString(16).padLeft(2, '0').toUpperCase();
    return toRadixString(16).padLeft(2, '0').toUpperCase();
  }
}

extension Uint8ListExtension on Uint8List {
  String toHexString({String empty = '-', String separator = ' '}) {
    return isEmpty ? empty : map((e) => e.toHexString()).join(separator);
  }
}

class Utils {
  static num hexToDecimal(String hex) {
    return int.parse(hex, radix: 16);
  }
}