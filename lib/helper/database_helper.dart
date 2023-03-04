import 'package:book_store/model/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  String columnId = 'id';
  String columnBookName = 'bookName';
  String columnbookAuthor = 'bookAuthor';
  String columnbookPrice = 'bookPrice';

  String dbName = 'bootstore';
  String tableName = 'books';

  static DatabaseHelper databaseHelper = DatabaseHelper();
  static Database? _database;

  getDatabase() async {
    var dbPath = await getDatabasesPath();
    return await openDatabase(p.join(dbPath, dbName),
        onCreate: _createDb, version: 1);
  }

  void _createDb(Database db, int version) {
    String sql = 'CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnBookName CHAR, $columnbookAuthor CHAR, $columnbookPrice INTEGER)';
    db.execute(sql);
  }

  Future<int> insertData(Book book) async {
    _database = await getDatabase();
    int result = await _database!.insert(tableName, book.toMap());
    return result;
  }
}
