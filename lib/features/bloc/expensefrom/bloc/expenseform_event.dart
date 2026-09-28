import 'package:expens_tracker/export/export.dart';

abstract class ExpenseFormEvent extends Equatable {
  const ExpenseFormEvent();

  @override
  List<Object?> get props => [];
}

class FormAmountChanged extends ExpenseFormEvent {
  const FormAmountChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class FormTitleChanged extends ExpenseFormEvent {
  const FormTitleChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class FormCategoryChanged extends ExpenseFormEvent {
  const FormCategoryChanged(this.category);
  final ExpenseCategory category;

  @override
  List<Object?> get props => [category];
}

class FormDateChanged extends ExpenseFormEvent {
  const FormDateChanged(this.date);
  final DateTime date;

  @override
  List<Object?> get props => [date];
}

class FormNoteChanged extends ExpenseFormEvent {
  const FormNoteChanged(this.value);
  final String value;

  @override
  List<Object?> get props => [value];
}

class FormSubmitted extends ExpenseFormEvent {
  const FormSubmitted();
}