import 'package:intl/intl.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/track.dart';

class Helpers {
  // static double calculateTextWidth(String text, TextStyle style) {
  //   final TextPainter textPainter = TextPainter(
  //     text: TextSpan(text: text, style: style),
  //     maxLines: 1,
  //     textDirection: TextDirection.LTR!,
  //   )..layout();
  //   return textPainter.size.width;
  // }

  static String getYearFromReleaseDate(String releaseDate) {
    try {
      DateTime parsedDate = DateTime.parse(releaseDate);
      return parsedDate.year.toString();
    } catch (e) {
      return 'Invalid date'; // Handle error if the date parsing fails
    }
  }

  static String formatDate(String releaseDate) {
    try {
      DateTime parsedDate = DateTime.parse(releaseDate);
      // Format the date as "dd MMM yyyy"
      return DateFormat('dd MMM yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid date'; // Handle error if the date parsing fails
    }
  }

  static String getUserNickName(String email) {
    try {
      return '@${email.split('@')[0]}';
    } catch (e) {
      return 'Invalid email'; // Handle error if the email parsing fails
    }
  }

  static List<Artist> getArtistsFromTracks(List<Track> tracks) {
    Set<Artist> artistSet = {};

    for (var track in tracks) {
      artistSet.add(track.artist);

      if (track.featuredArtists != null) {
        artistSet.addAll(track.featuredArtists!);
      }
    }

    return artistSet.toList();
  }
}
