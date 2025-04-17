// Importações necessárias
import 'package:criptografei/home/initial_screen.dart'; // Tela inicial do app
import 'package:flutter/material.dart'; // Framework UI principal do Flutter

// Função principal do aplicativo, ponto de entrada
void main() {
  runApp(const MyApp()); // Executa o app chamando o widget raiz
}

// Widget principal do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Construtor com chave opcional

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa "Debug" do canto superior direito
      home: InitialScreen(), // Define a tela inicial do app
    );
  }
}
