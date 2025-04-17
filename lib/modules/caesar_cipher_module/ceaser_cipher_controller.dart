// Classe responsável por realizar a criptografia e descriptografia usando a Cifra de César
class CaesarCipherController {
  int _deslocamento;

  // Construtor com valor padrão de deslocamento 3
  CaesarCipherController({int deslocamento = 3}) : _deslocamento = deslocamento;

  // Getter do deslocamento
  int get deslocamento => _deslocamento;

  // Setter do deslocamento (garante que o valor fique entre 0 e 25)
  set deslocamento(int value) {
    _deslocamento = value % 26; // Garante que o deslocamento fique dentro do intervalo do alfabeto (26 letras)
  }

  // Função para criptografar um texto
  String criptografar(String texto) {
    return _processarTexto(texto, _deslocamento);
  }

  // Função para descriptografar um texto (usa o deslocamento negativo)
  String descriptografar(String textoCifrado) {
    return _processarTexto(textoCifrado, -_deslocamento);
  }

  // Função interna que aplica o deslocamento (positivo ou negativo) em cada caractere
  String _processarTexto(String texto, int shift) {
    return texto.split('').map((char) {
      // Verifica se o caractere é uma letra (maiúscula ou minúscula)
      if (char.contains(RegExp(r'[a-zA-Z]'))) {
        // Define a base: 65 para 'A' (maiúsculas) ou 97 para 'a' (minúsculas)
        int base = char.codeUnitAt(0).isUpperCase ? 65 : 97;
        // Aplica o deslocamento circular e retorna o novo caractere
        return String.fromCharCode(
          (char.codeUnitAt(0) - base + shift) % 26 + base,
        );
      }
      // Se não for letra (ex: espaço, número, pontuação), mantém o caractere original
      return char;
    }).join(''); // Junta os caracteres transformados de volta em uma única string
  }
}

// Extensão para verificar se um caractere (representado por seu código ASCII) é uma letra maiúscula
extension on int {
  bool get isUpperCase => this >= 65 && this <= 90;
}
