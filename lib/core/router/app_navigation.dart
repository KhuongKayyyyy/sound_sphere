import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/presentation/views/album_detail/album_detail_page.dart';
import 'package:sound_sphere/presentation/views/artist_detail/artist_detail_page.dart';
import 'package:sound_sphere/presentation/views/main/browse/browse_page.dart';
import 'package:sound_sphere/presentation/views/main/for_you/for_you_page.dart';
import 'package:sound_sphere/presentation/views/main/home/subpage/add_artist_page.dart';
import 'package:sound_sphere/presentation/views/main/home/subpage/history_playlist_page.dart';
import 'package:sound_sphere/presentation/views/main/home/home_page.dart';
import 'package:sound_sphere/presentation/views/main/library/library_page.dart';
import 'package:sound_sphere/presentation/views/main_wrapper.dart';
import 'package:sound_sphere/presentation/views/player/player_page.dart';
import 'package:sound_sphere/presentation/views/main/search/search_page.dart';
import 'package:sound_sphere/presentation/views/single_eps_detail/single_eps_detail_page.dart';

class AppNavigation {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> _homeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'homeNavigator');
  static final GlobalKey<NavigatorState> _browseNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'browseNavigator');
  static final GlobalKey<NavigatorState> _forYouNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'searchNavigator');
  static final GlobalKey<NavigatorState> _libraryNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'libraryNavigator');
  static final GlobalKey<NavigatorState> _searchNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'searchNavigator');

  static final GoRouter router = GoRouter(
      initialLocation: Routes.home,
      routes: [_buildMainShellRoute(), ..._buildNoPlayerBranch()],
      navigatorKey: _rootNavigatorKey);

  static StatefulShellRoute _buildMainShellRoute() {
    return StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainWrapper(navigationShell: navigationShell),
        branches: [
          _buildHomeBranch(),
          _buildBrowseBranch(),
          _buildForYouBranch(),
          _buildLibraryBranch(),
          _buildSearchBranch(),
        ]);
  }

  static List<GoRoute> _buildNoPlayerBranch() {
    return [
      GoRoute(
          path: Routes.addArtist,
          name: Routes.addArtist,
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            return const AddArtistPage();
          }),
      GoRoute(
          path: Routes.player,
          name: Routes.player,
          builder: (context, state) {
            return const PlayerPage();
          }),
      // GoRoute(
      //     path: Routes.signup,
      //     name: Routes.signup,
      //     builder: (context, state) {
      //       return const SignUpPage();
      //     })
    ];
  }

  static StatefulShellBranch _buildHomeBranch() {
    return StatefulShellBranch(
      navigatorKey: _homeNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.home, // Home path
          name: Routes.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: Routes.historyPlaylist,
          name: Routes.historyPlaylist,
          builder: (context, state) => const HistoryPlaylistPage(),
        ),
        GoRoute(
          path: Routes.albumDetail,
          name: Routes.albumDetail,
          builder: (context, state) {
            final albumId = state.extra as String;
            return AlbumDetailPage(
              albumId: albumId,
            );
          },
        ),
        GoRoute(
          path: Routes.artistDetail,
          name: Routes.artistDetail,
          builder: (context, state) {
            final artistId = state.extra as String;
            return ArtistDetailPage(
              artistId: artistId,
            );
          },
        ),
        GoRoute(
          path: Routes.songDetail,
          name: Routes.songDetail,
          builder: (context, state) {
            final songId = state.extra as String;
            return SingleEPsDetailPage(
              songId: songId,
            );
          },
        )
      ],
    );
  }

  static StatefulShellBranch _buildBrowseBranch() {
    return StatefulShellBranch(
      navigatorKey: _browseNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.browse,
          name: Routes.browse,
          builder: (context, state) => const BrowsePage(),
        )
      ],
    );
  }

  static StatefulShellBranch _buildForYouBranch() {
    return StatefulShellBranch(
      navigatorKey: _forYouNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.forYou,
          name: Routes.forYou,
          builder: (context, state) => const ForYouPage(),
        )
      ],
    );
  }

  static StatefulShellBranch _buildLibraryBranch() {
    return StatefulShellBranch(
      navigatorKey: _libraryNavigatorKey,
      routes: [
        GoRoute(
          path: Routes.library,
          name: Routes.library,
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
          path: Routes.search,
          name: Routes.search,
          builder: (context, state) => const SearchPage(),
        )
      ],
    );
  }
}
