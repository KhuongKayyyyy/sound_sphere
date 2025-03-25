class TrackInLibrary {
  String? id;
  bool? isFavorite;

  TrackInLibrary({this.id, this.isFavorite});

  TrackInLibrary.fromJson(Map<String, dynamic> json) {
    id = json['trackId']; // Fix: Using "trackId" from API
    isFavorite = json['isFavourite']; // Fix: Using "isFavourite" from API
  }

  Map<String, dynamic> toJson() {
    return {
      'trackId': id, // Keep "trackId" as per API response
      'isFavourite': isFavorite, // Keep "isFavourite" as per API response
    };
  }

  @override
  String toString() {
    return 'TrackInLibrary{id: $id, isFavorite: $isFavorite}';
  }
}
