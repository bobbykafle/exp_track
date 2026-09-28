import 'package:expens_tracker/firebase_options.dart';

import 'export/export.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (FirebaseAuth.instance.currentUser == null) {
    await FirebaseAuth.instance.signInAnonymously();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ExpenseRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
          BlocProvider<ExpenseBloc>(
            create: (context) => ExpenseBloc(
              repository: context.read<ExpenseRepository>(),
            )..add(const ExpensesSubscriptionRequested()),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            return MaterialApp(
              title: 'Expense Tracker Mobile App',
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeState.mode, 
              debugShowCheckedModeBanner: false,
              home: const MainNavigationScreen(),
            );
          },
        ),
      ),
    );
  }
}