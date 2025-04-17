import 'dart:convert';
import 'dart:math';

class XorCipherController {
  static Map<String, dynamic> encrypt(String message) {
    if (message.isEmpty) {
      throw ArgumentError("A mensagem não pode estar vazia");
    }

    final key = _generateRandomKey(message.length);
    final messageBytes = utf8.encode(message);
    final keyBytes = utf8.encode(key);

    final encryptedBytes = List<int>.generate(
      messageBytes.length,
      (i) => messageBytes[i] ^ keyBytes[i],
    );

    return {
      'key': key,
      'encrypted': encryptedBytes,
      'binary': _bytesToBinary(encryptedBytes), // Agora retorna binário
    };
  }

  static String decrypt(String binary, String key) {
    if (binary.isEmpty || key.isEmpty) {
      throw ArgumentError("Binário e chave não podem estar vazios");
    }

    final bytes = _binaryToBytes(binary);
    final keyBytes = utf8.encode(key);

    if (bytes.length != keyBytes.length) {
      throw ArgumentError("A chave deve ter o mesmo tamanho da mensagem original");
    }

    final decryptedBytes = List<int>.generate(
      bytes.length,
      (i) => bytes[i] ^ keyBytes[i],
    );

    return utf8.decode(decryptedBytes);
  }

  static String _generateRandomKey(int length) {
    final random = Random.secure();
    return String.fromCharCodes(
      List.generate(length, (_) => random.nextInt(26) + 65), // A-Z
    );
  }

  static String _bytesToBinary(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(2).padLeft(8, '0')).join(' ');
  }

  static List<int> _binaryToBytes(String binary) {
    final binaryStrings = binary.split(' ');
    return binaryStrings.map((b) => int.parse(b, radix: 2)).toList();
  }
}