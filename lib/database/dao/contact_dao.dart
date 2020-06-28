import 'package:bancovirtualapp/database/app_database.dart';
import 'package:bancovirtualapp/models/contas.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tablesql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY,'
      '$_nome TEXT,'
      '$_conta INTEGER)';

  static const String _tableName = 'contas';
  static const String _id = 'id';
  static const String _nome = 'nome';
  static const String _conta = 'contacorrente';

  Future<int> save(Contact contas) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contasMap = _toMap(contas);
    return db.insert(_tableName, contasMap);
  }

  Map<String, dynamic> _toMap(Contact contas) {
    final Map<String, dynamic> contasMap = Map();
    contasMap[_nome] = contas.name;
    contasMap[_conta] = contas.accountNumber;
    return contasMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> conta = _toList(result);
    return conta;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> conta = List();
    for (Map<String, dynamic> row in result) {
      final Contact contas = Contact(
        row[_id],
        row[_nome],
        row[_conta],
      );
      conta.add(contas);
    }
    return conta;
  }
}
