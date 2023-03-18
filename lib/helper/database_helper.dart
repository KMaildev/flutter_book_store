import 'package:book_store/model/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  String columnId = 'id';
  String columnBookName = 'bookName';
  String columnbookAuthor = 'bookAuthor';
  String columnbookPrice = 'bookPrice';
  String columnbookImage = 'bookImage';

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
    String sql =
        'CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnBookName CHAR, $columnbookAuthor CHAR, $columnbookPrice INTEGER, $columnbookImage CHAR)';
    db.execute(sql);
  }

  Future<int> insertData(Book book) async {
    _database = await getDatabase();
    int result = await _database!.insert(tableName, book.toMap());
    return result;
  }

  Future<int> updateData(Book book, int id) async {
    _database = await getDatabase();
    book.id = id;
    int result = await _database!.update(
      tableName,
      book.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<void> deleteData(int id) async {
    _database = await getDatabase();
    await _database!.delete(
      tableName,
      where: 'id == ?',
      whereArgs: [id],
    );
  }

  Future<List<Book>> getAllData() async {
    _database = await getDatabase();
    List<Map<String, dynamic>> maps = await _database!.query(tableName);

    // List<Book> books = [];
    // for (Map<String, dynamic> map in maps) {
    //   Book b = Book.fromMap(map);
    //   books.add(b);
    // }

    return maps.map((e) => Book.fromMap(e)).toList();
  }
}
