import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sound_sphere/core/utils/fake_data.dart';
import 'package:sound_sphere/data/models/lyrics.dart';
import 'package:sound_sphere/data/models/track.dart';

class PlayerController extends ChangeNotifier {
  static final PlayerController _instance = PlayerController._internal();
  final AudioPlayer audioPlayer = AudioPlayer();
  ConcatenatingAudioSource? concatenatingAudioSource;

  factory PlayerController() => _instance;
  PlayerController._internal();

  StreamSubscription? lyricSyncSubscription;

  /// Sync lyrics and scroll to the appropriate position
  void syncLyrics({
    required List<Lyric> lyrics,
    required ItemScrollController itemScrollController,
  }) {
    // Hủy đăng ký trước đó nếu có
    lyricSyncSubscription?.cancel();

    // Lắng nghe luồng vị trí từ trình phát nhạc
    lyricSyncSubscription = audioPlayer.positionStream.listen((duration) {
      DateTime dt = DateTime(1970, 1, 1).copyWith(
        hour: duration.inHours,
        minute: duration.inMinutes.remainder(60),
        second: duration.inSeconds.remainder(60),
      );

      for (int index = 0; index < lyrics.length; index++) {
        // Tìm dòng lời bài hát hiện tại dựa trên thời gian
        if (lyrics[index].timeStamp.isAfter(dt)) {
          // Cuộn để đảm bảo mục này ở đầu danh sách
          itemScrollController.scrollTo(
            index: index, // Không cần trừ đi bất kỳ giá trị nào
            duration: const Duration(milliseconds: 1500),
            alignment: 0.0, // Giữ mục ở đầu danh sách
          );
          break;
        }
      }
    });
  }

  /// Cancel lyric syncing
  void cancelLyricSync() {
    lyricSyncSubscription?.cancel();
    lyricSyncSubscription = null;
  }

  @override
  void dispose() {
    // Ensure to cancel the subscription when disposing
    lyricSyncSubscription?.cancel();
    super.dispose();
  }

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

  List<Track> playlistSongs = [];
  List<Track> historySongs = [];
  List<Track> infiniteSongs = FakeData.obitoSongs;
  late Track currentSong;
  final ValueNotifier<Track> currentSongNotifier =
      ValueNotifier<Track>(FakeData.obitoSongs.first);
  final ValueNotifier<List<Track>> infiniteSongsNotifier =
      ValueNotifier<List<Track>>(FakeData.obitoSongs);

  // ValueNotifier<int> currentSongIndexNotifier = ValueNotifier<int>(0);

  // void setCurrentSongIndex(int index) {
  //   currentSongIndexNotifier.value = index;
  // }

  late int currentSongIndex;

  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  final ValueNotifier<bool> isPlayingNotifier = ValueNotifier(false);

  void setPlayerAudio(List<Track> songs) {
    if (songs.isEmpty) return;

    playlistSongs = songs;
    currentSongIndex = 0;
    currentSong = playlistSongs[currentSongIndex];

    List<AudioSource> audioSources = playlistSongs
        .map((song) => AudioSource.uri(Uri.parse(song.urlMedia)))
        .toList();

    concatenatingAudioSource = ConcatenatingAudioSource(
      children: audioSources,
      useLazyPreparation: true,
    );
    audioPlayer.setAudioSource(concatenatingAudioSource!);

    initializeAudio();
  }

  Future<void> updateAudioSource() async {
    List<AudioSource> audioSources = playlistSongs
        .map((song) => AudioSource.uri(Uri.parse(song.urlMedia)))
        .toList();

    concatenatingAudioSource = ConcatenatingAudioSource(
      children: audioSources,
      useLazyPreparation: true,
    );

    await audioPlayer.setAudioSource(
      concatenatingAudioSource!,
      initialIndex: currentSongIndex,
      initialPosition: Duration.zero,
    );
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
        jumpToSong(0);
      } else {
        // Stop playback if no mode is active
        await audioPlayer.pause();
        _isPlaying = false;
        isPlayingNotifier.value = false;
      }
    } else {
      // Move to the next song in the current playlist
      await audioPlayer.seekToNext();
      await updateAudioSource(); // Add this line
      updateCurrentSong();
    }
  }

  void moveToPreviousSong() async {
    await audioPlayer.seekToPrevious();
    await updateAudioSource(); // Add this line
    updateCurrentSong();
  }

  void jumpToSong(int songIndex) async {
    if (songIndex < 0 || songIndex >= playlistSongs.length) {
      return;
    }

    await audioPlayer.seek(Duration.zero, index: songIndex);
    await updateAudioSource();
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

  void removeSong(Track song) async {
    final index = playlistSongs.indexOf(song);
    if (index == -1) return; // Song not found

    // Remove the song from the playlist
    playlistSongs.removeAt(index);

    // If the song is in the infinite list, remove it as well
    if (infiniteSongs.contains(song)) {
      infiniteSongs.remove(song);
    }

    // Remove the audio source directly without resetting the player
    await concatenatingAudioSource?.removeAt(index);

    // If the current song is removed, move to the next song
    if (currentSongIndex == index) {
      if (currentSongIndex >= playlistSongs.length) {
        currentSongIndex = 0;
      }
      updateCurrentSong();
    }

    notifyListeners();
  }

  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }

  Track getCurrentSong() {
    return currentSong;
  }

  List<Track> getPlaylistSongs() {
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

  /// Shuffle the playlist
  Future<void> shufflePlaylist() async {
    await audioPlayer.setShuffleModeEnabled(isShuffle);

    if (isShuffle) {
      await audioPlayer.shuffle();
    }

    notifyListeners();
  }

  List<Track> getShuffledPlaylistSongs() {
    final shuffledList = List<Track>.from(playlistSongs);
    shuffledList.shuffle();
    return shuffledList;
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

  // Method to update infiniteSongs
  void updateInfiniteSongs(List<Track> newSongs) {
    infiniteSongsNotifier.value = newSongs;
    notifyListeners(); // Notify listeners about the change
  }

  // You can also provide methods to manipulate the infiniteSongs
  void addSongToInfinite(Track song) {
    infiniteSongs.add(song);
    updateInfiniteSongs(infiniteSongs);
  }

  void removeSongFromInfinite(Track song) {
    infiniteSongs.remove(song);
    updateInfiniteSongs(infiniteSongs);
  }

  /// Method to update the playlist order after a reorder operation
  Future<void> updatePlaylistOrder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    // Move the song in the playlist
    final Track song = playlistSongs.removeAt(oldIndex);
    playlistSongs.insert(newIndex, song);

    // Update the ConcatenatingAudioSource order
    await concatenatingAudioSource?.move(oldIndex, newIndex);

    // Notify listeners to update UI
    notifyListeners();
  }
}
