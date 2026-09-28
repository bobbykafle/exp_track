import 'package:expens_tracker/export/export.dart';
import 'package:flutter/cupertino.dart';

class AppHomeHeader extends StatelessWidget {
  const AppHomeHeader({
    super.key,
    required this.title,
    this.avatarUrl,
    this.onAvatarTap,
  });

  final String title;
  final String? avatarUrl;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeBloc>().state.isDark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onAvatarTap,
              child: CircleAvatar(
                radius: AppSpacing.iconLg,
                backgroundColor: isDark
                    ? AppColors.darkSurfaceMuted
                    : AppColors.lightSurfaceMuted,
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl!)
                    : null,
                child: avatarUrl == null
                    ? Icon(
                        CupertinoIcons.person_fill,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                        size: AppSpacing.iconMd,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
          ],
        ),

        BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return IconButton(
              tooltip: themeState.mode == ThemeMode.system
                  ? 'System theme (Switch to Light)'
                  : themeState.mode == ThemeMode.light
                  ? 'Light mode (Switch to Dark)'
                  : 'Dark mode (Switch to System)',
              icon: FaIcon(
                themeState.mode == ThemeMode.light
                    ? FontAwesomeIcons.solidSun
                    : FontAwesomeIcons.moon,
                size: 15,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
              onPressed: () {
                context.read<ThemeBloc>().add(const ThemeModeToggled());
              },
            );
          },
        ),
      ],
    );
  }
}
