import 'package:flutter/material.dart';
import 'package:integrapracas/views/alterarDados.dart';
import 'package:integrapracas/views/cadastro.dart';
import 'package:integrapracas/views/comentarioPraca.dart';
import 'package:integrapracas/views/infoPraca.dart';
import 'package:integrapracas/views/listaPracas.dart';
import 'package:integrapracas/views/login.dart';
import 'package:integrapracas/views/redefSenha.dart';
import 'package:integrapracas/views/userComments.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ValueCategoria(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoginView(),
          '/cadastro': (context) => CadastroView(),
          '/edita':(context) => AlterarDadosView(),
          '/redefinir-senha': (context) => RedefinirSenha(),
          '/pracas': (context) => ListaPracas(),
          '/addcomment': (context) => ComentarioPraca(),
          '/comments': (context) => InfoPracaView(),
          '/my-comments': (context) => UserComments()
        },
      ),
    );
  }
}