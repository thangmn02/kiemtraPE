import '../data/database_helper.dart';
import '../models/expense.dart';

class ExpenseRepository {
  Future<List<Expense>> getAllExpenses() async {
    final db = await DatabaseHelper.getDatabase();
    final result = await db.query(
      DatabaseHelper.tableExpense,
      orderBy: 'date DESC',
    );
    return result.map((row) => Expense.fromMap(row)).toList();
  }

  Future<void> updateExpense(Expense expense) async {
    final db = await DatabaseHelper.getDatabase();
    await db.update(
      DatabaseHelper.tableExpense,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }
}
