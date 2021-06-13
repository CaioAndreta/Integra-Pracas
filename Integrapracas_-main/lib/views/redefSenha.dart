import 'package:flutter/material.dart';

class RedefinirSenha extends StatelessWidget {
  const RedefinirSenha
({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 50),
                Container(
                    alignment: Alignment.centerLeft, child: Text('Seu texto')),
                SizedBox(height: 3),
                TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(border: OutlineInputBorder())),
                SizedBox(height: 80),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue, padding: EdgeInsets.all(30)),
                    child: const Text('Adicionar Comentário'),
                    onPressed: (){},),
              ],
            ),
          )
        ]));
  }
}