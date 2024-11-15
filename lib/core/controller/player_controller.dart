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
  bool isShuffle = false; // Add shuffle state
  bool isRepeat = false;
  bool isLoop = false;
  bool isInfinity = false;
  // bool _showHistory = false;

  bool get isPlaying => _isPlaying;
  // set showHistory(bool value) => _showHistory = value;

  List<Song> playlistSongs = [];
  late Song currentSong;
  final ValueNotifier<Song> currentSongNotifier =
      ValueNotifier<Song>(FakeData.obitoSongs.first);

  late int currentSongIndex;

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier(false);

  void setPlayerAudio(List<Song> songs) {
    if (songs.isEmpty) return;

    playlistSongs = songs;
    currentSongIndex = 0;
    currentSong = playlistSongs[currentSongIndex];

    List<AudioSource> audioSources = playlistSongs
        .map((song) => AudioSource.uri(Uri.parse(song.urlMedia)))
        .toList();

    final concatenatingAudioSource = ConcatenatingAudioSource(
        children: audioSources, useLazyPreparation: true);
    audioPlayer.setAudioSource(concatenatingAudioSource);

    initializeAudio();
  }

  /// Shuffle the playlist
  Future<void> shufflePlaylist() async {
    // _isShuffle = !_isShuffle;
    isShuffle = !isShuffle;
    await audioPlayer.setShuffleModeEnabled(isShuffle);

    if (isShuffle) {
      await audioPlayer.shuffle();
    }

    notifyListeners();
  }

  List<Song> getShuffledPlaylistSongs() {
    final shuffledList = List<Song>.from(playlistSongs);
    shuffledList.shuffle();
    return shuffledList;
  }

  void initializeAudio() async {
    audioPlayer.currentIndexStream.listen((index) {
      if (index != null && index != currentSongIndex) {
        currentSongIndex = index;
        currentSong = playlistSongs[currentSongIndex];
        notifyListeners();
      }
    });

    audioPlayer.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    audioPlayer.durationStream.listen((duration) {
      _totalDuration = duration ?? Duration.zero;
      notifyListeners();
    });

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

  String getCurrentPositionString() {
    return _formatDuration(_currentPosition);
  }

  String getTotalDurationString() {
    return _formatDuration(_totalDuration);
  }

  String getRemainingDurationString() {
    return _formatDuration(_totalDuration - _currentPosition);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
