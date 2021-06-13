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
    var id = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Praça das flores',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          Image.asset('assets/praca.png'),
          SizedBox(
              height: 100,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushNamed('/addcomment', arguments: id);
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
                        .where('praca', isEqualTo: id)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Text('Loading');
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
                                  CircleAvatar(),
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
                                            Text(doc['comentario'])
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
