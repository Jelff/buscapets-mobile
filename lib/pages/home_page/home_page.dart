import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String nomeUsuario;

  HomePage({required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscapets')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo, $nomeUsuario!', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Text('Mais de 1000 pets registrados', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
