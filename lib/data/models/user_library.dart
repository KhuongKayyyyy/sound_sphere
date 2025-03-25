import 'package:sound_sphere/data/models/track_in_library.dart';

class UserLibrary {
  String? id;
  List<TrackInLibrary>? tracks;

  UserLibrary({this.id, this.tracks});

  UserLibrary.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['savedTracks'] != null) {
      tracks = <TrackInLibrary>[];
      json['savedTracks'].forEach((v) {
        tracks!.add(TrackInLibrary.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['savedTracks'] = tracks?.map((v) => v.toJson()).toList();
    return data;
  }

  @override
  String toString() {
    return 'UserLibrary{id: $id, tracks: $tracks}';
  }
}
