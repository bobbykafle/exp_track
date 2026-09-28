import 'package:intl/intl.dart';
import 'package:expens_tracker/export/export.dart';

class ExpenseHistoryPage extends StatefulWidget {
  const ExpenseHistoryPage({super.key});

  @override
  State<ExpenseHistoryPage> createState() => _ExpenseHistoryPageState();
}

class _ExpenseHistoryPageState extends State<ExpenseHistoryPage> {
  String _query = '';
  ExpenseCategory? _category;
  DateTime? _date;

  bool get _hasFilters =>
      _query.isNotEmpty || _category != null || _date != null;

  void _clearFilters() => setState(() {
    _query = '';
    _category = null;
    _date = null;
  });

  List<Expense> _apply(List<Expense> all) {
    final q = _query.trim().toLowerCase();
    return all.where((e) {
      if (_category != null && e.category != _category) return false;
      if (_date != null && !DateUtils.isSameDay(e.date, _date)) return false;
      if (q.isNotEmpty) {
        final hay = '${e.title} ${e.note ?? ''}'.toLowerCase();
        if (!hay.contains(q)) return false;
      }
      return true;
    }).toList()..sort((a, b) => b.date.compareTo(a.date));
  }

  void _delete(Expense e) {
    final bloc = context.read<ExpenseBloc>();
    bloc.add(ExpenseDeleted(e.id));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Deleted "${e.title}"'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => bloc.add(ExpenseAdded(e)),
          ),
        ),
      );
  }

  void _edit(Expense e) =>
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => AddExpensePage(existing: e)));

  String _friendlyDate(DateTime d) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(DateTime(d.year, d.month, d.day)).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return DateFormat.yMMMd().format(d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomHeader(title: "History Details".toUpperCase()),
        actions: [
          if (_hasFilters)
            TextButton(onPressed: _clearFilters, child: const Text('Clear')),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            switch (state.status) {
              case ExpenseStatus.initial:
              case ExpenseStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ExpenseStatus.failure:
                return HistoryMessage(
                  icon: FontAwesomeIcons.history,
                  title: "Couldn't load your expenses",
                  subtitle: state.errorMessage ?? 'Something went wrong.',
                  actionLabel: 'Retry',
                  onAction: () => context.read<ExpenseBloc>().add(
                    const ExpensesSubscriptionRequested(),
                  ),
                );
              case ExpenseStatus.success:
                return _buildContent(state);
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent(ExpenseState state) {
    final filtered = _apply(state.expenses);
    final total = filtered.fold<double>(0, (s, e) => s + e.amount);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.sm,
          ),
          child: Column(
            children: [
              TextField(
                onChanged: (v) => setState(() => _query = v),
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  hintText: 'Search title or note',
                  prefix: Padding(
                    padding: EdgeInsets.only(left: 12, right: 10),
                    child: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 15),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: DateField(
                      date: _date ?? DateTime.now(),
                      onChanged: (d) => setState(() => _date = d),
                    ),
                  ),

                  if (_date != null)
                    IconButton(
                      tooltip: 'Clear date',
                      icon: const Icon(Icons.close, size: 18),
                      onPressed: () => setState(() => _date = null),
                    ),
                ],
              ),
            ],
          ),
        ),
        CategoryFilterBar(
          selected: _category,
          onChanged: (c) => setState(() => _category = c),
        ),
        HistorySummaryRow(count: filtered.length, total: total),
        Expanded(
          child: filtered.isEmpty
              ? HistoryMessage(
                  icon: FontAwesomeIcons.receipt,
                  title: _hasFilters ? 'No matches' : 'No expenses yet',
                  subtitle: _hasFilters
                      ? 'Try changing or clearing your filters.'
                      : 'Add your first expense from the home screen.',
                  actionLabel: _hasFilters ? 'Clear filters' : null,
                  onAction: _hasFilters ? _clearFilters : null,
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xl,
                    0,
                    AppSpacing.xl,
                    AppSpacing.xxxl,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, i) {
                    final e = filtered[i];
                    return DismissibleExpenseTile(
                      expense: e,
                      dateLabel: _friendlyDate(e.date),
                      onTap: () => _edit(e),
                      onDelete: _delete,
                    );
                  },
                ),
        ),
      ],
    );
  }
}
