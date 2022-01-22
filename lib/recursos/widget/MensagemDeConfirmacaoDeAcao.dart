import 'package:flutter/material.dart';
import 'package:popquiz/recursos/Constantes.dart';

SnackBar mensagemDeConfirmacaoDeAcao(String texto, Color cor, IconData icon) {
  return SnackBar(
    duration: Duration(seconds: 3),
    content: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(width: 17),
        Expanded(
          child: Text(
            texto,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: cor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(curvaturas),
    ),
  );
}
