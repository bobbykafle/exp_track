import 'package:expens_tracker/export/export.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc({required this._repository})
      : super(const ExpenseState()) {
    on<ExpensesSubscriptionRequested>(
      _onSubscriptionRequested,
      transformer: restartable(),
    );
    on<ExpenseAdded>((e, emit) => _run(emit, () => _repository.addExpense(e.expense)));
    on<ExpenseUpdatedEvent>((e, emit) => _run(emit, () => _repository.updateExpense(e.expense)));
    on<ExpenseDeleted>((e, emit) => _run(emit, () => _repository.deleteExpense(e.id)));

    add(const ExpensesSubscriptionRequested());
  }

  final ExpenseRepository _repository;

  Future<void> _onSubscriptionRequested(
    ExpensesSubscriptionRequested event,
    Emitter<ExpenseState> emit,
  ) async {
    emit(state.copyWith(status: ExpenseStatus.loading));

    await emit.forEach<List<Expense>>(
      _repository.watchExpenses(),
      onData: (expenses) => state.copyWith(
        status: ExpenseStatus.success,
        expenses: expenses,
      ),
      onError: (error, _) => state.copyWith(
        status: ExpenseStatus.failure,
        errorMessage: error.toString(),
      ),
    );
  }

  Future<void> _run(
    Emitter<ExpenseState> emit,
    Future<void> Function() action,
  ) async {
    try {
      await action();
    } catch (_) {
      emit(state.copyWith(actionError: 'Something went wrong. Please try again.'));
      
      emit(state.copyWith());
    }
  }
}