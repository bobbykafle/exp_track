import 'package:expens_tracker/export/export.dart';

class ExpenseFormBloc extends Bloc<ExpenseFormEvent, ExpenseFormState> {
  ExpenseFormBloc({Expense? existing})
      : _existing = existing,
        super(ExpenseFormState.initial(existing)) {
    on<FormAmountChanged>((e, emit) => emit(state.copyWith(amountText: e.value)));
    on<FormTitleChanged>((e, emit) => emit(state.copyWith(title: e.value)));
    on<FormCategoryChanged>((e, emit) => emit(state.copyWith(category: e.category)));
    on<FormDateChanged>((e, emit) => emit(state.copyWith(date: e.date)));
    on<FormNoteChanged>((e, emit) => emit(state.copyWith(note: e.value)));
    on<FormSubmitted>(_onSubmitted);
  }

  final Expense? _existing;

  void _onSubmitted(FormSubmitted event, Emitter<ExpenseFormState> emit) {
    if (!state.isValid) {
      emit(state.copyWith(showErrors: true));
      return;
    }

    final note = state.note.trim();
    final expense = Expense(
      id: _existing?.id ?? '',
      createdAt: _existing?.createdAt ?? DateTime.now(),
      title: state.title.trim(),
      amount: state.amount!,
      category: state.category,
      date: state.date,
      note: note.isEmpty ? null : note,
    );

    emit(state.copyWith(
      showErrors: true,
      status: FormStatus.valid,
      result: expense,
    ));
  }
}