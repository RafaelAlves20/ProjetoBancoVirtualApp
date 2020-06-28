import 'package:bancovirtualapp/screens/conta_list.dart';
import 'package:bancovirtualapp/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'Dart:io';

class Dasdboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Banco Virtual'),
        leading: Icon(Icons.account_balance),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(1.0, 8.0, 8.0, 80.0),
            child: Image.asset('images/principal.png'),
          ),
          Container(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _FeatureItem(
                  'Contas Correntes',
                  onClick: () => _MostarContasList(context),
                ),
                _FeatureItem(
                  'Mostrar Transferências',
                  onClick: () => _MostrarTransaferenciaList(context),
                ),
                _FeatureItem(
                  'Encerrar Aplicativo',
                  onClick: () => exit(0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _MostarContasList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ContasList(),
    ),
  );
}

_MostrarTransaferenciaList(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => TransactionsList(),
    ),
  );
}

class _FeatureItem extends StatelessWidget {
  final String nome;
  final Function onClick;

  _FeatureItem(this.nome, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).accentColor,
        child: InkWell(
          onTap: () => onClick(),
          child: Container(
            padding: EdgeInsets.fromLTRB(10.0, 32.0, 18.0, 25.0),
            width: 122,
            child: Column(
              children: <Widget>[
                Text(
                  nome,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
