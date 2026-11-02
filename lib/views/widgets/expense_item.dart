import 'package:flutter/material.dart';

import '../../models/expense.dart';
import '../../utils/format.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final String currency;
  final VoidCallback onEdit;

  const ExpenseItem({
    super.key,
    required this.expense,
    required this.currency,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        expense.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Chip(
            label: Text(expense.category),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 8),
          Text(FormatHelper.formatDate(expense.date)),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            FormatHelper.formatMoney(expense.amount, currency),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          IconButton(icon: const Icon(Icons.edit_outlined), onPressed: onEdit),
        ],
      ),
    );
  }
}
