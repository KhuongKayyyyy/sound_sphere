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
  bool isPlayingAlbum = true;
  bool isPlayingInfinity = false;

  bool get isPlaying => _isPlaying;
  // set showHistory(bool value) => _showHistory = value;

  List<Song> playlistSongs = [];
  List<Song> historySongs = [];
  List<Song> infiniteSongs = FakeData.obitoSongs;
  late Song currentSong;
  final ValueNotifier<Song> currentSongNotifier =
      ValueNotifier<Song>(FakeData.obitoSongs.first);
  final ValueNotifier<List<Song>> infiniteSongsNotifier =
      ValueNotifier<List<Song>>(FakeData.obitoSongs);

  // ValueNotifier<int> currentSongIndexNotifier = ValueNotifier<int>(0);

  // void setCurrentSongIndex(int index) {
  //   currentSongIndexNotifier.value = index;
  // }

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
    // Check if we reached the end of the current playlist
    if (currentSongIndex >= playlistSongs.length - 1) {
      // If infinity mode is on, play the song from the infinite playlist
      if (isInfinity) {
        playNextFromInfinitePlaylist();
      } else if (isRepeat) {
        // If repeat mode is enabled, start the playlist from the beginning
        // await jumpToSong(0);
      } else {
        // Stop playback if no mode is active
        await audioPlayer.pause();
        _isPlaying = false;
        isPlayingNotifier.value = false;
      }
    } else {
      // Move to the next song in the current playlist
      await audioPlayer.seekToNext();
      updateCurrentSong();
    }
  }

  /// Play the next song from the infinite playlist
  void playNextFromInfinitePlaylist() async {
    if (infiniteSongs.isEmpty) return;

    // Append the entire infinite playlist to the current playlist
    playlistSongs.addAll(infiniteSongs);

    // Create a new audio source list with both current and infinite playlist songs
    List<AudioSource> audioSources = playlistSongs
        .map((song) => AudioSource.uri(Uri.parse(song.urlMedia)))
        .toList();

    // Set the new concatenating audio source
    await audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: audioSources,
        useLazyPreparation: true,
      ),
      initialIndex: currentSongIndex + 1, // Start from the next song
      initialPosition: Duration.zero,
    );

    // Move to the next song (first song from the infinite playlist)
    await audioPlayer.seek(Duration.zero, index: currentSongIndex + 1);
    updateCurrentSong();
    isPlayingInfinity = true;
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

  // Method to update infiniteSongs
  void updateInfiniteSongs(List<Song> newSongs) {
    infiniteSongsNotifier.value = newSongs;
    notifyListeners(); // Notify listeners about the change
  }

  // You can also provide methods to manipulate the infiniteSongs
  void addSongToInfinite(Song song) {
    infiniteSongs.add(song);
    updateInfiniteSongs(infiniteSongs);
  }

  void removeSongFromInfinite(Song song) {
    infiniteSongs.remove(song);
    updateInfiniteSongs(infiniteSongs);
  }

  void removeSong(Song song) async {
    // Remove the song from the playlist
    playlistSongs.remove(song);

    // If the song is in the infinite list, remove it as well
    if (infiniteSongs.contains(song)) {
      infiniteSongs.remove(song);
    }

    // Rebuild the audio sources list
    List<AudioSource> audioSources = playlistSongs
        .map((song) => AudioSource.uri(Uri.parse(song.urlMedia)))
        .toList();

    // Set the new concatenating audio source
    await audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: audioSources,
        useLazyPreparation: true,
      ),
      initialIndex: currentSongIndex, // Retain the current song index
      initialPosition: _currentPosition, // Retain the current position
    );

    // Notify listeners after removal
    notifyListeners();
  }

  /// Method to update the playlist order after a reorder operation
  // Future<void> updatePlaylistOrder(int oldIndex, int newIndex) async {
  //   if (oldIndex < newIndex) {
  //     newIndex -= 1;
  //   }
  //   // Move the song in the playlist
  //   final Song song = playlistSongs.removeAt(oldIndex);
  //   playlistSongs.insert(newIndex, song);

  //   // Rebuild the audio sources list with the updated playlist order
  //   List<AudioSource> audioSources = playlistSongs
  //       .map((song) => AudioSource.uri(Uri.parse(song.urlMedia)))
  //       .toList();

  //   // Set the new concatenating audio source
  //   await audioPlayer.setAudioSource(
  //     ConcatenatingAudioSource(
  //       children: audioSources,
  //       useLazyPreparation: true,
  //     ),
  //     initialIndex: newIndex, // Set the new song index after reordering
  //     initialPosition: Duration.zero, // Start from the beginning of the song
  //   );

  //   // Notify listeners to update UI or state
  //   notifyListeners();
  // }
}
