import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/expense.dart';
import '../utils/constants.dart';
import '../viewmodels/expense_view_model.dart';
import '../viewmodels/setting_view_model.dart';
import 'currency_dialog.dart';
import 'edit_expense.dart';
import 'widgets/expense_item.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({super.key});

  void openEditScreen(BuildContext context, Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditExpenseScreen(expense: expense),
      ),
    );
  }

  void openCurrencyDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const CurrencyDialog());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseState = ref.watch(expenseViewModelProvider);
    final currency =
        ref.watch(settingViewModelProvider).value ?? Constants.currencyVnd;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý chi tiêu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => openCurrencyDialog(context),
          ),
        ],
      ),
      body: expenseState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Lỗi: $error')),
        data: (expenses) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemCount: expenses.length,
            itemBuilder: (context, index) {
              final expense = expenses[index];
              return ExpenseItem(
                expense: expense,
                currency: currency,
                onEdit: () => openEditScreen(context, expense),
              );
            },
          );
        },
      ),
    );
  }
}
