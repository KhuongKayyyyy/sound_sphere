import 'package:sound_sphere/data/models/track_in_playlist.dart';

class Playlist {
  final String? id;
  final String? name;
  bool? isPublic;
  final String? imgURL;
  List<TrackInPlaylist>? tracks;
  int? totalPlay;
  int? totalSave;
  int? totalDuration;
  DateTime? createdAt;
  DateTime? updatedAt;

  Playlist(
      {this.imgURL,
      this.id,
      this.name,
      this.tracks,
      this.isPublic,
      this.totalPlay,
      this.totalSave,
      this.totalDuration,
      this.createdAt,
      this.updatedAt});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['_id'] as String?,
      name: json['title'] as String?,
      isPublic: json['isPublic'] as bool?,
      imgURL: json['imgURL'] as String?,
      tracks: (json['tracks'] as List<dynamic>?)
          ?.map((e) => TrackInPlaylist.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPlay: json['total_play'] as int?,
      totalSave: json['total_save'] as int?,
      totalDuration: json['total_duration_ms'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isPublic': isPublic,
      'imgURL': imgURL,
      'tracks': tracks?.map((e) => e.toJson()).toList(),
      'totalPlay': totalPlay,
      'totalSave': totalSave,
      'totalDuration': totalDuration,
    };
  }

  @override
  String toString() {
    return 'Playlist{id: $id, name: $name, isPublic: $isPublic, imgURL: $imgURL, tracks: $tracks, totalPlay: $totalPlay, totalSave: $totalSave, totalDuration: $totalDuration}';
  }

  factory Playlist.empty() {
    return Playlist(
      id: "1",
      name: "Empty",
      isPublic: false,
      imgURL:
          "https://www.shutterstock.com/image-vector/fill-image-preview-icon-simple-260nw-2338969281.jpg",
      tracks: [],
      totalPlay: 0,
      totalSave: 0,
      totalDuration: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Playlist copyWith({
    String? id,
    String? name,
    bool? isPublic,
    String? imgURL,
    List<TrackInPlaylist>? tracks,
    int? totalPlay,
    int? totalSave,
    int? totalDuration,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      isPublic: isPublic ?? this.isPublic,
      imgURL: imgURL ?? this.imgURL,
      tracks: tracks ?? this.tracks,
      totalPlay: totalPlay ?? this.totalPlay,
      totalSave: totalSave ?? this.totalSave,
      totalDuration: totalDuration ?? this.totalDuration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
