import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/models/praca.dart';
import 'package:integrapracas/views/comentarioPraca.dart';
import 'package:integrapracas/views/listaPracas.dart';

class InfoPracaView extends StatefulWidget {
  const InfoPracaView({Key? key}) : super(key: key);

  @override
  _InfoPracaViewState createState() => _InfoPracaViewState();
}

class _InfoPracaViewState extends State<InfoPracaView> {
  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    var dadosPraca = ModalRoute.of(context)!.settings.arguments as Praca;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${dadosPraca.nome}',
          // _firestore.collection("pracas").doc("${id}").toString(),
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          Image.asset('assets/${dadosPraca.id}_1.png'),
          SizedBox(
              height: 100,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushNamed('/addcomment', arguments: dadosPraca.id);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.message,
                      color: Colors.black,
                    ),
                    Text('Adicionar Comentário',
                        style: TextStyle(color: Colors.black)),
                  ],
                ),
              )),
          Expanded(
            child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('comentarios')
                        .where('praca', isEqualTo: dadosPraca.id)
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Ainda não há comentários para essa praça');
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            var doc = snapshot.data!.docs[index];
                            return Container(
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(doc['usuario']),
                                            Text(doc['comentario']),
                                            Text(doc['categoria'])
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    })),
          )
        ],
      ),
    );
  }
}
