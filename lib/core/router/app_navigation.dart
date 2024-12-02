import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/search_category.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/views/album_detail/album_detail_page.dart';
import 'package:sound_sphere/presentation/views/artist_detail/artist_detail_page.dart';
import 'package:sound_sphere/presentation/views/extended_view/all_song_grid.dart';
import 'package:sound_sphere/presentation/views/extended_view/all_song_list.dart';
import 'package:sound_sphere/presentation/views/main/browse/browse_page.dart';
import 'package:sound_sphere/presentation/views/main/for_you/for_you_page.dart';
import 'package:sound_sphere/presentation/views/main/home/subpage/add_artist_page.dart';
import 'package:sound_sphere/presentation/views/main/home/subpage/history_playlist_page.dart';
import 'package:sound_sphere/presentation/views/main/home/home_page.dart';
import 'package:sound_sphere/presentation/views/main/library/library_page.dart';
import 'package:sound_sphere/presentation/views/main/search/components/into_search.dart';
import 'package:sound_sphere/presentation/views/main/search/subpage/artist_we_love_page.dart';
import 'package:sound_sphere/presentation/views/main/search/subpage/search_category_detail.dart';
import 'package:sound_sphere/presentation/views/main_wrapper/main_wrapper.dart';
import 'package:sound_sphere/presentation/views/main/search/search_page.dart';
import 'package:sound_sphere/presentation/views/player/player_page.dart';
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
          builder: (context, state) => PlayerPage(),
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: PlayerPage(),
              transitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Slide transition from bottom
                const begin = Offset(0.0, 1.0); // Starts from bottom
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
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
            final artist = state.extra as Artist;
            return ArtistDetailPage(
              artist: artist,
            );
          },
        ),
        GoRoute(
          path: Routes.songDetail,
          name: Routes.songDetail,
          builder: (context, state) {
            final trackId = state.extra as String;
            return SingleEPsDetailPage(
              trackId: trackId,
            );
          },
        ),
        GoRoute(
          path: Routes.extendGridView,
          name: Routes.extendGridView,
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            final songList = extras['songs'] as List<Track>;
            final title = extras['title'] as String;
            return AllSongGrid(
              songs: songList,
              title: title,
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
        ),
        GoRoute(
          path: Routes.extendListView,
          name: Routes.extendListView,
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            final songList = extras['songs'] as List<Track>;
            final title = extras['title'] as String;
            return AllSongList(
              songs: songList,
              title: title,
            );
          },
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
        ),
        GoRoute(
          path: Routes.intoSearch,
          name: Routes.intoSearch,
          builder: (context, state) => const IntoSearch(),
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const IntoSearch(),
              transitionDuration: const Duration(milliseconds: 200),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                // Slide transition from bottom
                const begin = Offset(0.0, 1.0); // Starts from bottom
                const end = Offset.zero;
                const curve = Curves.easeInOut;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(position: offsetAnimation, child: child);
              },
            );
          },
        ),
        GoRoute(
          path: Routes.searchCategoryDetail,
          name: Routes.searchCategoryDetail,
          builder: (context, state) {
            final category = state.extra as SearchCategory;
            return SearchCategoryDetail(
              category: category,
            );
          },
        ),
        GoRoute(
            path: Routes.extendArtistList,
            name: Routes.extendArtistList,
            builder: (context, state) {
              return ArtistWeLovePage();
            })
      ],
    );
  }
}
