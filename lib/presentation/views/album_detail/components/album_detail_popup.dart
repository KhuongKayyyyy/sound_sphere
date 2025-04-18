import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/core/constant/app_icon.dart';
import 'package:sound_sphere/core/constant/app_image.dart';
import 'package:sound_sphere/core/utils/helpers.dart';
import 'package:sound_sphere/data/models/album.dart';
import 'package:flutter/foundation.dart';

class AlbumDetailPopup extends StatefulWidget {
  final Album album;

  const AlbumDetailPopup({super.key, required this.album});

  @override
  State<AlbumDetailPopup> createState() => _AlbumDetailPopupState();
}

class _AlbumDetailPopupState extends State<AlbumDetailPopup> {
  List<String> tempArtwork = [
    "https://boldinprints.in/cdn/shop/files/7E0F53D2-DE3E-4697-AE57-01756958F772_c23ce0d3-143d-4264-9339-d1e3775a116c.jpg?v=1720173779&width=1946",
    "https://posterwa.com/cdn/shop/files/TRAVISS5_5fb8f426-a60b-40a7-9033-b88ece7f7b8c.jpg?v=1714549590",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTTfEhkdF1gAVLGNw8cZdtgjIz0rUKLzhmGA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4lolvp9rV3WU8rhIXorwPcemOKC4Jy6SYzg&s",
    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpostersbase.com%2Fproducts%2Fposter-travis-scott-astroworld-astroboy&psig=AOvVaw10qovsdCY7gPcIaUdfl1-M&ust=1730037639712000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCKCik8uarIkDFQAAAAAdAAAAABAh",
    "https://render.fineartamerica.com/images/rendered/default/print/8/8/break/images/artworkimages/medium/3/2-travis-scott-astroworld-vibrant-by-asar-studios-celestial-images.jpg"
  ];

  int selectedIndex = 0;
  int? _sliding = 0;
  int? _quality1 = 1;
  int? _quality2 = 1;
  int? _quality3 = 0;
  int? _quality4 = 1;

