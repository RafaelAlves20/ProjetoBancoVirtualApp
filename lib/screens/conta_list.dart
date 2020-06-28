import 'package:bancovirtualapp/database/dao/contact_dao.dart';
import 'package:bancovirtualapp/models/contas.dart';
import 'package:bancovirtualapp/screens/contas_form.dart';
import 'package:bancovirtualapp/screens/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContasList extends StatefulWidget {
  @override
  _ContasListState createState() => _ContasListState();

}

class _ContasListState extends State<ContasList> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contas Correntes'),

      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: _dao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;

            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Carregando...')
                  ],
                ),
              );
              break;

            case ConnectionState.active:
              break;

            case ConnectionState.done:
              final List<Contact> contas = snapshot.data;
              return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact conta = contas[index];
                    return _ContasItem(
                      conta,
                      onClick: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TransactionForm(conta),
                          ),
                        );
                      },

                    );
                  },
                  itemCount: contas.length,
              );
                  break;
              }
                  return Text('Unknoun erro');
          },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContasForm(),
            ),
          ).then((value) {
            setState(() {
              widget.createState();
            });
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContasItem extends StatelessWidget {

  final Contact contas;
  final Function onClick;

  _ContasItem(this.contas, {@required this.onClick,});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
        title: Text(
          contas.name,
          style: TextStyle(fontSize: 19.0),
        ),
        subtitle: Text(
          contas.accountNumber.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
