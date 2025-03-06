import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sound_sphere/core/constant/app_image.dart';

class ShareLyricModal extends StatefulWidget {
  final String lyrics;
  final String imageUrl;

  const ShareLyricModal({
    super.key,
    required this.lyrics,
    required this.imageUrl,
  });

  @override
  State<ShareLyricModal> createState() => _ShareLyricModalState();
}

class _ShareLyricModalState extends State<ShareLyricModal> {
  final Set<int> _selectedIndices = {};
  int _selectedCharacterCount = 0;

  void _onLineTap(int index, String line) {
    int lineLength = line.length;

    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
        _selectedCharacterCount -= lineLength;
      } else if (_selectedCharacterCount + lineLength <= 150) {
        _selectedIndices.add(index);
        _selectedCharacterCount += lineLength;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final lines = widget.lyrics
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height * 0.93,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSelectionInfo(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  lines.length,
                  (index) => _buildLyricLine(index, lines[index]),
                ),
              ),
            ),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  Row _buildSelectionInfo() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.imageUrl,
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _selectedIndices.isNotEmpty
                  ? "${_selectedIndices.length} Lines Selected"
                  : "Tap to select a line to share",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Text(
              _selectedIndices.isNotEmpty
                  ? "$_selectedCharacterCount / 150 Characters Selected"
                  : "Tap to select a line to share",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            padding: const EdgeInsets.all(5),
            child: const Icon(CupertinoIcons.xmark),
          ),
        )
      ],
    );
  }

  Widget _buildLyricLine(int index, String lyricLine) {
    bool isSelected = _selectedIndices.contains(index);

    return GestureDetector(
      onTap: () => _onLineTap(index, lyricLine),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.transparent : Colors.white,
          boxShadow: [
            if (!isSelected)
              BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Stack(
          children: [
            if (isSelected)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.cover,
                        color: Colors.black.withOpacity(0.5),
                        colorBlendMode: BlendMode.darken,
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                lyricLine,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2,
            color: Colors.grey[300]!,
          ),
        ),
      ),
      child: Column(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _selectedIndices.isNotEmpty
                ? _buildShareOption()
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Text(
                    "Share Song...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(CupertinoIcons.share),
                  onTap: () {
                    if (_selectedCharacterCount > 0) {
                      _shareLyrics();
                    }
                  },
                ),
                ListTile(
                  leading: const Text(
                    "Report a Concern...",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(CupertinoIcons.exclamationmark_bubble),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _shareLyrics() {
    final lines = widget.lyrics
        .split('\n')
        .where((line) => line.trim().isNotEmpty)
        .toList();
    _selectedIndices.map((index) => lines[index]).join('\n');
    // Implement sharing logic here.
  }

  Widget _buildShareOption() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildOptionIcon("Airdrop", AppImage.airdrop),
          _buildOptionIcon("Facebook", AppImage.facebook_share),
          _buildOptionIcon("Instagram", AppImage.instagram),
          _buildOptionIcon("Message", AppImage.message),
        ],
      ),
    );
  }

  Column _buildOptionIcon(String title, String icon) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            icon,
            height: 80,
            width: 80,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
