import 'package:flutter/material.dart';

class SharedWithYouPage extends StatefulWidget {
  const SharedWithYouPage({super.key});

  @override
  State<SharedWithYouPage> createState() => _SharedWithYouPageState();
}

class _SharedWithYouPageState extends State<SharedWithYouPage> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        // child: TextButton(
        //     onPressed: () => ArtistRepository.fetchArtists(),
        //     child: const Text('Shared With You')),
        );
  }
}
