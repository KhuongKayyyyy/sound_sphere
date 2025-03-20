import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/playlist.dart';
import 'package:sound_sphere/data/models/search_category.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/views/account/edit_profile_page.dart';
import 'package:sound_sphere/presentation/views/account/manage_payment_page.dart';
import 'package:sound_sphere/presentation/views/account/notification_page.dart';
import 'package:sound_sphere/presentation/views/account/profile_page.dart';
import 'package:sound_sphere/presentation/views/account/purchase_history.dart';
import 'package:sound_sphere/presentation/views/account/subscription_page.dart';
import 'package:sound_sphere/presentation/views/add_in/credit_page.dart';
import 'package:sound_sphere/presentation/views/album_detail/album_detail_page.dart';
import 'package:sound_sphere/presentation/views/artist_detail/artist_detail_page.dart';
import 'package:sound_sphere/presentation/views/authentication/authentication_page.dart';
import 'package:sound_sphere/presentation/views/extended_view/all_song_grid.dart';
import 'package:sound_sphere/presentation/views/extended_view/all_song_list.dart';
import 'package:sound_sphere/presentation/views/extended_view/playlist_extended_list.dart';
import 'package:sound_sphere/presentation/views/extended_view/playlist_with_image.dart';
import 'package:sound_sphere/presentation/views/main/browse/browse_page.dart';
import 'package:sound_sphere/presentation/views/main/download/download_page.dart';
import 'package:sound_sphere/presentation/views/main/for_you/for_you_page.dart';
import 'package:sound_sphere/presentation/views/main/home/subpage/add_artist_page.dart';
import 'package:sound_sphere/presentation/views/main/home/subpage/history_playlist_page.dart';
import 'package:sound_sphere/presentation/views/main/home/home_page.dart';
import 'package:sound_sphere/presentation/views/main/library/library_album_page.dart';
import 'package:sound_sphere/presentation/views/main/library/library_artist_page.dart';
import 'package:sound_sphere/presentation/views/main/library/library_genre_page.dart';
import 'package:sound_sphere/presentation/views/main/library/library_made4u_page.dart';
import 'package:sound_sphere/presentation/views/main/library/library_page.dart';
import 'package:sound_sphere/presentation/views/main/library/library_playlist_page.dart';
import 'package:sound_sphere/presentation/views/main/library/library_song_page.dart';
import 'package:sound_sphere/presentation/views/main/search/components/into_search.dart';
import 'package:sound_sphere/presentation/views/main/search/subpage/artist_we_love_page.dart';
import 'package:sound_sphere/presentation/views/main/search/subpage/search_category_detail.dart';
import 'package:sound_sphere/presentation/views/main_wrapper/main_wrapper.dart';
import 'package:sound_sphere/presentation/views/main/search/search_page.dart';
import 'package:sound_sphere/presentation/views/player/player_page.dart';
import 'package:sound_sphere/presentation/views/playlist/playlist_detail_page.dart';
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
  static final GlobalKey<NavigatorState> _addInNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'addInNavigator');

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
          _buildAddInBranch(),
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
      GoRoute(
        path: Routes.authentication,
        name: Routes.authentication,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const AuthenticationPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1), // Start from bottom
                  end: Offset.zero, // End at original position
                ).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
          path: Routes.notificationPage,
          name: Routes.notificationPage,
          builder: (context, state) {
            return const NotificationPage();
          }),
      GoRoute(
          path: Routes.managePayment,
          name: Routes.managePayment,
          builder: (context, state) {
            return const ManagePaymentPage();
          }),
      GoRoute(
          path: Routes.subscription,
          name: Routes.subscription,
          builder: (context, state) {
            return const SubscriptionPage();
          }),
      GoRoute(
          path: Routes.purchaseHistory,
          name: Routes.purchaseHistory,
          builder: (context, state) {
            return const PurchaseHistory();
          }),
      GoRoute(
          path: Routes.editProfile,
          name: Routes.editProfile,
          builder: (context, state) {
            return const EditProfilePage();
          }),
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
          path: Routes.playlistExtened,
          name: Routes.playlistExtened,
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            final songList = extras['songs'] as List<Track>;
            final title = extras['title'] as String;
            final page = extras['page'] as int;
            final limit = extras['limit'] as int;
            return PlayListExtendedList(
              tracks: songList,
              title: title,
              page: page,
              limit: limit,
            );
          },
        ),
        GoRoute(
          path: Routes.extendedList,
          name: Routes.extendedList,
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            final songList = extras['songs'] as List<Track>;
            final title = extras['title'] as String;

            return AllSongList(tracks: songList, title: title);
          },
        ),
        GoRoute(
          path: Routes.playlistExtendedWithImage,
          name: Routes.playlistExtendedWithImage,
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>;
            final imageUrl = extras['imageUrl'] as String;
            return PlaylistWithImage(imageUrl: imageUrl);
          },
        ),
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
        ),
        GoRoute(
          path: Routes.playlistLibrary,
          name: Routes.playlistLibrary,
          builder: (context, state) => LibraryPlaylistPage(),
        ),
        GoRoute(
          path: Routes.artistLibrary,
          name: Routes.artistLibrary,
          builder: (context, state) => const LibraryArtistPage(),
        ),
        GoRoute(
          path: Routes.albumLibrary,
          name: Routes.albumLibrary,
          builder: (context, state) => const LibraryAlbumPage(),
        ),
        GoRoute(
          path: Routes.songLibrary,
          name: Routes.songLibrary,
          builder: (context, state) => const LibrarySongPage(),
        ),
        GoRoute(
          path: Routes.made4uLibrary,
          name: Routes.made4uLibrary,
          builder: (context, state) => const LibraryMade4uPage(),
        ),
        GoRoute(
          path: Routes.genreLibrary,
          name: Routes.genreLibrary,
          builder: (context, state) => const LibraryGenrePage(),
        ),
        GoRoute(
          path: Routes.download,
          name: Routes.download,
          builder: (context, state) => const DownloadPage(),
        ),
        GoRoute(
          path: Routes.playlistDetailPage,
          name: Routes.playlistDetailPage,
          builder: (context, state) {
            final playlist = state.extra as Playlist;
            return PlaylistDetailPage(
              playlist: playlist,
            );
          },
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

  static StatefulShellBranch _buildAddInBranch() {
    return StatefulShellBranch(
      navigatorKey: _addInNavigatorKey,
      routes: [
        GoRoute(
            path: Routes.creditPage,
            name: Routes.creditPage,
            builder: (context, state) {
              final extras = state.extra as Map<String, dynamic>;
              final track = extras['track'] as Track;
              return CreditPage(track: track);
            }),
        GoRoute(
          path: Routes.profile,
          name: Routes.profile,
          builder: (context, state) {
            return const ProfilePage();
          },
        )
      ],
    );
  }
}
