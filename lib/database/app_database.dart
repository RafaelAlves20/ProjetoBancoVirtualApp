import 'package:bancovirtualapp/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  return getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bancovirtual.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(ContactDao.tablesql);
      },
      version: 1,
      // onDowngrade: onDatabaseDowngradeDelete,
    );
  });
}
