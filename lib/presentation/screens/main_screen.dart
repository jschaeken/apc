import 'package:apc/presentation/pages/home_page.dart';
import 'package:apc/presentation/pages/network_page.dart';
import 'package:apc/presentation/state/auth_provider.dart';
import 'package:apc/presentation/state/nav_provider.dart';
import 'package:apc/presentation/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<RoutePage> _routePages = [
    const RoutePage(
      name: 'Home',
      icons: [CupertinoIcons.home, CupertinoIcons.house_fill],
      page: HomePage(),
    ),
    const RoutePage(
      name: 'Network',
      icons: [CupertinoIcons.person_2, CupertinoIcons.person_2_fill],
      page: NetworkPage(),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _setIndex(int index) {
    Provider.of<NavProvider>(context, listen: false).setIndex(index);
  }

  void _logout(BuildContext context) {
    Provider.of<AuthProvider>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'A Players Club',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: WidgetConstants.horizontalPadding,
            child: GestureDetector(
              onTap: () => _logout(context),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: Icon(
                  CupertinoIcons.person,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          )
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.primary
              ],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
        ),
      ),
      body: Consumer<NavProvider>(
        builder: (context, navProvider, child) {
          return _routePages[navProvider.currentIndex].page;
        },
      ),
      bottomNavigationBar: Consumer<NavProvider>(
        builder: (context, provider, child) => BottomNavigationBar(
          onTap: (i) => _setIndex(i),
          items: _routePages.map((page) {
            final bool isSelected =
                _routePages.indexOf(page) == provider.currentIndex;
            return BottomNavigationBarItem(
              icon: Icon(
                page.icons[isSelected ? 1 : 0],
                color: isSelected
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              label: page.name,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class RoutePage {
  final String name;
  final List<IconData> icons;
  final Widget page;

  const RoutePage({
    required this.name,
    required this.icons,
    required this.page,
  });
}
