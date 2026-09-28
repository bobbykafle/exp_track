import 'package:expens_tracker/export/export.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  const DateField({super.key, required this.date, required this.onChanged});

  final DateTime date;
  final ValueChanged<DateTime> onChanged;

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: date.isAfter(now) ? now : date,
      firstDate: DateTime(2000),
      lastDate: now, 
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => _pick(context),
      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: FaIcon(FontAwesomeIcons.calendarDays, size: 15, color: theme.textTheme.bodyMedium?.color),
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          contentPadding: const EdgeInsets.only(right: AppSpacing.md, top: AppSpacing.md, bottom: AppSpacing.md),
        ),
        child: Text(
          DateFormat.yMMMd().format(date),
          style: AppTextStyles.bodyMedium.copyWith(color: theme.colorScheme.onSurface),
        ),
      ),
    );
  }
}