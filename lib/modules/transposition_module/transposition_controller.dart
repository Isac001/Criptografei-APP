class TranspositionController {
  String criptografar(String texto, String chave) {
    texto = texto.replaceAll(' ', '');
    chave = chave.toUpperCase();

    final int numCols = chave.length;
    final int numRows = (texto.length / numCols).ceil();

    List<List<String>> matriz = List.generate(
      numRows,
      (_) => List.generate(numCols, (_) => ''),
    );

    int index = 0;
    for (int r = 0; r < numRows; r++) {
      for (int c = 0; c < numCols; c++) {
        if (index < texto.length) {
          matriz[r][c] = texto[index];
          index++;
        }
      }
    }

    List<MapEntry<int, String>> colunas =
        chave.split('').asMap().entries.toList();
    colunas.sort((a, b) => a.value.compareTo(b.value));

    String resultado = '';
    for (var col in colunas) {
      int colunaIndex = col.key;
      for (int r = 0; r < numRows; r++) {
        resultado += matriz[r][colunaIndex];
      }
    }

    return resultado;
  }
}
