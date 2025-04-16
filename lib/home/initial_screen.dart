import 'package:criptografei/components/bottom_bar_component.dart';
import 'package:criptografei/modules/caesar_cipher_module/ceaser_cipher_screen.dart';
import 'package:criptografei/modules/unique_key_module/unnique_key_screen.dart';
import 'package:criptografei/modules/transposition_module/transposition_screen.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        title: Text(
          'Bem-vindo ao Criptografei!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomBarComponent(
                          pages: [
                            TranspositionScreen(),
                            CaeserCipherScreen(),
                            UniqueKeyCipherScreen(),
                          ],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 60),
                      backgroundColor: Colors.white,
                      elevation: 10),
                  child: const Text(
                    'Entrar no APP',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(
                            'Créditos',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Fechar',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red),
                              ),
                            )
                          ],
                          content: Text(
                            'Trabalho desenvolvido por:\n\nIsac Diógenes\nJoão Victor',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 60),
                      backgroundColor: Colors.white,
                      elevation: 10),
                  child: const Text(
                    'Créditos',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
