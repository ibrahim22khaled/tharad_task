import 'package:flutter/material.dart';
import 'package:tharad_task/features/home/presentation/screens/home_screen.dart';
import 'package:tharad_task/features/home/presentation/screens/profile_screen.dart';
import 'package:tharad_task/features/home/presentation/widgets/bottom_app_bar.dart';
import 'package:tharad_task/gen/assets.gen.dart';
import 'package:tharad_task/l10n/app_localizations.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 0;

  final _pages = const [HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          NavBarItem(
            activeAssetPath: Assets.icons.activeHome,
            inactiveAssetPath: Assets.icons.nonactiveHome,
            label: tr.main,
          ),
          NavBarItem(
            activeAssetPath: Assets.icons.activeProfile,
            inactiveAssetPath: Assets.icons.nonactiveProfile,
            label: tr.profile,
          ),
        ],
      ),
    );
  }
}
