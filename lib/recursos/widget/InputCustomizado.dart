import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:popquiz/main.dart';
import 'package:popquiz/recursos/Constantes.dart';

class InputCustomizado extends StatelessWidget {
  late final bool obscure;
  late final bool autofocus;
  late final bool leitura;
  late final TextInputType type;
  late final TextCapitalization letras;

  final List<TextInputFormatter>? inputFormaters;
  final Icon? icone;
  final int? maxLinhas;
  final int? maxCaracteres;
  final bool? cursor;
  final FocusNode? focusNode;
  final bool? habilitar;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSubmitted;
  final String? Function(String?)? onSaved;
  final String? Function()? onTap;
  final String? textoAjuda;
  final TextEditingController? controller;

  InputCustomizado(
      {this.icone,
      this.controller,
      this.obscure = false,
      this.autofocus = false,
      this.leitura = false,
      this.type = TextInputType.text,
      this.letras = TextCapitalization.none,
      this.habilitar,
      this.inputFormaters,
      this.maxLinhas,
      this.maxCaracteres,
      this.focusNode,
      this.cursor,
      this.textoAjuda,
      this.validator,
      this.onSubmitted,
      this.onTap,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      enableSuggestions: true,
      obscureText: this.obscure,
      showCursor: this.cursor,
      readOnly: this.leitura,
      enabled: this.habilitar,
      autofocus: this.autofocus,
      keyboardType: this.type,
      focusNode: this.focusNode,
      onFieldSubmitted: onSubmitted,
      textCapitalization: this.letras,
      style: TextStyle(fontSize: 18),
      inputFormatters: this.inputFormaters,
      maxLines: this.maxLinhas,
      maxLength: this.maxCaracteres,
      onSaved: this.onSaved,
      onTap: this.onTap,
      validator: this.validator,
      decoration: InputDecoration(
        prefixIcon: this.icone,
        helperText: this.textoAjuda,
        contentPadding: EdgeInsets.fromLTRB(30, 15, 30, 15),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(width: 1, color: temaPadrao.buttonColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(width: 1, color: temaPadrao.buttonColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(curvaturas),
        ),
      ),
    );
  }
}
