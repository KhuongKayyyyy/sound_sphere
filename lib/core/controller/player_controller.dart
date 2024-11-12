import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/song.dart';

class PlayerController extends ChangeNotifier {
  static final PlayerController _instance = PlayerController._internal();
  final AudioPlayer audioPlayer = AudioPlayer();
  factory PlayerController() => _instance;
  PlayerController._internal();

  bool _isFavorite = false;
  bool _isPlaying = false;
  bool _isShuffle = false;
  bool _isRepeat = false;
  final bool _isLoop = false;
  bool _isInfinity = false;

  bool get isPlaying => _isPlaying;

  // fake data for songs
  static final List<Song> playlistSongs = List.from(FakeData.songs.take(10));
  late Song currentSong;
  late int currentSongIndex;

  void moveToNextSong() async {
    try {
      await audioPlayer.seekToNext();
      audioPlayer.play();
    } catch (e) {
      print("Error moving to the next song: $e");
    }
  }

// To move to the previous song in the playlist
  void moveToPreviousSong() async {
    try {
      await audioPlayer.seekToPrevious();
    } catch (e) {
      print("Error moving to the previous song: $e");
    }
  }

  void updateCurrentSong() {
    final newIndex = audioPlayer.currentIndex;
    if (newIndex != null && newIndex != currentSongIndex) {
      currentSongIndex = newIndex;
      currentSong = playlistSongs[currentSongIndex];
    }
  }

  void initializeAudio() async {
    try {
      // Set the audio URL or audio source initialization
      audioPlayer.positionStream.listen((position) {});

      // Listen to the duration of the audio file
      audioPlayer.durationStream.listen((duration) {});

      // Listen to playback state changes
      audioPlayer.playerStateStream.listen((state) {});

      // Listen to current index changes
      audioPlayer.currentIndexStream.listen((index) {
        if (index != null && index != currentSongIndex) {
          currentSongIndex = index;
          currentSong = playlistSongs[currentSongIndex];
          notifyListeners(); // Notify listeners to update the UI
        }
      });
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void setPlayerAudio() {
    currentSongIndex = 0;
    currentSong = playlistSongs.elementAt(currentSongIndex);
    List<AudioSource> audioSources = playlistSongs
        .map((song) =>
            AudioSource.uri(Uri.parse(song.urlMedia))) // Use the urlMedia field
        .toList();
    final concatenatingAudioSource =
        ConcatenatingAudioSource(children: audioSources);
    audioPlayer.setAudioSource(concatenatingAudioSource);
    initializeAudio();
  }

  Song getSong(int index) {
    return playlistSongs.elementAt(index);
  }
}
