class CaesarCipherController {
  final int deslocamento;

  CaesarCipherController({this.deslocamento = 3});

  String criptografar(String texto) {
    return texto.split('').map((char) {
      if (char.contains(RegExp(r'[a-zA-Z]'))) {
        int base = char.codeUnitAt(0).isUpperCase ? 65 : 97;
        return String.fromCharCode(
          (char.codeUnitAt(0) - base + deslocamento) % 26 + base,
        );
      }
      return char;
    }).join('');
  }
}

extension on int {
  bool get isUpperCase => this >= 65 && this <= 90;
}
