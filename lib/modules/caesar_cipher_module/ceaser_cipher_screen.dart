import 'package:criptografei/home/initial_screen.dart';
import 'package:criptografei/modules/caesar_cipher_module/ceaser_cipher_controller.dart';
import 'package:flutter/material.dart';

class CaeserCipherScreen extends StatefulWidget {
  const CaeserCipherScreen({super.key});

  @override
  State<CaeserCipherScreen> createState() => _CaeserCipherScreenState();
}

class _CaeserCipherScreenState extends State<CaeserCipherScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  final CaesarCipherController _controller =
      CaesarCipherController(deslocamento: 3);

  void _criptografar() {
    final textoCriptografado = _controller.criptografar(_inputController.text);
    setState(() {
      _outputController.text = textoCriptografado;
    });
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
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const InitialScreen()),
            );
          },
        ),
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
                  labelText: 'Digite sua frase',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _criptografar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text('Criptografar',
                    style: TextStyle(color: Colors.red)),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _outputController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Texto criptografado',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
