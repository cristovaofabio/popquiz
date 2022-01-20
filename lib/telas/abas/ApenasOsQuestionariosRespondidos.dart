import 'package:flutter/material.dart';

class ApenasOsQuestionariosRespondidos extends StatefulWidget {
  const ApenasOsQuestionariosRespondidos({ Key? key }) : super(key: key);

  @override
  _ApenasOsQuestionariosRespondidosState createState() => _ApenasOsQuestionariosRespondidosState();
}

class _ApenasOsQuestionariosRespondidosState extends State<ApenasOsQuestionariosRespondidos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Respondidos"),
        ),
      ),
    );
  }
}