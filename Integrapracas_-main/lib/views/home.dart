import 'package:flutter/material.dart';
import 'package:integrapracas/views/cadastro.dart';
import 'package:integrapracas/views/comentarioPraca.dart';
import 'package:integrapracas/views/infoPraca.dart';
import 'package:integrapracas/views/listaPracas.dart';
import 'package:integrapracas/views/login.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginView(),
        '/cadastro': (context) => CadastroView(),
        '/pracas': (context) => ListaPracas(),
        '/addcomment': (context) => ComentarioPraca(),
        '/comments': (context) => InfoPracaView()
      },
    );
  }
}