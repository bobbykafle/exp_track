import 'package:expens_tracker/export/export.dart';

enum ExpenseStatus { initial, loading, success, failure }

class ExpenseState extends Equatable {
  const ExpenseState({
    this.status = ExpenseStatus.initial,
    this.expenses = const [],
    this.errorMessage,
    this.actionError,
  });

  final ExpenseStatus status;
  final List<Expense> expenses;

  final String? errorMessage;

  final String? actionError;

  double totalForMonth(DateTime month) {
    return expenses
        .where((e) => e.date.year == month.year && e.date.month == month.month)
        .fold<double>(0, (sum, e) => sum + e.amount);
  }

  MapEntry<String, double>? biggestCategory(DateTime month) {
    final totals = categoryTotalsForMonth(month);
    if (totals.isEmpty) return null;
    return totals.entries.reduce((a, b) => a.value >= b.value ? a : b);
  }

  double dailyAverage(DateTime month) {
    final now = DateTime.now();
    final isCurrent = month.year == now.year && month.month == now.month;
    final days = isCurrent ? now.day : DateTime(month.year, month.month + 1, 0).day;
    return days == 0 ? 0 : totalForMonth(month) / days;
  }

  double? percentChangeVsPreviousMonth(DateTime month) {
    final prev = totalForMonth(DateTime(month.year, month.month - 1));
    if (prev == 0) return null;
    return (totalForMonth(month) - prev) / prev * 100;
  }

  List<Expense> recent({int limit = 5}) => expenses.take(limit).toList();

  Map<String, double> categoryTotalsForMonth(DateTime month) {
    final totals = <String, double>{};
    for (final e in expenses) {
      if (e.date.year == month.year && e.date.month == month.month) {
        totals.update(e.category.label, (v) => v + e.amount, ifAbsent: () => e.amount);
      }
    }
    return totals;
  }

  ExpenseState copyWith({
    ExpenseStatus? status,
    List<Expense>? expenses,
    String? errorMessage,
    String? actionError,
  }) {
    return ExpenseState(
      status: status ?? this.status,
      expenses: expenses ?? this.expenses,
      errorMessage: errorMessage,
      actionError: actionError,
    );
  }

  @override
  List<Object?> get props => [status, expenses, errorMessage, actionError];
}