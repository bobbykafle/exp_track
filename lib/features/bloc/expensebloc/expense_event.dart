import 'package:expens_tracker/export/export.dart';


abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object?> get props => [];
}

class ExpensesSubscriptionRequested extends ExpenseEvent {
  const ExpensesSubscriptionRequested();
}

class ExpenseAdded extends ExpenseEvent {
  const ExpenseAdded(this.expense);
  final Expense expense;

  @override
  List<Object?> get props => [expense];
}

class ExpenseUpdatedEvent extends ExpenseEvent {
  const ExpenseUpdatedEvent(this.expense);
  final Expense expense;

  @override
  List<Object?> get props => [expense];
}

class ExpenseDeleted extends ExpenseEvent {
  const ExpenseDeleted(this.id);
  final String id;

  @override
  List<Object?> get props => [id];
}