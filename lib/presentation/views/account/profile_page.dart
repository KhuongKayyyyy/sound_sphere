import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/core/utils/helpers.dart';
import 'package:sound_sphere/data/models/app_user.dart';
import 'package:sound_sphere/data/models/playlist.dart';
import 'package:sound_sphere/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:sound_sphere/presentation/blocs/playlist/playlist_bloc.dart';
import 'package:sound_sphere/presentation/views/account/edit_profile_page.dart';
import 'package:sound_sphere/presentation/views/main/browse/components/vertical_playlist_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<PlaylistBloc>().add(PlaylistGetListRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildProfileAppBar(context),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
          if (authState is AuthGetUserSuccess) {
            return _buildProfileBody(authState.user);
          } else if (authState is AuthLoading) {
            return Skeletonizer(
              enabled: true,
              child: _buildProfileItem(AppUser.empty()),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text(
                  "Error loading profile",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  SingleChildScrollView _buildProfileBody(AppUser user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfileItem(user),
          const SizedBox(height: 16),
          _buildListeningToSection(),
          const SizedBox(height: 16),
          BlocBuilder<PlaylistBloc, PlaylistState>(
            builder: (context, state) {
              if (state is PlaylistLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: _buildPlaylistSection(FakeData.playlists),
                );
              } else if (state is PlaylistGetSuccess) {
                final publicPlaylists = state.playlists
                    .where((playlist) => playlist.isPublic!)
                    .toList();
                if (publicPlaylists.isEmpty) {
                  return Container();
                }
                return _buildPlaylistSection(state.playlists);
              } else if (state is PlaylistGetFailure) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      "Error loading playlists",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 16),
          _buildButton("Follow More Friends", true, onPressed: () {}),
          const SizedBox(height: 170),
        ],
      ),
    );
  }

  Widget _buildPlaylistSection(List<Playlist> playlists) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              "Playlists",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(height: 250, child: _buildPlaylistList(playlists)),
        ],
      ),
    );
  }

  ListView _buildPlaylistList(List<Playlist> playlists) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        if (playlists[index].isPublic == true) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 16 : 8,
              right: index == playlists.length - 1 ? 16 : 8,
              top: 8,
              bottom: 8,
            ),
            child: VerticalPlaylistItem(
              onTap: () {
                print("Playlist $index");
              },
              img:
                  "https://variety.com/wp-content/uploads/2024/11/Press-Image-2-Credit-pgLang.jpg",
              isBig: false,
              title: playlists[index].name!,
              subtitle:
                  "Updated ${playlists[index].updatedAt!.toLocal().day} / ${playlists[index].updatedAt!.toLocal().month} / ${playlists[index].updatedAt!.toLocal().year}",
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildListeningToSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Listening To",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 8,
                    right: index == 4 ? 16 : 8,
                    top: 8,
                    bottom: 8,
                  ),
                  child: VerticalPlaylistItem(
                      img:
                          "https://variety.com/wp-content/uploads/2024/11/Press-Image-2-Credit-pgLang.jpg",
                      isBig: false,
                      title: "Playlist $index",
                      subtitle: "Updated 2 days ago"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(AppUser user) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                user.avatarUrl,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.displayName,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              Helpers.getUserNickName(user.email),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildButton("Edit", false, onPressed: () {
              _showEditProfileBottomModal(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String buttonText, bool isBig, {Function()? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: isBig ? 32 : 16, vertical: isBig ? 16 : 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(isBig ? 10 : 30),
              color: AppColor.primaryColor,
            ),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildProfileAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.back,
            color: AppColor.primaryColor,
            size: 24,
          )),
      title: const Text('Profile'),
      actions: [
        InkWell(
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.more_horiz,
              color: AppColor.primaryColor,
              size: 24,
            ),
          ),
        )
      ],
    );
  }

  void _showEditProfileBottomModal(BuildContext context) {
    showCupertinoModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (context) => EditProfilePage());
  }
}
