import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/expense.dart';
import '../utils/constants.dart';
import '../utils/format.dart';
import '../viewmodels/expense_view_model.dart';

class EditExpenseScreen extends ConsumerStatefulWidget {
  final Expense expense;

  const EditExpenseScreen({super.key, required this.expense});

  @override
  ConsumerState<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends ConsumerState<EditExpenseScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.expense.name;
    amountController.text = widget.expense.amount.toString();
    dateController.text = FormatHelper.formatDate(widget.expense.date);
    selectedCategory = widget.expense.category;
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> saveExpense() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    await ref
        .read(expenseViewModelProvider.notifier)
        .saveExpense(
          oldExpense: widget.expense,
          name: nameController.text,
          amount: amountController.text,
          category: selectedCategory!,
          date: dateController.text,
        );

    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Đã lưu khoản chi')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(expenseViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Chỉnh sửa khoản chi')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên khoản chi *',
                  border: OutlineInputBorder(),
                ),
                validator: viewModel.validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Số tiền *',
                  border: OutlineInputBorder(),
                ),
                validator: viewModel.validateAmount,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Danh mục *',
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Chọn danh mục'),
                items: Constants.categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: viewModel.validateCategory,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: dateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Ngày chi tiêu *',
                  hintText: 'dd/MM/yyyy',
                  border: OutlineInputBorder(),
                ),
                validator: viewModel.validateDate,
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Hủy'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: saveExpense,
                      child: const Text('Lưu'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
