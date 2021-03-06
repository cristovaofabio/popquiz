import 'package:flutter/material.dart';
import 'package:popquiz/main.dart';
import 'package:popquiz/model/Questionario.dart';
import 'package:popquiz/recursos/ApiMock.dart';
import 'package:popquiz/recursos/Constantes.dart';
import 'package:popquiz/recursos/RotasDasPaginas.dart';
import 'package:popquiz/recursos/widget/MensagemCarregando.dart';

class TodosOsQuestionarios extends StatefulWidget {
  const TodosOsQuestionarios({Key? key}) : super(key: key);

  @override
  _TodosOsQuestionariosState createState() => _TodosOsQuestionariosState();
}

class _TodosOsQuestionariosState extends State<TodosOsQuestionarios> {
  _mudarParaATelaNovoQuestionario() {
    Navigator.pushNamed(context, RotasDasPaginas.ROTA_NOVO_QUESTIONARIO);
  }

  _recuperarQuestionariosDaApi() {
    ApiMock api = ApiMock();
    return api.recuperarListaDeQuestionarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: temaPadrao.buttonColor,
        onPressed: _mudarParaATelaNovoQuestionario,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<List<Questionario>>(
        future: _recuperarQuestionariosDaApi(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return MensagemCarregando(texto: 'Carregando questionĂ¡rios');
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("Erro ao carregar os dados!"),
                );
              } else {
                int quantidadeDeQuestionario = snapshot.data!.length;
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    List<Questionario>? lista = snapshot.data;
                    Questionario questionario = lista![index];

                    return Padding(
                      padding: (index == quantidadeDeQuestionario - 1)
                          ? EdgeInsets.only(bottom: 75)
                          : EdgeInsets.only(bottom: 0),
                      child: GestureDetector(
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
                                style: TextStyle(fontSize: tamanhoDaLetra + 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
