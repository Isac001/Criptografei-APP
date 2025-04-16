class UniqueKeyCipherController {
  String gerarAlfabetoComChave(String chave) {
    chave = chave.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
    String novoAlfabeto = '';

    for (var letra in chave.split('')) {
      if (!novoAlfabeto.contains(letra)) {
        novoAlfabeto += letra;
      }
    }

    for (var i = 0; i < 26; i++) {
      String letra = String.fromCharCode(65 + i);
      if (!novoAlfabeto.contains(letra)) {
        novoAlfabeto += letra;
      }
    }

    return novoAlfabeto;
  }

  String criptografar(String texto, String chave) {
    final alfabetoOriginal = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final alfabetoChave = gerarAlfabetoComChave(chave);

    return texto.split('').map((char) {
      bool isUpper = char == char.toUpperCase();
      String letra = char.toUpperCase();

      if (alfabetoOriginal.contains(letra)) {
        int index = alfabetoOriginal.indexOf(letra);
        String substituida = alfabetoChave[index];
        return isUpper ? substituida : substituida.toLowerCase();
      }
      return char;
    }).join('');
  }
}
