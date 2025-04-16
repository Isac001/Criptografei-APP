import 'package:criptografei/modules/transposition_module/transposition_controller.dart';
import 'package:flutter/material.dart';

class TranspositionCipherScreen extends StatefulWidget {
  const TranspositionCipherScreen({super.key});

  @override
  State<TranspositionCipherScreen> createState() =>
      _TranspositionCipherScreenState();
}

class _TranspositionCipherScreenState extends State<TranspositionCipherScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  final TranspositionCipherController _controller =
      TranspositionCipherController();

  void _criptografar() {
    final texto = _inputController.text;
    final chave = _keyController.text;

    if (chave.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Digite uma chave válida!')),
      );
      return;
    }

    final resultado = _controller.criptografar(texto, chave);

    setState(() {
      _outputController.text = resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cifra de Transposição'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _inputController,
                decoration: InputDecoration(
                  labelText: 'Digite o texto',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _keyController,
                decoration: InputDecoration(
                  labelText: 'Digite a chave (palavra)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _criptografar,
                child: Text('Criptografar'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _outputController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Texto criptografado',
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(),
                  filled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
