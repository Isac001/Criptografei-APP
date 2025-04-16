import 'package:flutter/material.dart';

class BottomBarComponent extends StatefulWidget {
  final List<Widget> pages;
  const BottomBarComponent({super.key, required this.pages});

  @override
  State<BottomBarComponent> createState() => _BottomBarComponentState();
}

class _BottomBarComponentState extends State<BottomBarComponent> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.numbers, size: 20), label: 'Transposição'),
          BottomNavigationBarItem(
              icon: Icon(Icons.numbers, size: 20), label: 'Cifra de César'),
          BottomNavigationBarItem(
              icon: Icon(Icons.numbers, size: 20), label: 'Chave Única'),
        ],
      ),
    );
  }
}
