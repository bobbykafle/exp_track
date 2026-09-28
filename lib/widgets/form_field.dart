import 'package:expens_tracker/export/export.dart';
class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        child: Text(text, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
      );
}