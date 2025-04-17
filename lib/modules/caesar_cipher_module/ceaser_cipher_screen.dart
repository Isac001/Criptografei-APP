// Importações necessárias
import 'package:criptografei/modules/caesar_cipher_module/ceaser_cipher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:criptografei/home/initial_screen.dart';

// Tela da Cifra de César
class CaeserCipherScreen extends StatefulWidget {
  const CaeserCipherScreen({super.key});

  @override
  State<CaeserCipherScreen> createState() => _CaeserCipherScreenState();
}

class _CaeserCipherScreenState extends State<CaeserCipherScreen> {
  // Controladores de texto para os campos da interface
  final TextEditingController _inputController = TextEditingController(); // Texto original
  final TextEditingController _shiftController = TextEditingController(text: '3'); // Deslocamento padrão
  final TextEditingController _outputCipherController = TextEditingController(); // Texto criptografado
  final TextEditingController _decryptInputController = TextEditingController(); // Texto cifrado para descriptografar
  final TextEditingController _decryptedTextController = TextEditingController(); // Resultado descriptografado

  // Controlador da lógica da Cifra de César
  late CaesarCipherController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CaesarCipherController(); // Instancia o controlador
    _shiftController.addListener(_updateShift); // Atualiza deslocamento sempre que o campo for alterado
  }

  @override
  void dispose() {
    _shiftController.removeListener(_updateShift);
    super.dispose();
  }

  // Atualiza o valor do deslocamento na lógica
  void _updateShift() {
    final shift = int.tryParse(_shiftController.text) ?? 3;
    _controller.deslocamento = shift;
  }

  // Função para criptografar o texto
  void _criptografar() {
    try {
      final resultado = _controller.criptografar(_inputController.text);
      setState(() {
        _outputCipherController.text = resultado;
      });
    } catch (e) {
      _showSnackBar('Erro ao criptografar: ${e.toString()}');
    }
  }

  // Função para descriptografar o texto
  void _descriptografar() {
    try {
      final resultado = _controller.descriptografar(_decryptInputController.text);
      setState(() {
        _decryptedTextController.text = resultado;
      });
    } catch (e) {
      _showSnackBar('Erro ao descriptografar: ${e.toString()}');
    }
  }

  // Copia texto para a área de transferência e mostra mensagem
  void _copyToClipboard(String text, String message) {
    if (text.isEmpty) {
      _showSnackBar('Nada para copiar!');
      return;
    }
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(message);
  }

  // Exibe uma snackbar com a mensagem desejada
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Interface da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar com botão de voltar
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cifra de César',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
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

      // Corpo da tela com rolagem
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            // Card para configurar o deslocamento
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Configuração',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _shiftController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Número de casas (1-25)',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Seção de Criptografia
            Card(
              elevation: 4,
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
                    TextField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        labelText: 'Texto original',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _criptografar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('CRIPTOGRAFAR'),
                    ),
                    const SizedBox(height: 16),

                    // Campo com resultado da criptografia
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _outputCipherController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Texto cifrado',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            maxLines: 3,
                          ),
                        ),
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
              elevation: 4,
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
                    TextField(
                      controller: _decryptInputController,
                      decoration: const InputDecoration(
                        labelText: 'Texto cifrado',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _descriptografar,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('DESCRIPTOGRAFAR'),
                    ),
                    const SizedBox(height: 16),

                    // Campo com texto descriptografado
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _decryptedTextController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Texto descriptografado',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            maxLines: 3,
                          ),
                        ),
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
