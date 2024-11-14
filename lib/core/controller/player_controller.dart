import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/song.dart';

class PlayerController extends ChangeNotifier {
  static final PlayerController _instance = PlayerController._internal();
  final AudioPlayer audioPlayer = AudioPlayer();

  factory PlayerController() => _instance;
  PlayerController._internal();

  bool _isPlaying = false;
  List<Song> playlistSongs = [];
  late Song currentSong;
  final ValueNotifier<Song> currentSongNotifier =
      ValueNotifier<Song>(FakeData.obitoSongs.first); // Add this notifier

  late int currentSongIndex;

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  bool get isPlaying => _isPlaying;
  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier(false);

  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  Duration get remainingDuration => _totalDuration - _currentPosition;

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

    // Listen to position changes
    audioPlayer.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    // Listen to duration changes
    audioPlayer.durationStream.listen((duration) {
      _totalDuration = duration ?? Duration.zero;
      notifyListeners();
    });

    // Listen to playback state changes
    audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();

      if (state.processingState == ProcessingState.completed) {
        moveToNextSong();
      }
    });
  }

  void play() {
    audioPlayer.play();
    _isPlaying = true;
    isPlayingNotifier.value = true;

    notifyListeners();
  }

  void pause() {
    audioPlayer.pause();
    _isPlaying = false;
    isPlayingNotifier.value = false;
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

  void jumpToSong(int songIndex) async {
    if (songIndex < 0 || songIndex >= playlistSongs.length) {
      // Index out of bounds
      return;
    }

    await audioPlayer.seek(Duration.zero, index: songIndex);
    updateCurrentSong();
  }

  void updateCurrentSong() {
    final newIndex = audioPlayer.currentIndex;
    if (newIndex != null && newIndex != currentSongIndex) {
      currentSongIndex = newIndex;
      currentSong = playlistSongs[currentSongIndex];
      currentSongNotifier.value = currentSong;
      notifyListeners();
    }
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  Song getCurrentSong() {
    return currentSong;
  }

  List<Song> getPlaylistSongs() {
    return playlistSongs;
  }

  Duration getCurrentPosition() {
    return _currentPosition;
  }

  Duration getTotalDuration() {
    return _totalDuration;
  }

  /// Get the formatted string of the current position like "2:15"
  String getCurrentPositionString() {
    return _formatDuration(_currentPosition);
  }

  /// Get the formatted string of the total duration like "3:45"
  String getTotalDurationString() {
    return _formatDuration(_totalDuration);
  }

  /// Get the formatted string of the remaining duration like "1:30"
  String getRemainingDurationString() {
    return _formatDuration(remainingDuration);
  }

  /// Helper function to format Duration as "mm:ss"
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
