import 'package:flutter/material.dart';

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

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  void _criaTransferencia(BuildContext context) {
    // Para tratar o Fatal error de forma mais elegante: caso o valor
    // seja nulo, esse valor receberá zero e impede de gerar uma Fatal Error
    final int numeroConta =
        int.tryParse(_controladorCampoNumeroConta.text) != null
            ? int.parse(_controladorCampoNumeroConta.text)
            : 0;
    final double valorTransferencia =
        double.tryParse(_controladorCampoValor.text) != null
            ? double.parse(_controladorCampoValor.text)
            : 0;
    if (numeroConta != null && valorTransferencia != null) {
      final transferenciaCriada =
          Transferencia(valorTransferencia, numeroConta);

      debugPrint('Criando Transferência');
      debugPrint('$transferenciaCriada');
      Navigator.pop(context, transferenciaCriada);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // SingleChildScrollView atribui ao Column a rolagem em Sroll, isso impede
      // que o layout quebre
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
          child: Column(children: [
        Editor(
          controlador: _controladorCampoNumeroConta,
          rotulo: 'Digite o número da conta',
          dica: '0000',
        ),
        Editor(
          controlador: _controladorCampoValor,
          rotulo: 'Informe o valor da transferência',
          dica: '0.00',
          icone: Icons.monetization_on,
        ),
        ElevatedButton(
          onPressed: () => _criaTransferencia(context),
          child: Text('Confirmar'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20),
            primary: Theme.of(context).primaryColor, // background
            onPrimary: Colors.white, // foreground
          ),
        )
      ])),
    );
  }
}

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

class ListaTransferencia extends StatefulWidget {
  @override
  _ListaTransferencia createState() => _ListaTransferencia();
}

class _ListaTransferencia extends State<ListaTransferencia> {
  final List<Transferencia> _transferencias = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trasnferência'),
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
          }));
          // usando o then a thread do formulário de transferência não fica preso
          // esperando uma callback para a transferência ser criada
          future.then((transferenciaRecebida) {
            debugPrint('chegou no then');
            debugPrint('$transferenciaRecebida');
            if (transferenciaRecebida != null) {
              debugPrint('Passei por aqui');
              debugPrint('!!!!!!!!!!$transferenciaRecebida texto!!!!!');
              // adicionando nova transferência
              setState(() {
                _transferencias.add(transferenciaRecebida);
              });
              debugPrint('Lista de transfe $_transferencias');
            }
          });
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

class Transferencia {
  final double valorTransferencia;
  final int numeroConta;

  Transferencia(this.valorTransferencia, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valorTransferencia: $valorTransferencia, numeroConta: $numeroConta}';
  }
}
