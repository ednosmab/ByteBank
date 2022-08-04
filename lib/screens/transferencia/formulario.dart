import 'package:flutter/material.dart';
import '../../components/editor.dart';
import '../../models/transferencia.dart';

// criando constantes para grantir persistência nos títulos e textos
const _tituloAppBar = 'Criando Transferência';

const _rotuloCampoNumeroConta = 'Digite o número da conta';
const _dicaCampoNumeroConta = '0000';

const _rotuloCampoValor = 'Informe o valor da transferência';
const _dicaCampoValor = '0.00';

const _textoBotaoConfirmar = 'Confirmar';

// Transformando de StatelessWidget para StatefulWidget para trabalhar
// a mudanda de estado da tela, uma vez que pode haver rotação do dispositivo
// que estará utilizando a aplicação Bytebank, essa ação pode gerar uma mudança
// de estado
class FormularioTransferencia extends StatefulWidget {
  @override
  _FormularioTransferencia createState() => _FormularioTransferencia();
}

class _FormularioTransferencia extends State<FormularioTransferencia> {
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
      Navigator.pop(context, transferenciaCriada);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      // SingleChildScrollView atribui ao Column a rolagem em Sroll, isso impede
      // que o layout quebre
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: _rotuloCampoNumeroConta,
              dica: _dicaCampoNumeroConta,
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: _rotuloCampoValor,
              dica: _dicaCampoValor,
              icone: Icons.monetization_on,
            ),
            ElevatedButton(
              onPressed: () => _criaTransferencia(context),
              child: Text(_textoBotaoConfirmar),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(20),
                primary: Theme.of(context).primaryColor, // background
                onPrimary: Colors.white, // foreground
              ),
            )
          ],
        ),
      ),
    );
  }
}