  void _onIconTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 60),
          // Icon row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconButton(AppIcon.equalizer, 0),
                _buildIconButton(AppIcon.stack, 1),
                _buildCloseButton(),
              ],
            ),
          ),
          if (selectedIndex == 0) ...[
            // Equalizer Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildAlbumInfo(),
                    _buildSegmentedControl(),
                    _buildSegmentContent(),
                  ],
                ),
              ),
            )
          ] else if (selectedIndex == 1) ...[
            _buildAlbumVersion()
          ],
        ],
      ),
    );
  }

  Widget _buildAlbumVersion() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.album.imgURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Text(
                      widget.album.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                  Text(
                    "By ${widget.album.aritst}",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "${widget.album.genre.name[0].toUpperCase()}${widget.album.genre.name.substring(1)} · ${Helpers.formatDate(widget.album.releaseDate)}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.grey[500]),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset(
                        AppIcon.quality,
                        scale: 25,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        AppIcon.audio,
                        scale: 25,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        AppIcon.dolby,
                        scale: 25,
                        color: Colors.grey[500],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CupertinoSlidingSegmentedControl(
                children: {
                  0: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text('Standard',
                          style: TextStyle(
                              color: _quality1 == 0
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                  1: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text('Explicit',
                          style: TextStyle(
                              color: _quality1 == 1
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                },
                groupValue: _quality1,
                onValueChanged: (value) {
                  setState(() {
                    _quality1 = value;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CupertinoSlidingSegmentedControl(
                children: {
                  0: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 5),
                      child: Text('Digital Master',
                          style: TextStyle(
                              color: _quality2 == 0
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                  1: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text('Lossless',
                          style: TextStyle(
                              color: _quality2 == 1
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                  2: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text('Atmos',
                          style: TextStyle(
                              color: _quality2 == 2
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                },
                groupValue: _quality2,
                onValueChanged: (value) {
                  setState(() {
                    _quality2 = value;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CupertinoSlidingSegmentedControl(
                children: {
                  0: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 5),
                      child: Text('Original',
                          style: TextStyle(
                              color: _quality3 == 0
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                  1: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text('Deluxe',
                          style: TextStyle(
                              color: _quality3 == 1
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                  2: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 5),
                      child: Text('Aniversary',
                          style: TextStyle(
                              color: _quality3 == 2
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                },
                groupValue: _quality3,
                onValueChanged: (value) {
                  setState(() {
                    _quality3 = value;
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CupertinoSlidingSegmentedControl(
                children: {
                  0: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text('Standard',
                          style: TextStyle(
                              color: _quality4 == 0
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                  1: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Text('Explicit',
                          style: TextStyle(
                              color: _quality4 == 1
                                  ? AppColor.primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w600))),
                },
                groupValue: _quality4,
                onValueChanged: (value) {
                  setState(() {
                    _quality4 = value;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(String iconPath, int index) {
    return InkWell(
      onTap: () => _onIconTap(index),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? AppColor.primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: selectedIndex == index
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 3,
                  )
                ]
              : null,
        ),
        child: Image.asset(
          iconPath,
          scale: 20,
          color: selectedIndex == index ? Colors.white : AppColor.primaryColor,
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
              selectedIndex == 2 ? AppColor.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: selectedIndex == 2
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]
              : null,
        ),
        child: Image.asset(
          AppIcon.cross,
          scale: 20,
          color: selectedIndex == 2 ? Colors.white : AppColor.primaryColor,
        ),
      ),
    );
  }

  Widget _buildAlbumInfo() {
    return Row(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.album.imgURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                widget.album.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              widget.album.aritst.name!,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: CupertinoSlidingSegmentedControl(
        children: {
          0: _buildSegmentText('Details', 0),
          1: _buildSegmentText('Options', 1),
          2: _buildSegmentText('Artwork', 2),
        },
        groupValue: _sliding,
        onValueChanged: (value) {
          setState(() {
            _sliding = value;
          });
        },
      ),
    );
  }

  Widget _buildSegmentText(String title, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyle(
          color: _sliding == index ? AppColor.primaryColor : Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSegmentContent() {
    switch (_sliding) {
      case 0: // Details
        return _buildDetailsContent();
      case 1: // Options
        return _buildOptionsContent();
      case 2: // Artwork
        return _buildArtworkContent();
      default:
        return Container(); // Fallback
    }
  }

  Widget _buildDetailsContent() {
    return Column(
      children: [
        _buildDetailRow("Artist", widget.album.aritst.name!),
        _buildDetailRow("Album", widget.album.title),
        _buildDetailRow("Genre", widget.album.genre.name),
        _buildDetailRow("Year", widget.album.releaseDate),
        const SizedBox(height: 50),
        _buildDetailRow("Disc Number", "10000"),
        _buildRatingRow(),
        const SizedBox(height: 20),
        _buildTagsRow(),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(label),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              // overflow: TextOverflow.ellipsis,
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Text("Rating"),
          Spacer(),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
          Icon(Icons.star),
        ],
      ),
    );
  }

  Widget _buildTagsRow() {
    return Row(
      children: [
        const SizedBox(width: 80, child: Text("Tags")),
        InkWell(
          onTap: () {
            if (kDebugMode) {
              print("Add tag");
            }
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.add,
              color: AppColor.primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(
            spacing: 8.0, // Space between tags
            runSpacing: 4.0, // Space between lines
            children: [
              _buildTag("Hip Hop"),
              _buildTag("Travis"),
              _buildTag("Scott"),
              _buildTag("Urban"),
              _buildTag("2019"),
              _buildTag("Graduation"),
              _buildTag("Utopia"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[100],
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: AppColor.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOptionsContent() {
    // Replace with actual options content
    return const Center(child: Text('Options for the album.'));
  }

  Widget _buildArtworkContent() {
    // Replace with actual artwork content
    return SingleChildScrollView(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: tempArtwork.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                tempArtwork[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImage.defaultImage,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
