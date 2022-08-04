import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;

  // Nessa versão do flutter 3.0.5, para atribuir valores nulos no tipo
  // IconData é necessário colocar sina de ?
  IconData? icone = null;

  Editor(
      {required this.controlador,
      required this.rotulo,
      required this.dica,
      this.icone});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          // Removendo o espaço em branco, que seria o local do ícone, no campo da conta
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
