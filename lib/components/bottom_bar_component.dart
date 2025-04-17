import 'package:flutter/material.dart';

// Componente que cria uma barra de navegação inferior (bottom navigation bar)
// com múltiplas páginas que podem ser alternadas
class BottomBarComponent extends StatefulWidget {
  // Lista de páginas/widgets que serão exibidos
  final List<Widget> pages;
  
  // Construtor que exige a lista de páginas
  const BottomBarComponent({super.key, required this.pages});

  @override
  State<BottomBarComponent> createState() => _BottomBarComponentState();
}

class _BottomBarComponentState extends State<BottomBarComponent> {
  // Índice da página atualmente selecionada (inicia na primeira página)
  int _selectedIndex = 0;

  // Método chamado quando um item da barra inferior é selecionado
  void _onItemTapped(int index) {
    setState(() {
      // Atualiza o índice para a página selecionada
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cor de fundo branca para o scaffold principal
      backgroundColor: Colors.white,
      
      // IndexedStack mantém todas as páginas na memória, mas mostra apenas a selecionada
      body: IndexedStack(
        index: _selectedIndex,  // Índice da página a ser exibida
        children: widget.pages, // Lista de páginas passada como parâmetro
      ),
      
      // Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Índice do item atualmente selecionado
        onTap: _onItemTapped,         // Callback quando um item é pressionado
        selectedItemColor: Colors.red, // Cor do item selecionado (vermelho)
        unselectedItemColor: Colors.white, // Cor dos itens não selecionados (branco)
        backgroundColor: Colors.green, // Cor de fundo da barra (verde)
        
        // Itens da barra de navegação
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.numbers, size: 20), // Ícone do item
              label: 'Transposição'),              // Rótulo do item
          BottomNavigationBarItem(
              icon: Icon(Icons.numbers, size: 20), 
              label: 'Cifra de César'),
          BottomNavigationBarItem(
              icon: Icon(Icons.numbers, size: 20), 
              label: 'Chave Única'),
        ],
      ),
    );
  }
}