import 'package:expens_tracker/export/export.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            switch (state.status) {
              case ExpenseStatus.initial:
              case ExpenseStatus.loading:
                return const _HomeLoading();
              case ExpenseStatus.failure:
                return _HomeError(
                  message: state.errorMessage ?? 'Something went wrong.',
                  onRetry: () => context.read<ExpenseBloc>().add(
                    const ExpensesSubscriptionRequested(),
                  ),
                );
              case ExpenseStatus.success:
                return _HomeContent(state: state, now: DateTime.now());
            }
          },
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.state, required this.now});

  final ExpenseState state;
  final DateTime now;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final money0 = NumberFormat.currency(symbol: r'$', decimalDigits: 0);
    final money2 = NumberFormat.currency(symbol: r'$');

    final total = state.totalForMonth(now);
    final recent = state.recent(limit: 5);
    final monthLabel = DateFormat.MMMM().format(now);

    final change = state.percentChangeVsPreviousMonth(now);
    final isIncrease = (change ?? 0) > 0;
    final prevMonthLabel = DateFormat.MMMM().format(
      DateTime(now.year, now.month - 1),
    );
    final comparison = change == null
        ? null
        : '${change.abs().toStringAsFixed(0)}% ${isIncrease ? 'more' : 'less'} than $prevMonthLabel';

    final top = state.biggestCategory(now);

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ExpenseBloc>().add(const ExpensesSubscriptionRequested());
      },
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.md,
          AppSpacing.xl,
          AppSpacing.xxxl,
        ),
        children: [
          AppHomeHeader(title: 'Good\n${_greeting()}'.toUpperCase()),

          const SizedBox(height: AppSpacing.lg),
          Text(monthLabel, style: AppTextStyles.h3.copyWith(color: onSurface)),
          const SizedBox(height: AppSpacing.sm),

          MonthlySummaryCard(
            total: total,
            monthLabel: monthLabel,
            comparisonLabel: comparison,
            isIncrease: isIncrease,
          ),
          const SizedBox(height: AppSpacing.md),

          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Biggest category',
                  value: top == null
                      ? '—'
                      : '${top.key} · ${money0.format(top.value)}',
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: StatCard(
                  label: 'Daily average',
                  value: money2.format(state.dailyAverage(now)),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent expenses',
                style: AppTextStyles.h3.copyWith(color: onSurface),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExpenseHistoryPage(),
                    ),
                  );
                },
                child: const Text('See all'),
              ),
            ],
          ),
          if (recent.isEmpty)
            const _HomeEmpty()
          else
            ...recent.map(
              (e) => ExpenseListTile(
                expense: e,
                dateLabel: _friendlyDate(e.date),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddExpensePage(existing: e),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _greeting() {
    final hour = now.hour;
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  }

  /// Today / Yesterday / Sep 24
  String _friendlyDate(DateTime d) {
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(d.year, d.month, d.day);
    final diff = today.difference(day).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return DateFormat.MMMd().format(d);
  }
}

class _HomeLoading extends StatelessWidget {
  const _HomeLoading();

  @override
  Widget build(BuildContext context) {
    Widget block({double height = 56, double? width}) => Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
    );

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        block(height: 100),
        const SizedBox(height: AppSpacing.xl),
        block(height: 20, width: 140),
        const SizedBox(height: AppSpacing.md),
        for (var i = 0; i < 4; i++) ...[
          block(),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _HomeEmpty extends StatelessWidget {
  const _HomeEmpty();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
      child: Column(
        children: [
          FaIcon(
            FontAwesomeIcons.receipt,
            size: 40,
            color: Theme.of(context).colorScheme.onSurface
                .withValues(alpha: 0.3),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No expenses yet',
            style: AppTextStyles.h3.copyWith(color: AppColors.warning),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Add your first expense to see it here.\n Click To Add ',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.warning),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _HomeError extends StatelessWidget {
  const _HomeError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 40,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              "Couldn't load your expenses",
              style: AppTextStyles.h3.copyWith(color: AppColors.danger),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              message,
              style: AppTextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
