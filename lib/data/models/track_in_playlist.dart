class TrackInPlaylist {
  final String id;
  final int position;

  TrackInPlaylist({required this.id, required this.position});

  @override
  String toString() {
    return 'TrackInPlaylist{id: $id, position: $position}';
  }

  factory TrackInPlaylist.fromJson(Map<String, dynamic> json) {
    return TrackInPlaylist(
      id: json['track'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'position': position,
    };
  }
}
