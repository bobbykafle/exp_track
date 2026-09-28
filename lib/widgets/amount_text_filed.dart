import 'package:expens_tracker/export/export.dart';

class AmountField extends StatelessWidget {
  const AmountField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.errorText,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurface.withValues(alpha: 0.4);
    final line = theme.dividerTheme.color ?? theme.dividerColor;

    UnderlineInputBorder border(Color c, [double w = 1.5]) =>
        UnderlineInputBorder(borderSide: BorderSide(color: c, width: w));

    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
      style: AppTextStyles.displayLarge.copyWith(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        filled: false,
        hintText: '0.00',
        hintStyle: AppTextStyles.displayLarge.copyWith(color: muted),
        prefixText: '\$ ',
        prefixStyle: AppTextStyles.h2.copyWith(color: muted),
        errorText: errorText,
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        border: border(line),
        enabledBorder: border(line),
        focusedBorder: border(theme.colorScheme.primary, 2),
        errorBorder: border(theme.colorScheme.error),
        focusedErrorBorder: border(theme.colorScheme.error, 2),
      ),
    );
  }
}