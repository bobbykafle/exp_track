import 'package:expens_tracker/export/export.dart';
import 'package:flutter/cupertino.dart';


class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onPressed,
    this.color,
    this.padding = EdgeInsets.zero,
  });

  final VoidCallback? onPressed;
  final Color? color;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final defaultColor = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: padding,
      child: IconButton(
        onPressed:
            onPressed ??
            () => Navigator.of(context).popUntil((route) => route.isFirst),
        icon: Icon(
          CupertinoIcons.arrow_left,
          color: color ?? defaultColor,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        splashRadius: 22,
      ),
    );
  }
}