import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:popquiz/model/Questionario.dart';
import 'package:popquiz/recursos/ApiMock.dart';
import 'package:popquiz/recursos/Constantes.dart';
import 'package:popquiz/recursos/RotasDasPaginas.dart';
import 'package:popquiz/recursos/widget/MensagemCarregando.dart';

class ApenasOsQuestionariosRespondidos extends StatefulWidget {
  const ApenasOsQuestionariosRespondidos({Key? key}) : super(key: key);

  @override
  _ApenasOsQuestionariosRespondidosState createState() =>
      _ApenasOsQuestionariosRespondidosState();
}

class _ApenasOsQuestionariosRespondidosState
    extends State<ApenasOsQuestionariosRespondidos> {
  List _listaDeQuestionarios = [];

  _recuperarQuestionariosDaApi() {
    ApiMock api = ApiMock();
    return api.recuperarListaDeQuestionarios();
  }

  Future<File> _recuperarArquivoComQuestionarios() async {
    final diretorio = await getApplicationDocumentsDirectory();
    String caminho = diretorio.path;
    return File("$caminho/questionarios.json");
  }

  _lerArquivoComQuestionarios() async {
    try {
      final arquivo = await _recuperarArquivoComQuestionarios();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _lerArquivoComQuestionarios().then((dados) {
      _listaDeQuestionarios = json.decode(dados);
    });
  }

  bool _verificarStatusDoQuestionario(String idDoQuestionario) {
    for (var map in _listaDeQuestionarios) {
      String status = map!["status"];
      String id = map["idDoQuestionario"];
      if (id==idDoQuestionario) {
        if (status=="completo") {
          print("ID completo: "+id.toString());
          return true;
        }else{
          return false;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Questionario>>(
        future: _recuperarQuestionariosDaApi(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return MensagemCarregando(texto: 'Questionários totalmente respondidos');
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar os dados!"),
                );
              } else {
                bool questionarioCompleto = false;
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    List<Questionario>? lista = snapshot.data;
                    Questionario questionario = lista![index];

                    questionarioCompleto = _verificarStatusDoQuestionario(questionario.id);
                    if (questionarioCompleto) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context,
                              RotasDasPaginas.ROTA_PERGUNTAS_DO_QUESTIONARIO,
                              arguments: questionario.id.toString());
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
                              title: Text(
                                questionario.titulo,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: tamanhoDaLetra + 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
          }
        },
      ),
    );
  }
}
