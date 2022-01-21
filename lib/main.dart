import 'package:flutter/material.dart';
import 'package:popquiz/recursos/RotasDasPaginas.dart';
import 'package:popquiz/telas/PaginaInicial.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
    ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

final ThemeData temaPadrao = ThemeData(
  primaryColor: Colors.white,
  accentColor: Colors.grey,
  backgroundColor: Colors.grey[300],
  buttonColor: Colors.green[400],
);

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MaterialApp(
      home: PaginaInicial(),
      theme: temaPadrao,
      debugShowCheckedModeBanner: false,
      title: "PopQuiz",
      initialRoute: "/",
      onGenerateRoute: RotasDasPaginas.gerarRota,
    ),
  );
}
