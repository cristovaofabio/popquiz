import 'package:flutter/material.dart';
import 'package:popquiz/telas/abas/ApenasOsQuestionariosRespondidos.dart';
import 'package:popquiz/telas/abas/TodosOsQuestionarios.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({Key? key}) : super(key: key);

  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial>
    with SingleTickerProviderStateMixin {
  TabController? _controladorDaAba;

  @override
  void initState() {
    super.initState();
    _controladorDaAba = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controladorDaAba!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Questionários"),
        elevation: 0,
        bottom: TabBar(
          controller: _controladorDaAba,
          labelColor: Colors.black,
          indicatorColor: Colors.grey,
          tabs: <Widget>[
            Tab(
              text: "Todos",
            ),
            Tab(
              text: "Respondidos",
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: TabBarView(
          controller: _controladorDaAba,
          children: <Widget>[
            TodosOsQuestionarios(),
            ApenasOsQuestionariosRespondidos(),
          ],
        ),
      ),
    );
  }
}
