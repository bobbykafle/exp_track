import 'package:expens_tracker/export/export.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
 

  const CustomHeader({
    super.key,
    required this.title,
  	this.trailing,
    
  });

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          

          Expanded(
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyles.h3.copyWith(
                fontWeight: FontWeight.bold,
                color: onSurface,
              ),
            ),
          ),

          if (trailing != null)
            trailing!
          else
            const SizedBox(width: 48), 
        ],
      ),
    );
  }
}