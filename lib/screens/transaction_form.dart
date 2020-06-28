import 'dart:async';

import 'package:bancovirtualapp/components/progress.dart';
import 'package:bancovirtualapp/components/response_dialog.dart';
import 'package:bancovirtualapp/components/transaction_auth_dialog.dart';
import 'package:bancovirtualapp/http/webclients/transaction_webclient.dart';
import 'package:bancovirtualapp/models/contas.dart';
import 'package:bancovirtualapp/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact accountNumber;

  TransactionForm(this.accountNumber);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionWebClient _webClient = TransactionWebClient();
  final String transactionId = Uuid().v4();
  bool _sending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Transferência'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress(
                    message: 'Enviando...',
                  ),
                ),
                visible: _sending,
              ),
              Text(
                'Titular: ' + widget.accountNumber.name,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Conta Corrente: ' + widget.accountNumber.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 18.0),
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    child: Text('Transferir'),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      final transactionCreated = Transaction(
                        transactionId,
                        value,
                        widget.accountNumber,
                      );
                      showDialog(
                          context: context,
                          builder: (contextDialog) {
                            return TransactionAuthDialog(
                              onConfirm: (String password) {
                               _save(transactionCreated, password, context);
                              },
                            );
                          });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
      Transaction transactionCreated,
      String password,
      BuildContext context,
      ) async {
    Transaction transaction = await _send(
      transactionCreated,
      password,
      context,
    );
    _showSuccessfulMessage(transaction, context);
  }

  Future _showSuccessfulMessage(
      Transaction transaction, BuildContext context) async {
    if (transaction != null) {
      await showDialog(
          context: context,
          builder: (contextDialog) {
            return SuccessDialog('Transação Bem Sucedida!');
          });
      Navigator.pop(context);
    }
  }

  Future<Transaction> _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    setState(() {
      _sending = true;
    });
    final Transaction transaction =
    await _webClient.save(transactionCreated, password).catchError((e) {
      _showFailureMessage(context, message: e.message);
    }, test: (e) => e is HttpException).catchError((e) {
      _showFailureMessage(context,
          message: 'Tempo Limite ao Enviar a Transação');
    }, test: (e) => e is TimeoutException).catchError((e) {
      _showFailureMessage(context);
    }).whenComplete(() {
      setState(() {
        _sending = false;
      });
    });
    return transaction;
  }

  void _showFailureMessage(
      BuildContext context, {
        String message = 'Unknown error',
      }) {
    showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(message);
        });
  }
}
