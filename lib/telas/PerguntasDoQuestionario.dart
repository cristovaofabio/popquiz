import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:popquiz/main.dart';
import 'package:popquiz/model/Pergunta.dart';
import 'package:popquiz/recursos/ApiMock.dart';
import 'package:popquiz/recursos/Constantes.dart';
import 'package:popquiz/recursos/RotasDasPaginas.dart';

class PerguntasDoQuestionario extends StatefulWidget {
  late final String _idDoQuestionario;
  PerguntasDoQuestionario(this._idDoQuestionario);

  @override
  _PerguntasDoQuestionarioState createState() =>
      _PerguntasDoQuestionarioState();
}

class _PerguntasDoQuestionarioState extends State<PerguntasDoQuestionario> {
  _listarPerguntasDoQuestionario(String idDoQuestionario) {
    ApiMock api = ApiMock();
    return api.recuperarPergunstasDoQuestionario(idDoQuestionario);
  }

  _mudarParaATelaNovaPergunta() {
    //Verificar isso!
    Navigator.pushReplacementNamed(context, RotasDasPaginas.ROTA_NOVA_PERGUNTA,
        arguments: widget._idDoQuestionario.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todas as perguntas"),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: temaPadrao.buttonColor,
        onPressed: _mudarParaATelaNovaPergunta,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<Pergunta>>(
        future: _listarPerguntasDoQuestionario(widget._idDoQuestionario),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  color: temaPadrao.buttonColor,
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar os dados!"),
                );
              } else {
                int quantidadeDePerguntas = snapshot.data!.length;
                if (quantidadeDePerguntas == 0) {
                  return Lottie.asset("assets/animacaoNenhumaPergunta.json");
                } else {
                  return ListView.builder(
                    itemCount: quantidadeDePerguntas,
                    itemBuilder: (context, index) {
                      List<Pergunta>? lista = snapshot.data;
                      Pergunta pergunta = lista![index];

                      return GestureDetector(
                        onTap: () {
                          print('ID: ${pergunta.id} selecionado');
                        },
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(curvaturas),
                            side: BorderSide(color: Colors.grey, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(pergunta.texto),
                              subtitle: Text(pergunta.descricao),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
          }
        },
      ),
    );
  }
}
