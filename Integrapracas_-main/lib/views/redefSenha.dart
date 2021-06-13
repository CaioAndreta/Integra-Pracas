import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RedefinirSenha extends StatelessWidget {
  const RedefinirSenha({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final redefineSenha = new TextEditingController();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              Text('Redefinir a Senha', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black),
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Text(
                        'Insira o email da sua conta para redefinir a senha. Enviaremos uma confirmação para verificar se o dono da conta solicitou a mudança.')),
                SizedBox(height: 8),
                TextFormField(
                    controller: redefineSenha,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Email')),
                SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue, padding: EdgeInsets.all(30)),
                  child: const Text('Redefinir senha'),
                  onPressed: () {
                      firebaseAuth.sendPasswordResetEmail(email: redefineSenha.text.trim());
                    },
                    ),
                    ],
                    ),
                    ),
                    ],
                    ),
                    );
                    }
                    }
