import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_sphere/data/models/song.dart';

class PlayerController extends ChangeNotifier {
  static final PlayerController _instance = PlayerController._internal();
  final AudioPlayer audioPlayer = AudioPlayer();

  factory PlayerController() => _instance;
  PlayerController._internal();

  bool _isPlaying = false;
  List<Song> playlistSongs = [];
  late Song currentSong;
  late int currentSongIndex;

  bool get isPlaying => _isPlaying;

  void setPlayerAudio(List<Song> songs) {
    if (songs.isEmpty) return;

    playlistSongs = songs;
    currentSongIndex = 0;
    currentSong = playlistSongs[currentSongIndex];

    List<AudioSource> audioSources = playlistSongs
        .map((song) => AudioSource.uri(Uri.parse(song.urlMedia)))
        .toList();
    final concatenatingAudioSource =
        ConcatenatingAudioSource(children: audioSources);
    audioPlayer.setAudioSource(concatenatingAudioSource);

    initializeAudio();
  }

  void initializeAudio() async {
    audioPlayer.currentIndexStream.listen((index) {
      if (index != null && index != currentSongIndex) {
        currentSongIndex = index;
        currentSong = playlistSongs[currentSongIndex];
        notifyListeners();
      }
    });
  }

  void play() {
    audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  void pause() {
    audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void moveToNextSong() async {
    await audioPlayer.seekToNext();
    updateCurrentSong();
  }

  void moveToPreviousSong() async {
    await audioPlayer.seekToPrevious();
    updateCurrentSong();
  }

  void updateCurrentSong() {
    final newIndex = audioPlayer.currentIndex;
    if (newIndex != null && newIndex != currentSongIndex) {
      currentSongIndex = newIndex;
      currentSong = playlistSongs[currentSongIndex];
      notifyListeners();
    }
  }

  Song getCurrentSong() {
    return currentSong;
  }
}
