import 'package:flutter/material.dart';
import 'package:popquiz/telas/NovoQuestionario.dart';
import 'package:popquiz/telas/PaginaInicial.dart';
import 'package:popquiz/telas/PerguntasDoQuestionario.dart';

class RotasDasPaginas {
  static const String ROTA_PAGINA_INICIAL = "/";
  static const String ROTA_NOVO_QUESTIONARIO = "/novoquestionario";
  static const String ROTA_PERGUNTAS_DO_QUESTIONARIO = "/perguntasdoquestionario";

  static Route<dynamic> gerarRota(RouteSettings settings) {
    final argumentoInformado = settings.arguments;

    switch (settings.name) {
      case ROTA_PAGINA_INICIAL:
        return MaterialPageRoute(builder: (_) => PaginaInicial());
      case ROTA_NOVO_QUESTIONARIO:
        return MaterialPageRoute(builder: (_) => NovoQuestionario());
      case ROTA_PERGUNTAS_DO_QUESTIONARIO:
        return MaterialPageRoute(builder: (_) => PerguntasDoQuestionario(argumentoInformado as String));
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
