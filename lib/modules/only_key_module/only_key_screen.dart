import 'package:criptografei/modules/only_key_module/only_key_controller.dart';
import 'package:flutter/material.dart';

class UniqueKeyCipherScreen extends StatefulWidget {
  const UniqueKeyCipherScreen({super.key});

  @override
  State<UniqueKeyCipherScreen> createState() => _UniqueKeyCipherScreenState();
}

class _UniqueKeyCipherScreenState extends State<UniqueKeyCipherScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  final UniqueKeyCipherController _controller = UniqueKeyCipherController();

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

        title: Text('Criptografia por Chave Única'),
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
                  labelText: 'Digite a chave (ex: SEGREDO)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _criptografar,
                child: Text('Criptografar com chave'),
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
