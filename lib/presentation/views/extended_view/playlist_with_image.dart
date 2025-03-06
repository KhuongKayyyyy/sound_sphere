import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class PlaylistWithImage extends StatefulWidget {
  final String imageUrl;
  const PlaylistWithImage({super.key, required this.imageUrl});

  @override
  State<PlaylistWithImage> createState() => _PlaylistWithImageState();
}

class _PlaylistWithImageState extends State<PlaylistWithImage> {
  Color _dominantColor = Colors.grey;

  @override
  void initState() {
    super.initState();
    _extractDominantColor();
  }

  Future<void> _extractDominantColor() async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.imageUrl),
    );
    setState(() {
      _dominantColor = paletteGenerator.dominantColor?.color ?? Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            title: _buildExpandedAppBar(),
            background: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            "Browse",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 1550,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandedAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPlayButton("Play", Icons.play_arrow_rounded),
          const SizedBox(width: 10),
          _buildPlayButton("Shuffle", CupertinoIcons.shuffle_thick),
        ],
      ),
    );
  }

  Container _buildPlayButton(String text, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: _dominantColor.withOpacity(0.75),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
