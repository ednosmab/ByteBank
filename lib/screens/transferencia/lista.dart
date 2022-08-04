import 'package:flutter/material.dart';

import 'formulario.dart';
import '../../models/transferencia.dart';

// criando constantes para grantir persistência nos títulos e textos
const _tituloAppBar = 'Trasnferência';

class ListaTransferencia extends StatefulWidget {
  @override
  _ListaTransferencia createState() => _ListaTransferencia();
}

class _ListaTransferencia extends State<ListaTransferencia> {
  final List<Transferencia> _transferencias = [];
  _atualiza(Transferencia transferenciaRecebida) {
    if (transferenciaRecebida != null) {
      setState(() {
        _transferencias.add(transferenciaRecebida);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Callback assíncrona para trabalhar de forma paralela com a tela
          // de formulário
          final Future<Transferencia?> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          })).then(
            (transferenciaRecebida) => _atualiza(transferenciaRecebida),
          );
        },
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
