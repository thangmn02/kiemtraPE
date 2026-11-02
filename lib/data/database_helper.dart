import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String tableExpense = 'expenses';

  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }
    String path = join(await getDatabasesPath(), 'expense.db');
    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return _database!;
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableExpense (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        amount INTEGER NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');

    await db.execute('''
      INSERT INTO $tableExpense (name, amount, category, date) VALUES
      ('Ăn uống', 150000, 'Sinh hoạt', '2026-10-29'),
      ('Di chuyển', 50000, 'Đi lại', '2026-10-28'),
      ('Mua sách', 200000, 'Học tập', '2026-10-27'),
      ('Mua sắm', 1500000, 'Sinh hoạt', '2026-10-25'),
      ('Khám bệnh', 3550000, 'Sức khỏe', '2026-10-22')
    ''');
  }
}
