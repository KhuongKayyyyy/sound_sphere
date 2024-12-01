import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sound_sphere/core/constant/api_config.dart';
import 'package:sound_sphere/core/constant/app_color.dart';
import 'package:sound_sphere/presentation/blocs/aritst/artist_bloc.dart';
import 'package:sound_sphere/presentation/views/main/search/components/artist_we_love_item.dart';

class ArtistWeLovePage extends StatefulWidget {
  const ArtistWeLovePage({super.key});

  @override
  State<ArtistWeLovePage> createState() => _ArtistWeLovePageState();
}

class _ArtistWeLovePageState extends State<ArtistWeLovePage> {
  late final ArtistBloc artistBloc;
  @override
  void initState() {
    artistBloc = ArtistBloc();
    artistBloc.add(
        FetchArtistsEvent(1, ApiConfig.DEFAULT_LIMIT, ArtistApi.nameAndAvatar));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistBloc, ArtistState>(
      bloc: artistBloc,
      builder: (context, artistState) {
        if (artistState is ArtistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (artistState is ArtistError) {
          return Center(
            child: Text(artistState.message),
          );
        } else if (artistState is ArtistLoaded) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primaryColor,
                  )),
              title: const Text(
                "Artists We Love",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: ListView.builder(
              itemCount: artistState.artists.length,
              itemBuilder: (context, index) => ArtistWeLoveItem(
                artist: artistState.artists.elementAt(index),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColor.primaryColor,
                )),
            title: const Text(
              "Artists We Love",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Text("Fail to load artist"),
        );
      },
    );
  }
}
