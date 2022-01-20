import 'package:flutter/material.dart';
import 'package:popquiz/telas/NovoQuestionario.dart';
import 'package:popquiz/telas/PaginaInicial.dart';

class RotasDasPaginas {
  static const String ROTA_PAGINA_INICIAL = "/";
  static const String ROTA_NOVO_QUESTIONARIO = "/novoquestionario";

  static Route<dynamic> gerarRota(RouteSettings settings) {

    switch (settings.name) {
      case ROTA_PAGINA_INICIAL:
        return MaterialPageRoute(builder: (_) => PaginaInicial());
      case ROTA_NOVO_QUESTIONARIO:
        return MaterialPageRoute(builder: (_) => NovoQuestionario());
      default:
        return _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada"),
        ),
        body: Center(
          child: Text("Tela não encontrada"),
        ),
      );
    });
  }
}
