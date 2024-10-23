import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/presentation/views/browse/browse_page.dart';
import 'package:sound_sphere/presentation/views/home/home_page.dart';
import 'package:sound_sphere/presentation/views/library/library_page.dart';
import 'package:sound_sphere/presentation/views/main_wrapper.dart';
import 'package:sound_sphere/presentation/views/search/search_page.dart';

class AppNavigation {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _homeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeNavigator');
  static final GlobalKey<NavigatorState> _browseNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'browseNavigator');
  static final GlobalKey<NavigatorState> _libraryNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'libraryNavigator');
  static final GlobalKey<NavigatorState> _searchNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'searchNavigator');

  static final GoRouter router = GoRouter(
      initialLocation: Routes.home,
      routes: [_buildMainShellRoute()],
      navigatorKey: _rootNavigatorKey);

  static StatefulShellRoute _buildMainShellRoute() {
    return StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainWrapper(navigationShell: navigationShell),
        branches: [
          _buildHomeBranch(),
          _buildBrowseBranch(),
          _buildLibraryBranch(),
          _buildSearchBranch()
        ]);
  }

  static StatefulShellBranch _buildHomeBranch() {
    return StatefulShellBranch(
      navigatorKey: _homeNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.home, // Home path
          name: 'home', // Unique name for home
          builder: (context, state) => const HomePage(),
        )
      ],
    );
  }

  static StatefulShellBranch _buildBrowseBranch() {
    return StatefulShellBranch(
      navigatorKey: _browseNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.browse, // Browse path
          name: 'browse', // Unique name for browse
          builder: (context, state) => const BrowsePage(),
        )
      ],
    );
  }

  static StatefulShellBranch _buildLibraryBranch() {
    return StatefulShellBranch(
      navigatorKey: _libraryNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.library, // Library path
          name: 'library', // Unique name for library
          builder: (context, state) => const LibraryPage(),
        )
      ],
    );
  }

  static StatefulShellBranch _buildSearchBranch() {
    return StatefulShellBranch(
      navigatorKey: _searchNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.search, // Search path
          name: 'search', // Unique name for search
          builder: (context, state) => const SearchPage(),
        )
      ],
    );
  }
}
