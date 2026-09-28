import 'package:expens_tracker/export/export.dart';



class AddExpensePage extends StatelessWidget {
  const AddExpensePage({super.key, this.existing});

  final Expense? existing;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExpenseFormBloc(existing: existing),
      child: _ExpenseFormView(existing: existing),
    );
  }
}

class _ExpenseFormView extends StatelessWidget {
  const _ExpenseFormView({this.existing});

  final Expense? existing;

  bool get isEditing => existing != null;

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<ExpenseFormBloc>();
    final initial = formBloc.state;

    return BlocListener<ExpenseFormBloc, ExpenseFormState>(
      listenWhen: (prev, curr) =>
          prev.status != curr.status && curr.status == FormStatus.valid,
      listener: (context, state) {
        final expense = state.result!;
        context.read<ExpenseBloc>().add(
          isEditing ? ExpenseUpdatedEvent(expense) : ExpenseAdded(expense),
        );
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: CustomHeader(
            title: (isEditing ? 'Edit expense' : 'Add expense').toUpperCase(),
          ),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: BlocBuilder<ExpenseFormBloc, ExpenseFormState>(
              builder: (context, s) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xxl),
                    const FormFieldLabel('Amount'),
                    AmountField(
                      initialValue: initial.amountText,
                      onChanged: (v) => formBloc.add(FormAmountChanged(v)),
                      errorText: s.showErrors ? s.amountError : null,
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    const FormFieldLabel('Title'),
                    TextFormField(
                      initialValue: initial.title,
                      onChanged: (v) => formBloc.add(FormTitleChanged(v)),
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      maxLength: 50,
                      decoration: InputDecoration(
                        hintText: 'e.g. Coffee with Sam',
                        counterText: '',
                        errorText: s.showErrors ? s.titleError : null,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    const FormFieldLabel('Category'),
                    CategoryPicker(
                      selected: s.category,
                      onSelected: (c) => formBloc.add(FormCategoryChanged(c)),
                    ),
                    const SizedBox(height: AppSpacing.lg),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FormFieldLabel('Date'),
                              DateField(
                                date: s.date,
                                onChanged: (d) =>
                                    formBloc.add(FormDateChanged(d)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FormFieldLabel('Note (optional)'),
                              TextFormField(
                                initialValue: initial.note,
                                onChanged: (v) =>
                                    formBloc.add(FormNoteChanged(v)),
                                maxLength: 200,
                                decoration: const InputDecoration(
                                  hintText: 'Add a note',
                                  counterText: '',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),

                    ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        formBloc.add(const FormSubmitted());
                      },
                      child: Text(
                        isEditing ? 'Update expense' : 'Save expense',
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
