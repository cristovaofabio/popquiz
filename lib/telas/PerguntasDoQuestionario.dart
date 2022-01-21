import 'package:flutter/material.dart';
import 'package:popquiz/main.dart';
import 'package:popquiz/model/Pergunta.dart';
import 'package:popquiz/recursos/ApiMock.dart';
import 'package:popquiz/recursos/Constantes.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todas as perguntas"),
        elevation: 0,
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
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      List<Pergunta>? lista = snapshot.data;
                      if(lista!.isEmpty){
                        //return ;
                      }
                      Pergunta pergunta = lista[index];

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
                    });
              }
          }
        },
      ),
    );
  }
}
