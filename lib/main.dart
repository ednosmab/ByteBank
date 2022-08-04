import 'package:flutter/material.dart';
import 'screens/transferencia/lista.dart';

void main() => runApp(ByteBank());

class ByteBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      theme: theme.copyWith(
        primaryColor: Colors.green[900],
        backgroundColor: Colors.white,
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.green[900],
        ),
      ),
      home: ListaTransferencia(),
    );
  }
}
