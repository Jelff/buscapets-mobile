import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String nomeUsuario;

  HomePage({required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buscapets')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bem-vindo, $nomeUsuario!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Mais de 1000 pets registrados', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
