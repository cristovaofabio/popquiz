import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
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
  TextEditingController _controllerResposta = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List _listaDeRespostas = [];
  List _listaDeQuestionarios = [];

  _listarPerguntasDoQuestionario(String idDoQuestionario) {
    ApiMock api = ApiMock();
    return api.recuperarPergunstasDoQuestionario(idDoQuestionario);
  }

  _mudarParaATelaNovaPergunta() {
    Navigator.pushReplacementNamed(context, RotasDasPaginas.ROTA_NOVA_PERGUNTA,
        arguments: widget._idDoQuestionario.toString());
  }

  _verRespostaDaPergunta(String idDaPergunta) {

    for (var map in _listaDeRespostas) {
      if (map?.containsKey("idDaPergunta") ?? false) {
        if (map!["idDaPergunta"] == idDaPergunta) {
          return showDialog(
            context: context,
            builder: (builder) {
              return AlertDialog(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(curvaturas),
                ),
                title: Text('Resposta!'),
                content: Text(map!["texto"]),
              );
            },
          );
        }
      }
    }
  }

  Future<void> _atualizarStatusQuestionario(String statusDoQuestionario) async {
    String idDoQuestionario = widget._idDoQuestionario.toString();

    Map<String, dynamic> resposta = Map();
    resposta["idDoQuestionario"] = idDoQuestionario;
    resposta["status"] = statusDoQuestionario;

    try{
      _listaDeQuestionarios.removeWhere((element) => element["idDoQuestionario"] == idDoQuestionario);
    }catch(erro){

    }
    _listaDeQuestionarios.add(resposta);

    await _atualizarArquivoComQuestionarios();
  }

  Future<void> _atualizarArquivoComQuestionarios() async {
    var arquivo = await _recuperarArquivoComQuestionarios();
    String dados = json.encode(_listaDeQuestionarios);
    arquivo.writeAsString(dados);
  }

  Future<File> _recuperarArquivoComQuestionarios() async {
    final diretorio = await getApplicationDocumentsDirectory();
    String caminho = diretorio.path;
    return File("$caminho/questionarios.json");
  }

  Future<void> _salvarResposta(String idDaPergunta) async {
    String _respostaInformada = _controllerResposta.text;
    String idDoQuestionario = widget._idDoQuestionario.toString();

    Map<String, dynamic> resposta = Map();

    resposta["id"] = idDaPergunta.toString() + idDoQuestionario; //ID da resposta
    resposta["idDaPergunta"] = idDaPergunta.toString();
    resposta["idDoQuestionario"] = idDoQuestionario;
    resposta["texto"] = _respostaInformada;

    setState(() {
      _listaDeRespostas.add(resposta);
    });

    _controllerResposta.text = "";
    await _atualizarArquivoComRespostas();
  }

  Future<void> _atualizarArquivoComRespostas() async {
    var arquivo = await _recuperarArquivoComRespostas();
    String dados = json.encode(_listaDeRespostas);
    arquivo.writeAsString(dados);
  }

  Future<File> _recuperarArquivoComRespostas() async {
    final diretorio = await getApplicationDocumentsDirectory();
    String caminho = diretorio.path;
    return File("$caminho/respostas.json");
  }

  _lerArquivoComRespostas() async {
    try {
      final arquivo = await _recuperarArquivoComRespostas();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  _lerArquivoComQuestionarios() async {
    try {
      final arquivo = await _recuperarArquivoComQuestionarios();
      return arquivo.readAsString();
    } catch (e) {
      return null;
    }
  }

  _caixaAlerta(context, bool perguntaTemRespota, String idDaPergunta,
      String textoPrimeiroBotao, String textoSegundoBotao) {
    return showDialog(
      barrierDismissible: false, //não pode fechar o dialog quando houver clique fora dele
      context: context,
      builder: (builder) {
        return AlertDialog(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(curvaturas),
          ),
          title: Text(
            !perguntaTemRespota
                ? 'Adicionar resposta'
                : 'Deseja ver a sua resposta?',
          ),
          content: !perguntaTemRespota
              ? TextField(
                  decoration: InputDecoration(labelText: "Digite a sua resposta"),
                  controller: _controllerResposta,
                )
              : Text("Escolha uma ação"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  textoPrimeiroBotao, //geralmente botao cancelar
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: !perguntaTemRespota
                  ? () async {
                      await _salvarResposta(idDaPergunta).then((_) {
                        Navigator.pop(context); //Fechar AlertDialog
                      });
                    }
                  : () {
                      Navigator.pop(context);
                      _verRespostaDaPergunta(idDaPergunta);
                    },
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  textoSegundoBotao,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _lerArquivoComRespostas().then((dados) {
      setState(() {
        _listaDeRespostas = json.decode(dados);
      });
    });
    _lerArquivoComQuestionarios().then((dados) {
      _listaDeQuestionarios = json.decode(dados);
    });
  }

  bool _verificarSePerguntaJaTemResposta(String idDaPergunta) {
    for (var map in _listaDeRespostas) {
      if (map?.containsKey("idDaPergunta") ?? false) {
        if (map!["idDaPergunta"] == idDaPergunta) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todas as perguntas"),
        key: _scaffoldKey,
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
                int quantidadeDePerguntasComResposta = 0;

                if (quantidadeDePerguntas == 0) {
                  return Lottie.asset("assets/animacaoNenhumaPergunta.json");
                } else {
                  return ListView.builder(
                    itemCount: quantidadeDePerguntas,
                    itemBuilder: (context, index) {
                      List<Pergunta>? lista = snapshot.data;
                      Pergunta pergunta = lista![index];
                      bool perguntaTemRespota =
                          _verificarSePerguntaJaTemResposta(pergunta.id);

                      if (perguntaTemRespota) {
                        quantidadeDePerguntasComResposta++;
                        if (quantidadeDePerguntasComResposta ==
                            quantidadeDePerguntas) {
                          _atualizarStatusQuestionario("completo");
                        }
                      }
                      if (index == quantidadeDePerguntas - 1 &&
                          quantidadeDePerguntasComResposta <
                              quantidadeDePerguntas) {
                        _atualizarStatusQuestionario("incompleto");
                      }
                      return GestureDetector(
                        onTap: () {
                          perguntaTemRespota
                              ? _caixaAlerta(
                                  _scaffoldKey.currentContext,
                                  perguntaTemRespota,
                                  pergunta.id.toString(),
                                  'Cancelar',
                                  'Ver resposta',
                                )
                              : _caixaAlerta(
                                  _scaffoldKey.currentContext,
                                  perguntaTemRespota,
                                  pergunta.id.toString(),
                                  'Cancelar',
                                  'Responder',
                                );
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
                                pergunta.texto,
                                style: TextStyle(
                                    color: perguntaTemRespota
                                        ? Colors.green
                                        : Colors.grey[600]),
                              ),
                              subtitle: Text(
                                pergunta.descricao,
                                style: TextStyle(
                                    color: perguntaTemRespota
                                        ? Colors.green
                                        : Colors.grey[600]),
                              ),
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
