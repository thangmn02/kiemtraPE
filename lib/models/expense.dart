import 'package:intl/intl.dart';

class Expense {
  final int id;
  final String name;
  final int amount;
  final String category;
  final DateTime date;

  Expense({
    required this.id,
    required this.name,
    required this.amount,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'category': category,
      'date': DateFormat('yyyy-MM-dd').format(date),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
      category: map['category'],
      date: DateTime.parse(map['date']),
    );
  }

  Expense copyWith({
    String? name,
    int? amount,
    String? category,
    DateTime? date,
  }) {
    return Expense(
      id: id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
    );
  }
}
