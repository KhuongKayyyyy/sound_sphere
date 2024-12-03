import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/presentation/widgets/media/media_item.dart';

class MediaSection extends StatelessWidget {
  final String mediaSectionTitle;
  final List<Track>? songList;
  final List<Album>? albumList;
  final bool isExpandable;
  final VoidCallback? onPressed;

  const MediaSection({
    super.key,
    required this.mediaSectionTitle,
    this.songList,
    this.albumList,
    required this.isExpandable,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Create a list of media items (combining songs and albums)
    final List<Widget> mediaItems = [
      if (songList != null) ...songList!.map((song) => MediaItem(track: song)),
      if (albumList != null)
        ...albumList!.map((album) => MediaItem(album: album)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 10),
        if (mediaItems.isNotEmpty)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              itemCount: mediaItems.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: mediaItems[index],
              ),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 10),
            child: Text(
              'No items available',
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    );
  }

  /// Builds the section header with title and expandable button
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            mediaSectionTitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          if (isExpandable)
            IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              padding: EdgeInsets.zero,
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
