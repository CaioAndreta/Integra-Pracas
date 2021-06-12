import 'package:flutter/material.dart';
import 'package:integrapracas/views/listaPracas.dart';
import 'package:integrapracas/views/login.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}