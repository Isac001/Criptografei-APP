import 'package:criptografei/modules/caesar_cipher_module/ceaser_cipher_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:criptografei/home/initial_screen.dart';

class CaeserCipherScreen extends StatefulWidget {
  const CaeserCipherScreen({super.key});

  @override
  State<CaeserCipherScreen> createState() => _CaeserCipherScreenState();
}

class _CaeserCipherScreenState extends State<CaeserCipherScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _shiftController = TextEditingController(text: '3');
  final TextEditingController _outputCipherController = TextEditingController();
  final TextEditingController _decryptInputController = TextEditingController();
  final TextEditingController _decryptedTextController = TextEditingController();

  late CaesarCipherController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CaesarCipherController();
    _shiftController.addListener(_updateShift);
  }

  @override
  void dispose() {
    _shiftController.removeListener(_updateShift);
    super.dispose();
  }

  void _updateShift() {
    final shift = int.tryParse(_shiftController.text) ?? 3;
    _controller.deslocamento = shift;
  }

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

  void _copyToClipboard(String text, String message) {
    if (text.isEmpty) {
      _showSnackBar('Nada para copiar!');
      return;
    }
    Clipboard.setData(ClipboardData(text: text));
    _showSnackBar(message);
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Configuração do deslocamento
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