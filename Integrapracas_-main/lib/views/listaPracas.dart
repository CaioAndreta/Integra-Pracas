import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:integrapracas/views/infoPraca.dart';
import 'package:integrapracas/views/login.dart';
import 'package:geolocator/geolocator.dart';

class ListaPracas extends StatefulWidget {
  const ListaPracas({Key? key}) : super(key: key);

  @override
  _ListaPracasState createState() => _ListaPracasState();
}

class _ListaPracasState extends State<ListaPracas> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  getLocalizacao() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  testarloc() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    return isLocationServiceEnabled;
  }

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    return Scaffold(
        key: _scaffoldKey,
        drawer: SideDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Praças', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('pracas').orderBy('nome').snapshots(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) {
                return Text('Loading');
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (_, index) {
                    var doc = snapshot.data!.docs[index];
                    return Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 220,
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          var idPraca = doc.id;
                          Navigator.of(context)
                              .pushNamed('/comments', arguments: idPraca);
                        },
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Image.asset('${doc.id}_1.png'),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(height: 20),
                                      Center(
                                        child: Text(doc['nome'],
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Text('A 5Km',
                                          style: TextStyle(fontSize: 18.0)),
                                      Expanded(child: Container()),
                                      Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          child: Text(doc['endereço'])),
                                      Container(height: 50)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }));
  }
}

class SideDrawer extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Column(
                children: [
                  Text(
                    '${auth.currentUser?.displayName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text(
                    '${auth.currentUser?.email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
