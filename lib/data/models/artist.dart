class Artist {
  final String? id;
  final String? name;
  final String? avatarURL;

  Artist({
    this.id,
    this.name,
    this.avatarURL,
  });

  Artist.defaultArtist()
      : id = null,
        name = 'Unknown Artist',
        avatarURL = 'default_avatar_url';

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['_id'],
      name: json['name'],
      avatarURL: json['avatar_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'avatar_url': avatarURL,
    };
  }

  @override
  String toString() {
    return 'Artist{id: $id, name: $name, avatarURL: $avatarURL}';
  }
}
