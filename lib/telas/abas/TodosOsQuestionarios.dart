import 'package:flutter/material.dart';
import 'package:popquiz/main.dart';
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
      body: Container(
        child: Center(
          child: Text("Todos"),
        ),
      ),
    );
  }
}
