import 'package:expens_tracker/export/export.dart';



class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _screens = const [
    HomePage(),
    ExpenseHistoryPage(),
    
    MessagesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      listenWhen: (prev, curr) => curr.actionError != null,
  listener: (context, state) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(state.actionError!)));
  },
      child: Scaffold(
        backgroundColor: AppColors.primary.withOpacity(0.9),
        body: IndexedStack(index: _currentPageIndex, children: _screens),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const AddExpensePage()));
          },
          backgroundColor: AppColors.primaryDark,
          elevation: 0,
          shape: const CircleBorder(),
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: AppColors.darkTextPrimary,
            size: 22,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentPageIndex > 1
              ? _currentPageIndex - 1
              : _currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: FaIcon(FontAwesomeIcons.house, size: 20),
              icon: FaIcon(FontAwesomeIcons.house, size: 20),
              label: 'Home',
            ),
            // NavigationDestination(
            //   selectedIcon: FaIcon(FontAwesomeIcons.chartPie, size: 20),
            //   icon: FaIcon(FontAwesomeIcons.chartPie, size: 20),
            //   label: 'Analysis',
            // ),
            // Center space placeholder for floating action button alignment
            NavigationDestination(
              icon: SizedBox.shrink(),
              label: '',
              enabled: true,
            ),
            // NavigationDestination(
            //   selectedIcon: FaIcon(FontAwesomeIcons.history, size: 20),
            //   icon: FaIcon(FontAwesomeIcons.bell, size: 20),
            //   label: 'History',
            // ),
            // NavigationDestination(
            //   selectedIcon: FaIcon(FontAwesomeIcons.gear, size: 20),
            //   icon: FaIcon(FontAwesomeIcons.gear, size: 20),
            //   label: 'Settings',
            // ),
          ],
        ),
      ),
    );
  }
}


class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(child: Text('Settings Screen', style: AppTextStyles.h2)),
    );
  }
}
