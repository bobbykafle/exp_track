import 'package:expens_tracker/export/export.dart';


class ThemeState extends Equatable {
  const ThemeState({
    this.mode = ThemeMode.light,
  });

  final ThemeMode mode;

  bool get isDark => mode == ThemeMode.dark;

  @override
  List<Object?> get props => [mode];
}