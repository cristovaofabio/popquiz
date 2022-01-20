import 'package:flutter/material.dart';
import 'package:popquiz/recursos/RotasDasPaginas.dart';
import 'package:popquiz/telas/PaginaInicial.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Colors.white,
  accentColor: Colors.grey,
  backgroundColor: Colors.grey[300],
  buttonColor: Colors.green[400],
);

void main() {
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
