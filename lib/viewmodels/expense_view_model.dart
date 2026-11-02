import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/expense.dart';
import '../repositories/expense_repository.dart';
import '../utils/format.dart';

part 'expense_view_model.g.dart';

@riverpod
ExpenseRepository expenseRepository(Ref ref) {
  return ExpenseRepository();
}

@riverpod
class ExpenseViewModel extends _$ExpenseViewModel {
  @override
  Future<List<Expense>> build() async {
    final repository = ref.watch(expenseRepositoryProvider);
    return repository.getAllExpenses();
  }

  Future<void> saveExpense({
    required Expense oldExpense,
    required String name,
    required String amount,
    required String category,
    required String date,
  }) async {
    Expense updatedExpense = oldExpense.copyWith(
      name: name.trim(),
      amount: int.parse(amount.trim()),
      category: category,
      date: FormatHelper.parseDate(date.trim()),
    );

    final repository = ref.read(expenseRepositoryProvider);
    await repository.updateExpense(updatedExpense);
    state = AsyncData(await repository.getAllExpenses());
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập tên khoản chi';
    }
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập số tiền';
    }
    int? amount = int.tryParse(value.trim());
    if (amount == null || amount <= 0) {
      return 'Số tiền phải là số nguyên lớn hơn 0';
    }
    return null;
  }

  String? validateCategory(String? value) {
    if (value == null) {
      return 'Vui lòng chọn danh mục';
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Vui lòng nhập ngày chi tiêu';
    }
    if (FormatHelper.parseDate(value.trim()) == null) {
      return 'Ngày không hợp lệ, nhập theo dạng dd/MM/yyyy';
    }
    return null;
  }
}
