import 'package:flutter/material.dart';
import 'package:popquiz/main.dart';
import 'package:popquiz/model/Questionario.dart';
import 'package:popquiz/recursos/ApiMock.dart';
import 'package:popquiz/recursos/Constantes.dart';
import 'package:popquiz/recursos/RotasDasPaginas.dart';

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
                      List<Questionario>? lista = snapshot.data;
                      Questionario questionario = lista![index];

                      return GestureDetector(
                        onTap: () {
                          print('ID: ${questionario.id} selecionado');
                        },
                        child: Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(curvaturas),
                            side: BorderSide(color: Colors.grey, width: 1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                              child: Text(
                                '${questionario.titulo}',
                                style: TextStyle(
                                  fontSize: tamanhoDaLetra,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );

                      /* ListTile(
                        title: Text(questionario.titulo),
                        subtitle: Text(questionario.id.toString()),
                      ); */
                    });
              }
          }
        },
      ),
    );
  }
}
