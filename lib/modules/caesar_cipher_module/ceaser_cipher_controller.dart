class CaesarCipherController {
  int _deslocamento;

  CaesarCipherController({int deslocamento = 3}) : _deslocamento = deslocamento;

  // Getter and setter for the shift amount
  int get deslocamento => _deslocamento;
  set deslocamento(int value) {
    _deslocamento = value % 26; // Ensure it stays within alphabet bounds
  }

  String criptografar(String texto) {
    return _processarTexto(texto, _deslocamento);
  }

  String descriptografar(String textoCifrado) {
    return _processarTexto(textoCifrado, -_deslocamento);
  }

  String _processarTexto(String texto, int shift) {
    return texto.split('').map((char) {
      if (char.contains(RegExp(r'[a-zA-Z]'))) {
        int base = char.codeUnitAt(0).isUpperCase ? 65 : 97;
        return String.fromCharCode(
          (char.codeUnitAt(0) - base + shift) % 26 + base,
        );
      }
      return char;
    }).join('');
  }
}

extension on int {
  bool get isUpperCase => this >= 65 && this <= 90;
}