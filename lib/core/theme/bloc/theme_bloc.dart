import 'package:expens_tracker/export/export.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ThemeModeChanged>(_onThemeModeChanged);
    on<ThemeModeToggled>(_onThemeModeToggled);
  }

  void _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) {
    emit(ThemeState(mode: event.mode));
  }

  void _onThemeModeToggled(
    ThemeModeToggled event,
    Emitter<ThemeState> emit,
  ) {
    final next = state.mode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    emit(ThemeState(mode: next));
  }
}