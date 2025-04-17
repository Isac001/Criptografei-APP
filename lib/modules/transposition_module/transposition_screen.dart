// Importações necessárias
import 'package:flutter/material.dart';
import 'package:criptografei/home/initial_screen.dart';
import 'package:criptografei/modules/transposition_module/transposition_controller.dart';
import 'package:flutter/services.dart';

// Tela da Cifra de Transposição
class TranspositionScreen extends StatefulWidget {
  const TranspositionScreen({super.key});

  @override
  State<TranspositionScreen> createState() => _TranspositionScreenState();
}

class _TranspositionScreenState extends State<TranspositionScreen> {
  // Controladores de texto para entrada e saída
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputKeyController = TextEditingController();
  final TextEditingController _outputCipherController = TextEditingController();
  final TextEditingController _decryptKeyController = TextEditingController();
  final TextEditingController _decryptCipherController =
      TextEditingController();
  final TextEditingController _decryptedTextController =
      TextEditingController();

  // Instância do controlador da cifra
  final TranspositionController _controller = TranspositionController();

  // Função para criptografar o texto
  void _criptografar() {
    try {
      final texto = _inputController.text;
      final chave = _outputKeyController.text;

      // Verifica se a chave foi preenchida
      if (chave.trim().isEmpty) {
        _showSnackBar('Digite uma chave válida!');
        return;
      }

      // Executa a criptografia
      final resultado = _controller.criptografar(texto, chave);

      // Atualiza o campo com o resultado
      setState(() {
        _outputCipherController.text = resultado;
      });
      _showSnackBar('Texto criptografado com sucesso!');
    } catch (e) {
      _showSnackBar('Erro: ${e.toString()}');
    }
  }

  // Função para descriptografar o texto
  void _descriptografar() {
    try {
      final textoCifrado = _decryptCipherController.text;
      final chave = _decryptKeyController.text;

      // Verifica se os campos estão preenchidos
      if (chave.trim().isEmpty || textoCifrado.isEmpty) {
        _showSnackBar('Preencha a chave e o texto cifrado!');
        return;
      }

      // Executa a descriptografia
      final resultado = _controller.descriptografar(textoCifrado, chave);

      // Atualiza o campo com o resultado
      setState(() {
        _decryptedTextController.text = resultado;
      });
      _showSnackBar('Texto descriptografado com sucesso!');
    } catch (e) {
      _showSnackBar('Erro: ${e.toString()}');
    }
  }

  // Copia o texto para a área de transferência
  void _copyToClipboard(String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(message);
  }

  // Exibe uma snackbar com a mensagem fornecida
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar da tela
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cifra de Transposição',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const InitialScreen()),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Seção de Criptografia
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'CRIPTOGRAFAR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Campo para digitar o texto original
                    TextField(
                      controller: _inputController,
                      decoration: InputDecoration(
                        labelText: 'Texto original',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // Campo para digitar a chave
                        Expanded(
                          child: TextField(
                            controller: _outputKeyController,
                            decoration: InputDecoration(
                              labelText: 'Chave (sem repetições)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Botão para criptografar
                        ElevatedButton(
                          onPressed: _criptografar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(100, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Criptografar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        // Campo com o texto cifrado (após criptografia)
                        Expanded(
                          child: TextField(
                            controller: _outputCipherController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Texto cifrado',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            maxLines: 3,
                          ),
                        ),
                        // Botão para copiar texto cifrado
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.red),
                          onPressed: () => _copyToClipboard(
                            _outputCipherController.text,
                            'Texto cifrado copiado!',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Seção de Descriptografia
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'DESCRIPTOGRAFAR',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Campo para digitar a chave
                    TextField(
                      controller: _decryptKeyController,
                      decoration: InputDecoration(
                        labelText: 'Cole a chave aqui',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        // Campo para digitar o texto cifrado
                        Expanded(
                          child: TextField(
                            controller: _decryptCipherController,
                            decoration: InputDecoration(
                              labelText: 'Cole o texto cifrado',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Botão para descriptografar
                        ElevatedButton(
                          onPressed: _descriptografar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(100, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Descriptografar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        // Campo com o texto descriptografado
                        Expanded(
                          child: TextField(
                            controller: _decryptedTextController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Texto descriptografado',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            maxLines: 3,
                          ),
                        ),
                        // Botão para copiar o texto descriptografado
                        IconButton(
                          icon: const Icon(Icons.copy, color: Colors.red),
                          onPressed: () => _copyToClipboard(
                            _decryptedTextController.text,
                            'Texto descriptografado copiado!',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
