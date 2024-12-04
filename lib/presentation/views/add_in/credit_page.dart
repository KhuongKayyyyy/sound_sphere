import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/controller/player_controller.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/core/utils/helpers.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/views/add_in/lyric_modal.dart';

class CreditPage extends StatefulWidget {
  final Track track;
  const CreditPage({super.key, required this.track});

  @override
  State<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200]!.withOpacity(0.3),
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: AppColor.primaryColor,
            size: 30,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(3),
            child: Icon(
              Icons.more_horiz,
              color: AppColor.primaryColor,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSongInfo(),
            _buildPlayButton(),
            _buildViewLyricButton(),
            _buildCollaboratorInfo("PERFORMING ARTISTS", "Performer",
                widget.track.featuredArtists!),
            _buildCollaboratorInfo("COMPOSITION & LYRICS", "Composer",
                widget.track.featuredArtists!),
            _buildCollaboratorInfo("PRODUCTION & ENGINEERING", "Producer",
                widget.track.featuredArtists!),
            _buildAvailableAudioQuality(),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvailableAudioQuality() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AVAILABLE AUDIO QUALITY",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Image.asset(AppIcon.dolby,
                      height: 30, width: 30, color: Colors.white),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dolby Atmos",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        "Lossless uses SoundSphere Lossless Audio Codec (SLAC) to preverve every single bit of the original audio file.",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.grey),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollaboratorInfo(
      String title, String role, List<Artist> artists) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: artists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(artists.elementAt(index).name!),
                  subtitle: Text(
                    role,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(FakeData.artists.first.avatarURL!),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  InkWell _buildViewLyricButton() {
    return InkWell(
      onTap: () {
        lyricBottomModalSheet();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[300]!),
              ),
              padding: const EdgeInsets.all(5),
              child: Icon(
                Icons.lyrics_outlined,
                color: AppColor.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "View Lyrics",
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColor.primaryColor,
            )
          ],
        ),
      ),
    );
  }

  // Future<dynamic> lyricBottomModalSheet() {
  //   return showModalBottomSheet(
  //     isScrollControlled: true,
  //     useRootNavigator: true,
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         height: MediaQuery.of(context).size.height * 0.9,
  //         padding: const EdgeInsets.all(20),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               widget.track.title,
  //               style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
  //             ),
  //             const SizedBox(height: 10),
  //             Text(
  //               "${widget.track.artist.name!} · ${widget.track.album.title} · ${Helpers.formatDate(widget.track.releaseDate!)}",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 color: AppColor.inkGreyDark,
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 15,
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> lyricBottomModalSheet() {
    return showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true, // Allow full screen height
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => LyricModal(track: widget.track),
    );
  }

  InkWell _buildPlayButton() {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        PlayerController().setPlayerAudio([widget.track]);
        PlayerController().play();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 90, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_arrow_rounded,
              color: AppColor.primaryColor,
              size: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Play",
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSongInfo() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.track.imgURL,
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.height * 0.2,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          widget.track.title,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          child: Text(
            "${widget.track.artist.name!}·${widget.track.album.title} · ${Helpers.formatDate(widget.track.releaseDate!)}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.inkGreyDark,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
