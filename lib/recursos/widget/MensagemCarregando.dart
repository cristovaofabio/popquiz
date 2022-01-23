import 'package:flutter/material.dart';
import 'package:popquiz/main.dart';
import 'package:popquiz/recursos/Constantes.dart';

class MensagemCarregando extends StatelessWidget {

  final String texto;

  MensagemCarregando({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              this.texto,
              style: TextStyle(
                fontSize: tamanhoDaLetra,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CircularProgressIndicator(
            color: temaPadrao.buttonColor,
          ),
        ],
      ),
    );
  }
}