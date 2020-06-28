import 'package:bancovirtualapp/database/dao/contact_dao.dart';
import 'package:bancovirtualapp/models/contas.dart';
import 'package:flutter/material.dart';

class ContasForm extends StatefulWidget {
  @override
  _ContasFormState createState() => _ContasFormState();
}

class _ContasFormState extends State<ContasForm> {

  final ContactDao _dao =  ContactDao();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Contas Correntes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome Completo',
              ),
              style: TextStyle(fontSize: 19.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Número da Conta',
                ),
                style: TextStyle(fontSize: 19.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  child: Text('Confirmar'),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    final String Nome = _nameController.text;
                    final int Conta = int.tryParse(_accountNumberController.text);
                    final Contact newContaCorrente = Contact(0,Nome, Conta);
                    _dao.save(newContaCorrente).then((id) =>Navigator.pop(context));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
