// Importações necessárias para codificação UTF-8 e geração de números aleatórios
import 'dart:convert';
import 'dart:math';

// Controlador da cifra XOR com chave gerada aleatoriamente
class XorCipherController {
  
  // Método para criptografar a mensagem
  static Map<String, dynamic> encrypt(String message) {
    // Valida se a mensagem está vazia
    if (message.isEmpty) {
      throw ArgumentError("A mensagem não pode estar vazia");
    }

    // Gera uma chave aleatória do mesmo tamanho da mensagem
    final key = _generateRandomKey(message.length);
    final messageBytes = utf8.encode(message); // Converte a mensagem para bytes
    final keyBytes = utf8.encode(key); // Converte a chave para bytes

    // Aplica operação XOR entre os bytes da mensagem e da chave
    final encryptedBytes = List<int>.generate(
      messageBytes.length,
      (i) => messageBytes[i] ^ keyBytes[i],
    );

    // Retorna a chave, os bytes criptografados e a versão binária dos bytes
    return {
      'key': key,
      'encrypted': encryptedBytes,
      'binary': _bytesToBinary(encryptedBytes), // Retorna a cifra em binário
    };
  }

  // Método para descriptografar usando binário e a chave original
  static String decrypt(String binary, String key) {
    // Valida se campos estão vazios
    if (binary.isEmpty || key.isEmpty) {
      throw ArgumentError("Binário e chave não podem estar vazios");
    }

    // Converte a string binária para uma lista de bytes
    final bytes = _binaryToBytes(binary);
    final keyBytes = utf8.encode(key); // Converte a chave para bytes

    // Verifica se o tamanho da chave é igual ao tamanho dos dados
    if (bytes.length != keyBytes.length) {
      throw ArgumentError("A chave deve ter o mesmo tamanho da mensagem original");
    }

    // Aplica XOR novamente para recuperar a mensagem original
    final decryptedBytes = List<int>.generate(
      bytes.length,
      (i) => bytes[i] ^ keyBytes[i],
    );

    return utf8.decode(decryptedBytes); // Converte os bytes de volta para string
  }

  // Gera uma chave aleatória (composta por letras A-Z) com tamanho igual ao da mensagem
  static String _generateRandomKey(int length) {
    final random = Random.secure(); // Usa gerador criptograficamente seguro
    return String.fromCharCodes(
      List.generate(length, (_) => random.nextInt(26) + 65), // Gera letras maiúsculas (A-Z)
    );
  }

  // Converte uma lista de bytes para uma string binária (8 bits por byte)
  static String _bytesToBinary(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(2).padLeft(8, '0')).join(' ');
  }

  // Converte uma string binária separada por espaços de volta para lista de bytes
  static List<int> _binaryToBytes(String binary) {
    final binaryStrings = binary.split(' '); // Divide os bits em blocos de 8
    return binaryStrings.map((b) => int.parse(b, radix: 2)).toList(); // Converte cada bloco para int
  }
}
