import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:integrapracas/views/login.dart';

class AlterarDadosView extends StatefulWidget {
  @override
  _AlterarDadosViewState createState() => _AlterarDadosViewState();
}

class _AlterarDadosViewState extends State<AlterarDadosView> {
  final formKey = GlobalKey<FormState>();
  final emailController = new TextEditingController();
  final usuarioController = new TextEditingController();
  final senhaController = new TextEditingController();
  final senhaConfirmController = new TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              tituloAlterarDados(),
              Container(
                padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputNome(controller: usuarioController),
                    SizedBox(height: 10),
                    InputEmail(controller: emailController),
                    SizedBox(height: 10),
                    InputSenha(controller: senhaController),
                    SizedBox(height: 10),
                    InputConfirmarSenha(),
                    SizedBox(height: 10),
                    Termos(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BotaoVoltar(),
                        botaoConfirmar(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget tituloAlterarDados() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Text('Alterar Dados',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
    );
  }

  Widget botaoConfirmar() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
        child: const Text('Confirmar'),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text('Cadastro efetuado com sucesso!'),
              ));
            Navigator.of(context).pushNamed('/');
          }
        });
  }
}

class InputNome extends StatefulWidget {
  final TextEditingController controller;

  const InputNome({Key? key,
  required this.controller,})  : super(key: key);
  
  @override
  _InputNomeState createState() => _InputNomeState();
}

class _InputNomeState extends State<InputNome> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.centerLeft, child: Text('Nome:')),
        SizedBox(height: 3),
        Center(
            child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Insira um Nome';
                  } else if (value.length < 3) {
                    return 'O nome deve ter mais de 3 caracteres';
                  }
                  return null;
                },
                controller: widget.controller)),
      ],
    );
  }
}

class InputSenha extends StatefulWidget {
  final TextEditingController controller;

  const InputSenha({
    Key? key,
    required this.controller,
    }) : super(key: key);

  @override
  _InputSenhaState createState() => _InputSenhaState();
}

class _InputSenhaState extends State<InputSenha> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.centerLeft, child: Text('Senha:')),
        SizedBox(height: 3),
        Center(
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Senha'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Insira uma senha';
              } else if (value.length < 6) {
                return 'A senha deve ter mais de 6 caracteres';
              }
              return null;
            },
            controller: widget.controller,
          ),
        )
      ],
    );
  }
}

class InputConfirmarSenha extends StatefulWidget {
  const InputConfirmarSenha({Key? key}) : super(key: key);

  @override
  _InputConfirmarSenhaState createState() => _InputConfirmarSenhaState();
}

class _InputConfirmarSenhaState extends State<InputConfirmarSenha> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: Text('Confirme a sua senha:')),
        SizedBox(height: 3),
        Center(
            child: TextFormField(
                controller: _AlterarDadosViewState().senhaConfirmController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirmação da senha'),
                validator: (value) {
                  if (_AlterarDadosViewState().senhaController.text !=
                      _AlterarDadosViewState().senhaConfirmController.text) {
                    return 'As senhas não são iguais';
                  }
                  return null;
                })),
      ],
    );
  }
}

class InputEmail extends StatefulWidget {
  final TextEditingController controller;

  const InputEmail({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(alignment: Alignment.centerLeft, child: Text('Email:')),
        SizedBox(height: 3),
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.emailAddress,
          decoration:
              InputDecoration(hintText: 'Email', border: OutlineInputBorder()),
          validator: (email) {
            if ((email!.isEmpty)) {
              return 'Insira um email';
            } else if (!EmailValidator.validate(email)) {
              return 'Email Inválido';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class BotaoVoltar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          side: BorderSide(color: Colors.black)),
      child: Text(
        'Voltar',
        style: TextStyle(color: Colors.black87),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed('/');
      },
    );
  }
}

class Termos extends StatefulWidget {
  @override
  _TermosState createState() => _TermosState();
}

class _TermosState extends State<Termos> {
  bool valor = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: valor,
        onChanged: (value) {
          setState(() {
            valor = !valor;
          });
        },
        title: Text('Aceito os Termos de Uso'),
      ),
    );
  }
}