import 'package:flutter/material.dart';
import 'package:image_color_builder/image_color_builder.dart';
import 'package:sound_sphere/core/constant/app_image.dart';
import 'package:sound_sphere/data/models/artist.dart';

class ArtistPlaylistItem extends StatefulWidget {
  final String playlistType;
  final Artist artist;
  const ArtistPlaylistItem(
      {super.key, required this.artist, required this.playlistType});

  @override
  State<ArtistPlaylistItem> createState() => _ArtistPlaylistItemState();
}

class _ArtistPlaylistItemState extends State<ArtistPlaylistItem> {
  @override
  Widget build(BuildContext context) {
    return ImageColorBuilder(
      url: widget.artist.avatarURL,
      fit: BoxFit.cover,
      maxCachedCount: 15,
      builder: (BuildContext context, Image? image, Color? imageColor) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.19,
          width: MediaQuery.of(context).size.width * 0.42,
          decoration: BoxDecoration(
            color: imageColor?.withOpacity(0.6) ?? Colors.red,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 5, top: 5),
                width: double.infinity,
                child: Text(
                  textAlign: TextAlign.right,
                  "Sound Sphere",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Text(
                    widget.playlistType,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.42,
                height: MediaQuery.of(context).size.height * 0.13,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  child: Image(
                      fit: BoxFit.cover,
                      image: image?.image ??
                          const AssetImage(AppImage.defaultImage)),
                ),
              ),
            ],
          ),
        );
      },
      placeholder: (contect, url) => Image.asset(
        AppImage.defaultImage,
        fit: BoxFit.fill,
      ),
      errorWidget: (context, url, error) => Image.asset(
        AppImage.defaultImage,
        fit: BoxFit.fill,
      ),
    );
  }
}
