import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popquiz/main.dart';
import 'package:popquiz/model/Pergunta.dart';
import 'package:popquiz/recursos/ApiMock.dart';
import 'package:popquiz/recursos/Constantes.dart';
import 'package:popquiz/recursos/widget/BotaoCustomizado.dart';
import 'package:popquiz/recursos/widget/InputCustomizado.dart';
import 'package:popquiz/recursos/widget/MensagemDeConfirmacaoDeAcao.dart';

class NovaPergunta extends StatefulWidget {
  late final String _idDoQuestionario;
  NovaPergunta(this._idDoQuestionario);

  @override
  _NovaPerguntaState createState() => _NovaPerguntaState();
}

class _NovaPerguntaState extends State<NovaPergunta> {
  final _chave = GlobalKey<FormState>();
  late String _textoDaPergunta;
  late String _descricaoDaPergunta;
  bool _adicionandoNovaPergunta = false;

  Future<void> _adicionarNovaPergunta(Pergunta pergunta) async {
    ApiMock api = ApiMock();

    await api.salvarNovaPergunta(widget._idDoQuestionario.toString(), pergunta).then((_) {
      setState(() {
        _adicionandoNovaPergunta = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
          mensagemDeConfirmacaoDeAcao(
            'Pergunta adicionada!',
            Color(0xFF43A047),
            Icons.thumb_up,
          ),
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova pergunta'),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _chave,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      "TEXTO:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: tamanhoDaLetra,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 5),
                    child: InputCustomizado(
                      icone: Icon(
                        Icons.edit,
                        color: temaPadrao.accentColor,
                      ),
                      onSaved: (textoDaPergunta) {
                        _textoDaPergunta = textoDaPergunta!;
                      },
                      type: TextInputType.name,
                      validator: (valor) {
                        if (valor!.isEmpty || valor.length < 3)
                          return 'Informe pelo menos 3 caracteres';
                        return null;
                      },
                      letras: TextCapitalization.sentences,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      "DESCRIÇÃO:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: tamanhoDaLetra,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 5),
                    child: InputCustomizado(
                      maxLinhas: 3,
                      maxCaracteres: 100,
                      onSaved: (descricaoDaPergunta) {
                        _descricaoDaPergunta = descricaoDaPergunta!;
                      },
                      type: TextInputType.name,
                      validator: (valor) {
                        if (valor!.isEmpty || valor.length < 3)
                          return 'Informe pelo menos 3 caracteres';
                        return null;
                      },
                      letras: TextCapitalization.sentences,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: _adicionandoNovaPergunta
                        ? TextButton(
                            onPressed: () {},
                            child: CircularProgressIndicator(
                              color: temaPadrao.buttonColor,
                            ),
                          )
                        : BotaoCustomizado(
                            texto: "Adicionar",
                            onPressed: () async {
                              if (_chave.currentState!.validate()) {
                                _chave.currentState!.save();
                                setState(() {
                                  _adicionandoNovaPergunta = true;
                                });

                                String idPergunta = DateTime.now().microsecondsSinceEpoch.toString();
                                Pergunta pergunta = Pergunta(idPergunta,_textoDaPergunta, _descricaoDaPergunta);
                                await _adicionarNovaPergunta(pergunta);
                              } else {
                                //
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
