import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/models/usuario.dart';
import 'package:integrapracas/views/cadastro.dart';
import 'package:integrapracas/widgets/widgets.dart';

class ComentarioPraca extends StatelessWidget {
  const ComentarioPraca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    var db = FirebaseFirestore.instance;
    var comentarioPraca = new TextEditingController();
    var id = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Praças', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          leading: BackButton(color: Colors.black),
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.centerLeft, child: Text('Categoria')),
                SizedBox(height: 3),
                Categorias(),
                SizedBox(height: 50),
                Container(
                    alignment: Alignment.centerLeft, child: Text('Seu texto')),
                SizedBox(height: 3),
                TextFormField(
                    controller: comentarioPraca,
                    maxLines: 5,
                    decoration: InputDecoration(border: OutlineInputBorder())),
                SizedBox(height: 80),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue, padding: EdgeInsets.all(30)),
                    child: const Text('Adicionar Comentário'),
                    onPressed: () {
                      db.collection('comentarios').add({
                        'usuario': user!.displayName,
                        'categoria': '',
                        'comentario': comentarioPraca.text,
                        'praca': id,
                        'time': DateTime.now()
                      });
                      Navigator.pop(context);
                    }),
              ],
            ),
          )
        ]));
  }
}

class Categorias extends StatefulWidget {
  const Categorias({Key? key}) : super(key: key);

  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  @override
  Widget build(BuildContext context) {
    String? categoriaValue;
    return DropdownButtonFormField<String>(
      value: categoriaValue,
      items: ["Manutenção", "Sugestão de Melhoria", "Evento"]
          .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          categoriaValue = value!;
          print(categoriaValue);
        });
      },
    );
  }
}

class ValueCategoria extends ChangeNotifier {
  String? categoriaValue;

  String? get getCategoriaValue => this.categoriaValue;
  set setCategoriaValue(String? categoriaValue) => this.categoriaValue = categoriaValue;
}
