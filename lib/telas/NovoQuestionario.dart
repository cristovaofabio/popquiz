import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:popquiz/main.dart';
import 'package:popquiz/recursos/Constantes.dart';
import 'package:popquiz/recursos/widget/BotaoCustomizado.dart';
import 'package:popquiz/recursos/widget/InputCustomizado.dart';

class NovoQuestionario extends StatefulWidget {
  const NovoQuestionario({Key? key}) : super(key: key);

  @override
  _NovoQuestionarioState createState() => _NovoQuestionarioState();
}

class _NovoQuestionarioState extends State<NovoQuestionario> {
  final _chave = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo questionário"),
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
                  Lottie.asset(
                    "assets/animacao.json",
                    width: 200,
                    height: 200,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 10),
                    child: Text(
                      "TÍTULO:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: tamanhoDaLetra,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, top: 5),
                    child: InputCustomizado(
                      Icon(
                        Icons.text_fields,
                        color: temaPadrao.accentColor,
                      ),
                      onSaved: (nome) {
                     
                      },
                      onSubmitted: (_) {
                        
                      },
                      type: TextInputType.name,
                      validator: (valor) {
                        if (valor!.isEmpty || valor.length < 3)
                          return 'Informe pelo menos 3 caracteres';
                        return null;
                      },
                      inputFormaters: [
                        FilteringTextInputFormatter(RegExp("[a-z A-Z á-ú Á-Ú]"),
                            allow: true)
                      ],
                      letras: TextCapitalization.sentences,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 10),
                    child: BotaoCustomizado(
                      texto: "Criar",
                      onPressed: () {
                        if (_chave.currentState!.validate()) {
                          _chave.currentState!.save();
                        } else {}
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
