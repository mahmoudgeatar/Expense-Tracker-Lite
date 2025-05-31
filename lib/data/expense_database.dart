import 'package:expense_tracker_lite/providers/expense_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/expense_model.dart';

class ExpenseDatabase {
  static final ExpenseDatabase instance = ExpenseDatabase._init();
  static Database? _database;

  ExpenseDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
        // onUpgrade: (db, oldVersion, newVersion) async {
        //   if (oldVersion < 3) {
        //     final tableInfo = await db.rawQuery("PRAGMA table_info(expenses)");
        //     final hasCurrencyColumn = tableInfo.any((col) => col['name'] == 'currency');
        //
        //     if (!hasCurrencyColumn) {
        //       await db.execute('ALTER TABLE expenses ADD COLUMN currency TEXT NOT NULL DEFAULT "USD"');
        //     }
        //   }
        // }
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE expenses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      category TEXT NOT NULL,
      amount REAL NOT NULL,
      usdAmount REAL NOT NULL,
      date TEXT NOT NULL,
      receiptPath TEXT,
      currency TEXT NOT NULL
    )
  ''');
  }


  Future<Expense> insertExpense(Expense expense) async {
    final db = await instance.database;
    final id = await db.insert('expenses', expense.toMap());
    return expense.copyWith(id: id);
  }

  Future<List<Expense>> getAllExpenses({
    int offset = 0,
    int limit = 10,
    DateFilterType? filter,
  }) async {
    final db = await instance.database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (filter != null) {
      final now = DateTime.now();

      if (filter == DateFilterType.last7Days) {
        final fromDate = now.subtract(const Duration(days: 7)).toIso8601String();
        whereClause = 'date >= ?';
        whereArgs = [fromDate];
      } else if (filter == DateFilterType.currentMonth) {
        final firstDayOfMonth = DateTime(now.year, now.month, 1).toIso8601String();
        whereClause = 'date >= ?';
        whereArgs = [firstDayOfMonth];
      }
    }

    final result = await db.query(
      'expenses',
      where: whereClause.isNotEmpty ? whereClause : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: 'date DESC',
      limit: limit,
      offset: offset,
    );

    return result.map((map) => Expense.fromMap(map)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
