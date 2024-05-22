import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:mispris_course/presentation/edit_page/edit_page.dart';
import 'package:mispris_course/presentation/list_page/list_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _listTabNavigatorKey = GlobalKey<NavigatorState>();
final _editTabNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/list',
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        return Scaffold(
          body: shell,
          bottomNavigationBar: MainNavigationBar(shell: shell),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _listTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/list',
              builder: (context, state) => const ListPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _editTabNavigatorKey,
          routes: [
            GoRoute(
              path: '/editor',
              builder: (context, state) => const EditPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MainNavigationBar extends StatelessWidget {
  final StatefulNavigationShell shell;

  const MainNavigationBar({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: (index) => shell.goBranch(
        index,
        initialLocation: index == shell.currentIndex,
      ),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.list_alt_outlined),
          selectedIcon: Icon(Icons.list_alt_outlined),
          label: 'Классификатор',
        ),
        NavigationDestination(
          icon: Icon(Icons.draw_rounded),
          selectedIcon: Icon(Icons.draw_rounded),
          label: 'Редактор',
        ),
      ],
    );
  }
}
