import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/router/routes.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/res/track_repository.dart';
import 'package:sound_sphere/presentation/blocs/library/library_bloc.dart';
import 'package:sound_sphere/presentation/widgets/toast/unfavorite_toast.dart';
import 'package:sound_sphere/presentation/widgets/track/track_item.dart';

// ignore: must_be_immutable
class LibraryDetailPage extends StatefulWidget {
  final Track? track;
  const LibraryDetailPage({super.key, this.track});

  @override
  State<LibraryDetailPage> createState() => _LibraryDetailPageState();
}

class _LibraryDetailPageState extends State<LibraryDetailPage> {
  bool showAppBarTitle = false;
  ScrollController _scrollController = ScrollController();
  bool isFavorite = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 250 && !showAppBarTitle) {
      setState(() {
        showAppBarTitle = true;
      });
    } else if (_scrollController.offset <= 250 && showAppBarTitle) {
      setState(() {
        showAppBarTitle = false;
      });
    }
  }

  void _showToast(bool isFavorite) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 150,
        left: MediaQuery.of(context).size.width * 0.5 - 75, // Center the toast
        child: FavoriteToast(isFavorite: isFavorite),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LibraryBloc, LibraryState>(
      listener: (context, state) {
        if (state is RemoveTrackFromLibSuccess) {
          context.read<LibraryBloc>().add(GetTrackLibraryRequest());
          Navigator.of(context).pop();
          context.pop();
        }
      },
      child: Scaffold(
        body: _buildDetailBody(),
      ),
    );
  }

  CustomScrollView _buildDetailBody() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _buildSingleDetailAppBar(),
        _buildSingleDetailSection(),
        _buildPlaySection(),
        _buildSingleSongList(),
        _buildSingleBriefInfo(),
      ],
    );
  }

  SliverToBoxAdapter _buildSingleSongList() {
    return SliverToBoxAdapter(
        child: TrackItem(
      isFavorite: isFavorite,
      track: widget.track!,
      index: 1,
    ));
  }

  Widget _buildSingleDetailAppBar() {
    return SliverAppBar(
      toolbarHeight: 50,
      pinned: true,
      title: showAppBarTitle
          ? Text(
              widget.track!.title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
            )
          : null,
      centerTitle: true,
      actions: [
        _buildAppBarIcon(Icons.favorite_rounded, () {
          context.read<LibraryBloc>().add(ToggleTrackFavorite(
              track: widget.track!, isFavorite: !isFavorite));
        }),
        const SizedBox(
          width: 10,
        ),
        _buildAppBarIcon(Icons.delete, () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text("Confirm"),
                content: Text("Are you sure you want to remove this track?"),
                actions: [
                  CupertinoDialogAction(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    onPressed: () {
                      context
                          .read<LibraryBloc>()
                          .add(RemoveTrackFromLibRequest(widget.track!.id!));
                    },
                    child: Text("Remove"),
                  ),
                ],
              );
            },
          );
        }),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _buildAppBarIcon(IconData icon, Function() onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(5),
            child: Icon(
              icon,
              size: 20,
            )),
      ),
    );
  }

  Widget _buildSingleDetailSection() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              )
            ]),
            height: 200,
            width: 200,
            child: Hero(
              tag: "lib_img_${widget.track!.id}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.track!.imgURL,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "${widget.track!.title}- Single",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {
              context.pushNamed(Routes.artistDetail,
                  extra: widget.track!.artist);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                widget.track!.getArtistsAsString(),
                style: TextStyle(
                    fontSize: 20,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaySection() {
    return SliverToBoxAdapter(
      child: Row(
        children: [
          _buildPlayButton(AppIcon.play, "Play", () {
            PlayerController().setPlayerAudio([widget.track!]);
            PlayerController().isPlayingAlbum = false;
          }),
          _buildPlayButton(AppIcon.shuffle, "Shuffle", () {
            TrackRepository.getTracksOfArtist(widget.track!.artist.name!);
          }),
        ],
      ),
    );
  }

  Widget _buildPlayButton(String icon, String text, Function() onTap) {
    return Expanded(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                icon,
                scale: 30,
                color: AppColor.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSingleBriefInfo() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1 song, 4 minutes",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
            Text(
              "© ${widget.track!.getArtistsAsString()} ${widget.track!.album.title}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey[400]),
            ),
          ],
        ),
      ),
    );
  }
}
