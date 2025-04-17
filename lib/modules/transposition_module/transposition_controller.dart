class TranspositionController {
  String criptografar(String texto, String chave) {
    // Validações iniciais
    if (texto.isEmpty) throw ArgumentError("O texto não pode estar vazio");
    if (chave.isEmpty) throw ArgumentError("A chave não pode estar vazia");
    if (!_isValidKey(chave)) throw ArgumentError("A chave não pode ter letras repetidas");

    // Pré-processamento
    texto = texto.replaceAll(' ', '').toUpperCase();
    chave = chave.toUpperCase();
    final chaveChars = chave.split('');

    // Cálculo da matriz
    final numCols = chave.length;
    final numRows = (texto.length / numCols).ceil();

    // Preenchimento da matriz com tratamento para texto incompleto
    final matriz = List.generate(
      numRows,
      (r) => List.generate(
        numCols,
        (c) {
          final index = r * numCols + c;
          return index < texto.length ? texto[index] : 'X'; // Padding opcional
        },
      ),
    );

    // Ordenação das colunas pela chave
    final colunasOrdenadas = chaveChars
        .asMap()
        .entries
        .sorted((a, b) => a.value.compareTo(b.value))
        .map((e) => e.key)
        .toList();

    // Leitura por colunas ordenadas
    final buffer = StringBuffer();
    for (final col in colunasOrdenadas) {
      for (var r = 0; r < numRows; r++) {
        buffer.write(matriz[r][col]);
      }
    }

    return buffer.toString();
  }

  String descriptografar(String textoCifrado, String chave) {
    if (textoCifrado.isEmpty) throw ArgumentError("O texto cifrado não pode estar vazio");
    if (chave.isEmpty) throw ArgumentError("A chave não pode estar vazia");
    if (!_isValidKey(chave)) throw ArgumentError("A chave não pode ter letras repetidas");

    chave = chave.toUpperCase();
    final chaveChars = chave.split('');
    
    final numCols = chave.length;
    final numRows = (textoCifrado.length / numCols).ceil();
    
    // Ordena as colunas pela chave original
    final colunasOrdenadas = chaveChars
        .asMap()
        .entries
        .sorted((a, b) => a.value.compareTo(b.value))
        .map((e) => e.key)
        .toList();
    
    // Calcula o tamanho de cada coluna
    final colSizes = List<int>.filled(numCols, numRows);
    final remainder = textoCifrado.length % numCols;
    for (var i = 0; i < remainder; i++) {
      colSizes[colunasOrdenadas[i]]--;
    }
    
    // Reconstrói a matriz
    final matriz = List.generate(numRows, (_) => List<String>.filled(numCols, ''));
    var pos = 0;
    
    for (final col in colunasOrdenadas) {
      for (var r = 0; r < colSizes[col]; r++) {
        if (pos < textoCifrado.length) {
          matriz[r][col] = textoCifrado[pos];
          pos++;
        }
      }
    }
    
    // Lê a matriz na ordem original
    final buffer = StringBuffer();
    for (var r = 0; r < numRows; r++) {
      for (var c = 0; c < numCols; c++) {
        if (matriz[r][c].isNotEmpty) {
          buffer.write(matriz[r][c]);
        }
      }
    }
    
    return buffer.toString();
  }

  bool _isValidKey(String chave) {
    final chars = chave.toUpperCase().split('');
    return chars.length == chars.toSet().length;
  }
}

extension SortedIterable<E> on Iterable<E> {
  Iterable<E> sorted([int Function(E, E)? compare]) => toList()..sort(compare);
}