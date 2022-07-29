import 'package:flutter/material.dart';

void main() => runApp(ByteBank());

class ByteBank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: FormularioTransferencia(),
    ));
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            controller: _controladorCampoNumeroConta,
            style: TextStyle(fontSize: 24.0),
            decoration: InputDecoration(
              labelText: 'Número Conta',
              hintText: '0000',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: TextField(
            controller: _controladorCampoValor,
            style: TextStyle(fontSize: 24.0),
            decoration: InputDecoration(
              icon: Icon(Icons.monetization_on),
              labelText: 'Valor',
              hintText: '0.00',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              debugPrint('clicou no confirmar');
              final int numeroConta =
                  int.parse(_controladorCampoNumeroConta.text);
              final double valorTransferencia =
                  double.parse(_controladorCampoValor.text);
              if (numeroConta != null && valorTransferencia != null) {
                final transferenciaCriada =
                    Transferencia(valorTransferencia, numeroConta);
                debugPrint('$transferenciaCriada');
              }
            },
            child: Text('Confirmar'))
      ]),
    );
  }
}

class ListaTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trasnferência'),
      ),
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.0, 10001)),
          ItemTransferencia(Transferencia(200.0, 30001)),
          ItemTransferencia(Transferencia(300.0, 70020)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;
  ItemTransferencia(this._transferencia);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valorTransferencia.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valorTransferencia;
  final int numeroConta;

  Transferencia(this.valorTransferencia, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valorTransferencia: $valorTransferencia, numeroConta: $numeroConta}';
  }
}
