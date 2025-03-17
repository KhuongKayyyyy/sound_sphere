import 'package:intl/intl.dart';

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
}
