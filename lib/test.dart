import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchLyrics(String songName, String artistName) async {
  final url = Uri.parse(
      'https://paxsenixofc.my.id/server/getLyricsMusix.php?q=$songName $artistName&type=default');

  try {
    // Gửi yêu cầu GET đến API
    final response = await http.get(url);

    // Kiểm tra nếu mã trạng thái là 200 (thành công)
    if (response.statusCode == 200) {
      // In nội dung trả về từ API
      print('Response body: ${response.body}');

      // Nếu dữ liệu là JSON, có thể cần chuyển đổi
      // final data = jsonDecode(response.body);

      // Xử lý lời bài hát, ví dụ tách thành từng dòng
      List<String> lyricsLines = response.body.split('\n');
      for (var line in lyricsLines) {
        print(line); // In từng dòng lời bài hát
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    print('Error fetching lyrics: $error');
  }
}

void main() {
  fetchLyrics('Hello', 'Adele');
}
