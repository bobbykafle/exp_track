import 'package:expens_tracker/export/export.dart';


enum FormStatus { editing, valid }

class ExpenseFormState extends Equatable {
  ExpenseFormState({
    this.amountText = '',
    this.title = '',
    this.category = ExpenseCategory.food,
    DateTime? date,
    this.note = '',
    this.showErrors = false,
    this.status = FormStatus.editing,
    this.result,
  }) : date = date ?? DateTime.now();

  factory ExpenseFormState.initial(Expense? e) {
    if (e == null) return ExpenseFormState();
    return ExpenseFormState(
      amountText: e.amount.toStringAsFixed(2),
      title: e.title,
      category: e.category,
      date: e.date,
      note: e.note ?? '',
    );
  }

  final String amountText;
  final String title;
  final ExpenseCategory category;
  final DateTime date;
  final String note;
  final bool showErrors;
  final FormStatus status;
  final Expense? result;
  double? get amount => double.tryParse(amountText);

  String? get amountError {
    if (amountText.trim().isEmpty) return 'Enter an amount';
    final v = amount;
    if (v == null || v <= 0) return 'Amount must be greater than 0';
    if (v > 10000000) return 'Amount is too large';
    return null;
  }

  String? get titleError {
    final t = title.trim();
    if (t.isEmpty) return 'Enter a title';
    if (t.length < 2) return 'Title is too short';
    if (t.length > 50) return 'Keep it under 50 characters';
    return null;
  }

  bool get isValid => amountError == null && titleError == null;

  ExpenseFormState copyWith({
    String? amountText,
    String? title,
    ExpenseCategory? category,
    DateTime? date,
    String? note,
    bool? showErrors,
    FormStatus? status,
    Expense? result,
  }) {
    return ExpenseFormState(
      amountText: amountText ?? this.amountText,
      title: title ?? this.title,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
      showErrors: showErrors ?? this.showErrors,
      status: status ?? this.status,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props =>
      [amountText, title, category, date, note, showErrors, status, result];
}