import 'package:sound_sphere/data/models/app_user.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/genres.dart';
import 'package:sound_sphere/data/models/lyrics.dart';
import 'package:sound_sphere/data/models/radio.dart';
import 'package:sound_sphere/data/models/search_category.dart';
import 'package:sound_sphere/data/models/track.dart';
import 'package:sound_sphere/data/models/album.dart';

class FakeData {
  static AppUser user = AppUser(
    name: "Nguyen Dat Khuong",
    password: "1123",
    email: "zzkhngzz@gmail.com",
    avatarURL:
        "https://yt3.googleusercontent.com/oN0p3-PD3HUzn2KbMm4fVhvRrKtJhodGlwocI184BBSpybcQIphSeh3Z0i7WBgTq7e12yKxb=s900-c-k-c0x00ffffff-no-rj",
  );
  List<Track> parseSongs(List<dynamic> jsonList) {
    return jsonList.map((json) => Track.fromJson(json)).toList();
  }

  static String soyLyricString = '''
[00:09.66]The club isn't the best place to find a lover
[00:12.16]So the bar is where I go
[00:14.91]Me and my friends at the table doing shots
[00:17.17]Drinking faster and then we talk slow
[00:19.92]Come over and start up a conversation with just me
[00:22.41]And trust me I'll give it a chance now
[00:24.92]Take my hand, stop
[00:26.16]Put Van The Man on the jukebox
[00:27.16]And then we start to dance
[00:28.41]And now I'm singing like
[00:29.91]Girl, you know I want your love
[00:32.16]Your love was handmade for somebody like me
[00:35.41]Come on now, follow my lead
[00:37.17]I may be crazy, don't mind me
[00:39.66]Say, boy, let's not talk too much
[00:42.41]Grab on my waist and put that body on me
[00:45.41]Come on now, follow my lead
[00:47.16]Come, come on now, follow my lead
[00:50.91]I'm in love with the shape of you
[00:53.41]We push and pull like a magnet do
[00:55.66]Although my heart is falling too
[00:58.16]I'm in love with your body
[01:00.67]And last night you were in my room
[01:03.16]And now my bedsheets smell like you
[01:05.41]Every day discovering something brand new
[01:08.17]I'm in love with your body
[01:09.91]Oh I oh I oh I oh I
[01:13.41]I'm in love with your body
[01:14.91]Oh I oh I oh I oh I
[01:18.42]I'm in love with your body
[01:19.91]Oh I oh I oh I oh I
[01:23.17]I'm in love with your body
[01:25.42]Every day discovering something brand new
[01:28.16]I'm in love with the shape of you
[01:29.91]One week in we let the story begin
[01:31.91]We're going out on our first date
[01:34.92]You and me are thrifty
[01:36.05]So go all you can eat
[01:37.05]Fill up your bag and I fill up a plate
[01:39.77]We talk for hours and hours about the sweet and the sour
[01:42.27]And how your family is doing okay
[01:44.77]Leave and get in a taxi, then kiss in the backseat
[01:47.52]Tell the driver make the radio play
[01:49.27]And I'm singing like
[01:50.17]Girl, you know I want your love
[01:52.18]Your love was handmade for somebody like me
[01:55.42]Come on now, follow my lead
[01:57.17]I may be crazy, don't mind me
[01:59.92]Say, boy, let's not talk too much
[02:02.17]Grab on my waist and put that body on me
[02:05.17]Come on now, follow my lead
[02:06.92]Come, come on now, follow my lead
[02:10.67]I'm in love with the shape of you
[02:13.42]We push and pull like a magnet do
[02:15.67]Although my heart is falling too
[02:18.17]I'm in love with your body
[02:20.67]And last night you were in my room
[02:23.42]And now my bedsheets smell like you
[02:25.17]Every day discovering something brand new
[02:28.17]I'm in love with your body
[02:29.92]Oh I oh I oh I oh I
[02:33.42]I'm in love with your body
[02:34.93]Oh I oh I oh I oh I
[02:38.18]I'm in love with your body
[02:39.92]Oh I oh I oh I oh I
[02:43.42]I'm in love with your body
[02:44.92]Every day discovering something brand new
[02:48.17]I'm in love with the shape of you
[02:49.93]Come on, be my baby, come on
[02:52.68]Come on, be my baby, come on
[02:54.92]Come on, be my baby, come on
[02:57.43]Come on, be my baby, come on
[03:00.18]Come on, be my baby, come on
[03:02.42]Come on, be my baby, come on
[03:05.17]Come on, be my baby, come on
[03:07.42]Come on, be my baby, come on
[03:10.67]I'm in love with the shape of you
[03:13.43]We push and pull like a magnet do
[03:15.68]Although my heart is falling too
[03:18.42]I'm in love with your body
[03:20.67]Last night you were in my room
[03:23.17]And now my bedsheets smell like you
[03:25.42]Every day discovering something brand new
[03:28.17]I'm in love with your body
[03:29.75]Come on, be my baby, come on
[03:32.67]Come on, be my baby, come on
[03:33.74]I'm in love with your body
[03:35.00]Come on, be my baby, come on
[03:37.50]Come on, be my baby, come on
[03:38.75]I'm in love with your body
[03:39.99]Come on, be my baby, come on
[03:42.50]Come on, be my baby, come on
[03:43.74]I'm in love with your body
[03:45.49]Every day discovering something brand new
[03:48.24]I'm in love with the shape of you ''';

  // Regex to match timestamps and lyrics
  static RegExp regExp =
      RegExp(r'\[(\d+):(\d+\.\d+)\](.*?)((?=\[\d+:\d+\.\d+\])|$)');

  // Create a list to store the lyrics
  List<Lyric> lyrics = [];

  // Find all matches
  // Iterable<RegExpMatch> matches = regExp.allMatches(soyLyricString);

  // void parseLyrics(String soyLyricString) {
  //   for (var match in matches) {
  //     String minutes = match.group(1) ?? '0';
  //     String seconds = match.group(2) ?? '0';
  //     String lyricText = match.group(3)?.trim() ?? '';

  //     // Convert time to Duration
  //     Duration timeStamp = Duration(
  //       minutes: int.parse(minutes),
  //       milliseconds: (double.parse(seconds) * 1000).round(),
  //     );

  //     // Add to list of lyrics
  //     lyrics.add(Lyric(lyricText, timeStamp));
  //   }

  //   // Print lyrics
  //   for (var lyric in lyrics) {
  //     print(lyric);
  //   }
  // }

  static List<SearchCategory> searchCategory = [
    SearchCategory(
        name: "SoundSphere Music Live",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4M1UzKpmdpmBuA9GT1f-vTmdwm64u4RNtGA&s"),
    SearchCategory(
        name: "Vietnamese Music",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrH7labPAP-FcsZQFXpdeXF_BRrYluKuKd4w&s"),
    SearchCategory(
        name: "K-Pop",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeeCMPJmpq8ufdWx96rNfsfqMxrnRX0GHZ1A&s"),
    SearchCategory(
        name: "Pop",
        imageUrl:
            "https://variety.com/wp-content/uploads/2020/01/taylor-swift-variety-cover-5-16x9-1000.jpg?w=1000&h=563&crop=1"),
    SearchCategory(
        name: "Charts",
        imageUrl:
            "https://media.gq.com/photos/56bb8a91b89407780bd7d454/16:9/w_2560%2Cc_limit/bieber-16-9-longform.jpg"),
    SearchCategory(
        name: "Hits",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Spatial Audio",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Live Music",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "DJ Mixes",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Essential",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Classical",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Acoustic",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Sleep",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Chill",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Feeling Blue",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Focus",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Romance",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Party",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Wellbeing",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Fitness",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "2010s",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "'90s",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "'80s",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Hip-Hop/Rap",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Rock",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Dance",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Electronic",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Country",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
    SearchCategory(
        name: "Jazz",
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod/images/michael-jackson-performs-in-concert-circa-1986-news-photo-1690832280.jpg?crop=0.92281xw:1xh;center,top&resize=1200:*"),
  ];

  List<Map<String, dynamic>> theWrxdiesSongJson = [
    {
      "title": "Ca Khúc Cuối",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Ca Khúc Cuối do ca sĩ Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/CaKhucCuoi-Wxrdie-16696442.mp3?st=Ax2On0CKvPXqg_OfbhlM2w&e=1732107706&a=1&p=0&r=3335999d3edc5e6adb775316278a211d"
    },
    {
      "title": "Thèn Chóa",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["KayC", "Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Thèn Chóa do ca sĩ KayC, Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/ThenChoa-WxrdieKayC-16696443.mp3?st=E86EfD_yNoT3L8CpeCXqxA&e=1732105895&a=1&p=0&r=4344ee700fa8e1a8a075deb46ca531f6"
    },
    {
      "title": "Băng Qua Cầu Giấy",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/11/d/0/d/4/1731340774750_500.jpg",
      "artist": ["Wxrdie", "RPT JasonDilla"],
      "lyric":
          "Ver Wxrdie:\nBăng qua Cầu Giấy, anh chẳng nhận ra lối về \nHomie rủ anh pull up qua chill làm vài khói đê \nCó thể chỉ vì muốn em vui nên trông anh hơi giống hề \nNhưng riêng câu \"yêu em\", anh sẽ nói khi không phê \nĐi xe trên quốc lộ, lao thật nhanh không đoái hoài \nVít ga tốc độ, anh chẳng muốn phải ngoái lại \nTừng câu em vừa nói khiến con tim này tái dại \nEm nói rất dài, nhưng chốt lại bằng câu \"bye bye\" \nAnh không cần nghe thêm, anh không cần phải quan tâm \nAnh có thể đợi em, luôn từ nay luôn sang năm \nỐm đau một chút thôi, em cũng không cần phải sang thăm \nBapeboy Camo, 10 gram GK như lang băm \nĐừng lo Covid vì anh vẫn hút như nam châm \nAnh chỉ lo rằng sẽ vẫn cô đơn dù bao nhiêu gian truân \nĐừng nhắn thêm tin nào cho anh, Insta anh không *** nhận \nChẳng thể nói với em rằng Lonely Stoni này là đang hâm\nPhong Khin đi mấy nốt nhạc đưa anh ra khỏi chốn này \nTự hứa với bản thân là phải quên em trong 4 ngày \nAnh sẽ phải đối mặt thôi, anh không muốn phải trốn chạy \nĐừng để anh thấy em với ai khác, baby anh không muốn vậy \nVùi mình trong studio, làn khói thật to, anh không muốn dậy \nChỉ muốn ai đó đưa anh đi, một thiên thần nào đó có thể xuống đây \nQuấn thêm một cây nén phải thật chắc và điếu phải luôn đầy \nĐôi ba lời ca về em, anh ngân nga lúc cuối ngày \nBăng qua Cầu Giấy, anh chẳng nhận ra lối về \nHomie này gọi điện qua, làm vài khói đê \nCó thể chỉ vì muốn em vui nên trông anh hơi giống hề \nNhưng riêng câu \"yêu em\", anh sẽ nói khi không phê \nTít xa trên quốc lộ, lao thật nhanh không đoái hoài \nVít ga tốc độ, anh chẳng muốn phải ngoái lại \nTừng câu em vừa nói khiến con tim này tái dại \nEm nói rất dài, nhưng chốt lại bằng câu \"bye bye\" \n\nVer JasonDilla:\n12 giờ đêm qua nghe tiếng em kêu thất thanh \nTrong cơn mộng du, em nói rằng yêu nhất anh \n12 giờ đêm nay, anh đang trên xe rất lạnh \nVì biết rằng chẳng đi về đâu, chuyện của ta bất thành \nEm chỉ đến khi anh có rất nhiều, \nKhông còn gì, em bỏ đi rất nhanh \nAnh đã biết em không phải miền đất lành \nXin thông báo là bây giờ em mất anh \nĐể anh cùng những giai điệu đang chắp cánh \nHòa vào những vì sao lấp lánh \nChúng ta chỉ đến đây, coi như max cảnh \nKhông muốn nói bye, nhưng mà thôi chắc đành \nKhông thể nói chi, anh không biết phải nói gì \nCho vào vali, xong rồi anh lại gói đi \nBao yêu thương nhưng sao đã vội quên \nĐể nỗi buồn đi cùng anh, xa rời em",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/BangQuaCauGiay-WxrdieRPTJasonDilla-16690253.mp3?st=ABb_b_HWQxZnG-d42LMtwQ&e=1732106490&a=1&p=0&r=ac36ab769149ace0eb4ba7b8ef63cf9d"
    },
    {
      "title": "Đến Thăm Anh Đi",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Đến Thăm Anh Đi do ca sĩ Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/DenThamAnhDi-Wxrdie-16696445.mp3?st=gl9eN2045qDTqH1qpKy3QA&e=1732106004&a=1&p=0&r=4f4d63c095145502a92e33bf64b9bd76"
    },
    {
      "title": "Life Of A Hxstler",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Life Of A Hxstler do ca sĩ Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/LifeOfAHxstler-Wxrdie-16696446.mp3?st=4mbU962OwjoRIBdqun5Qdw&e=1732105828&a=1&p=0&r=78509ba194fc937dcf1ea80f1cf707d5"
    },
    {
      "title": "Lonely Stonie",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Lonely Stonie do ca sĩ Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/LonelyStonie-Wxrdie-16696447.mp3?st=HdxymxoDNm21PmSOppZBHg&e=1732105818&a=1&p=0&r=8adbe48d3898573eba7e80087567f3d4"
    },
    {
      "title": "Mấy Đứa Nhóc",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Mấy Đứa Nhóc do ca sĩ Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/MayDuaNhoc-Wxrdie-16696448.mp3?st=BQ3k56iR-H9HA8wx6XyQxw&e=1732105809&a=1&p=0&r=877e9c5e5b5e9d80f5150321c6e880f4"
    },
    {
      "title": "Trở Về",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["JustaTee", "Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Trở Về do ca sĩ JustaTee, Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/TroVe-WxrdieJustatee-16696449.mp3?st=m7SP-gx6wqM4qSPSLBas1A&e=1732105883&a=1&p=0&r=dd8a0be8aea8464fa0437845298c0c8d"
    },
    {
      "title": "Pray For",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["KayC", "Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Pray For do ca sĩ KayC, Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/PrayFor-WxrdieKayC-16696450.mp3?st=5laZkwZnQOGwlQQTh4qbVQ&e=1732105863&a=1&p=0&r=9da8b02370c8c0afd4332f53e8f8170a"
    },
    {
      "title": "Bởi Vì",
      "cover_img":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Bởi Vì do ca sĩ Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/BoiVi-Wxrdie-16696451.mp3?st=AkWvsMCW9lpGDhSXVbS7kw&e=1732105800&a=1&p=0&r=3b662f6526ce32eacd2e744eb45bc008"
    },
    {
      "title": "Tim Anh Ghen",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie", "LVK", "Dangrangto"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Tim Anh Ghen do ca sĩ Wxrdie, LVK, Dangrangto, V.A trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/TimAnhGhen-WxrdieDangrangtoTeuYungBoyLVK-16696453.mp3?st=mH-E2P-hTOpQ0PnjtVwo7A&e=1732107680&a=1&p=0&r=cdc2a1876907caed04e12e7455e402a1"
    },
    {
      "title": "Get Money",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie", "Thai VG"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Get Money do ca sĩ Wxrdie, Thai VG trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/GetMoney-WxrdieThaiVG-16696454.mp3?st=oQJbWmljLPuoWXBt1ONfDw&e=1732106040&a=1&p=0&r=88bc087feb22adcae036965ccf090117"
    },
    {
      "title": "Anh Freestyle",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Gill", "Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Anh Freestyle do ca sĩ Gill, Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/AnhFreestyle-WxrdieGill-16696455.mp3?st=cm7i_IjLhSNOaW0hre5u-A&e=1732105850&a=1&p=0&r=43e6378336030714bb25d1de226cf5ab"
    },
    {
      "title": "Đau Đầu",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/10/23/0/6/b/2/1729657738885_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "Yeah, yeah, yeah\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nAnh chỉ muốn hustle hard\nĐể mình mau giàu\nNghĩ quá nhiều khiến anh bị đau\nCòn mấy thằng anh em đang ở sau\nKhông có thời gian để mà âu sầu\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nAnh chỉ muốn hustle hard\nĐể mình mau giàu\nNghĩ quá nhiều khiến anh bị đau\nCòn mấy thằng anh em\nĐang ở sau tàu\nKhông có thời gian\nĐể mà âu sầu yeah\nKhi anh xuất hiện ở trên social\nAll of your brand muốn được promo\nAll of your friends want to follow\nDj inbox xin cả vocal\nWhen I pull up\nI'mma *** all the club\nI told my bro, senda loco\nI told my bro\nLet me roll one\nNếu mày không phải đồng minh, ok hold on\nIn studio nhạc tao biên soạn\nBa mươi con flow\nNạp vào băng như từng viên đạn\nNhưng sự thật bị chúng nó xuyên tạc\nLàm bọn ruồi trên mạng\nChúng nó bu vào đến điên loạn\nTừ ngày đến tối\nChỉ lên mạng xỉa xói\nÍt thằng nào làm\nMà đa phần là chỉ nói\nBước ra từ trong khu rừng tối\nAnh em tao lại kiếm về\nVà chia thành từng gói, yeah\nNăm trăm tao nhập vào nhà kho, yeah\nNăm trăm tao đưa cho bà bô, yeah\nNăm trăm tao xếp vào trong ba lô\nNăm mươi tao tiêu\nNăm mươi tao chia cho my bros\nBọn nó cứ đứng đó\nĐể mà ngó vào\nĐàn em tao quần bó vào\nWave Alpha lùa mày như là gió Lào\nĐưa ra quyết định thông minh hơn\nAnh em trông tinh khôn\nYou gonna know what the *** going on\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nAnh chỉ muốn hustle hard\nĐể mình mau giàu\nNghĩ quá nhiều khiến anh bị đau\nCòn mấy thằng anh em đang ở sau\nKhông có thời gian để mà âu sầu\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nAnh chỉ muốn hustle hard\nĐể mình mau giàu\nNghĩ quá nhiều khiến anh bị đau\nCòn mấy thằng anh em\nĐang ở sau tàu\nKhông có thời gian\nĐể mà âu sầu yeah\nChúng nó bon chen\nHết cái để bốc phét\nLại lấy tao ra làm content\nVài cái comment\nChúng nó muốn bôi nhọ bọn tao\nBằng vài cái comment\nKhông đại diện cho gen gì cả\nCũng không phải hình mẫu lý tưởng\nCho con em\nChỉ là những cậu bé\nTao bước ra từ con hẻm\nSh Ý vẫn sáng đèn ở trong đêm\nBiết thời buổi cần like\nVà tao biết thời buổi cần tim\nChúng mày quên mất mình là ai\nTao chỉ biết mỉm cười rồi lặng im\nHai lần của một phần hai\nGiúp tao được kết nối với thần linh\nPhải sám hối cho những lần sai\nVà phải tự ban thêm cho mình\nMột lần tin\nAnh em xã đoàn\n24/7 vẫn luôn luôn sẵn sàng\nPull up làm con show\nQuá là dã man\nTình cảm anh em\nĐi lên như giá vàng\nNhìn chúng nó quá xàm\nNhững gì fake\nThì trước sau cũng đã tàn\nKhỏi phải nói nhiều\nVề những thứ đã làm\nChỉ được bám theo\nKế hoạch ta đã bàn\nVà bầy chó vẫn phải ăng ẳng\nCùng nhịp beat vẫn đập văng vẳng\nChẳng có chi mà phải căng thẳng\nDoanh thu vẫn ngày một tăng dần\nDòng máu Việt Nam, đích tôn họ Phạm\nThắp hương cúng tổ tiên\nMỗi ngày trăng rằm\nHàng tá thứ phải lo\nNhưng vẫn luôn phải nhớ\nNhững gì ba má của tao\nThường căn dặn\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nNghĩ quá nhiều khiến anh bị đau\nAnh chỉ muốn hustle hard\nĐể mình mau giàu\nNghĩ quá nhiều khiến anh bị đau\nCòn mấy thằng anh em đang ở sau\nKhông có thời gian để mà âu sầu\nNghĩ quá nhiều\nKhiến anh bị đau, đau đau\nNghĩ quá nhiều\nKhiến anh bị đau đau đau\nNghĩ quá nhiều\nKhiến anh bị đau đau đau\nNghĩ quá nhiều\nKhiến anh bị đau đau đau\nNghĩ quá nhiều khiến anh bị",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/DauDau-Wxrdie-16696456.mp3?st=fO2U2CEa6fCF-AMJpYKoaQ&e=1732105991&a=1&p=0&r=3b57ddd59da2b2ff9a36c5984a5a1312"
    },
    {
      "title": "29",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie", "Mason Nguyen"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho 29 do ca sĩ Wxrdie, Mason Nguyen trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/29-WxrdieMasonNguyen-16696457.mp3?st=8S1qZ13D4ySprRaRtusm7Q&e=1732105964&a=1&p=0&r=953b4c3a5b775763911495958686d8ae"
    },
    {
      "title": "Siêu Nhân Ngao",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["24k.Right", "Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Siêu Nhân Ngao do ca sĩ 24k.Right, Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/SieuNhanNgao-Wxrdie24kRight-16696458.mp3?st=TcGN6f5J-a8SQxx4rvZxGA&e=1732105842&a=1&p=0&r=5295342c464e4864c6feb1ec3c3ac899"
    },
    {
      "title": "Gia Tài",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie", "BABY SMOKE"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Gia Tài do ca sĩ Wxrdie, BABY SMOKE trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/GiaTai-WxrdieBABYMOKE-16696459.mp3?st=sc_1ZmxtsxiybLQHr43XdQ&e=1732106025&a=1&p=0&r=b36424c44f3bb5fc1c4b5655d39d58de"
    },
    {
      "title": "Lối Sống",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Lối Sống do ca sĩ Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/LoiSong-Wxrdie-16696460.mp3?st=RrmZsO4ZEQfsTcbyQBWqTw&e=1732105791&a=1&p=0&r=5c2c86055f278ca8e0ed64949c060c04"
    },
    {
      "title": "Nu Cep",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Nu Cep do ca sĩ Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/NuCep-Wxrdie-16696461.mp3?st=y2_80rSQypSeZ0EABCFUEA&e=1732105769&a=1&p=0&r=95e4064709f46b1991d5109065a8ce80"
    },
    {
      "title": "Tổng Kết",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie", "Lil Wuyn"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Tổng Kết do ca sĩ Wxrdie, Lil Wuyn trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/TongKet-WxrdieLilWuyn-16696462.mp3?st=xKEg6-Q9ColSJXSWg44GWw&e=1732105923&a=1&p=0&r=2ddd1a7b35405aefa804bdf90c8ec185"
    },
    {
      "title": "Cả 2",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie", "QNT", "Spideyboy"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Cả 2 do ca sĩ Wxrdie, QNT, Spideyboy trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/Ca2-WxrdieQNTSpideyboy-16696463.mp3?st=-qpkyT0pHT-_4Go7mDqCxg&e=1732105942&a=1&p=0&r=9f0570cb5511e40755caad3aabbae1ec"
    },
    {
      "title": "Lâu Đài",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie", "Flava Sati"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Lâu Đài do ca sĩ Wxrdie, Flava Sati trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/LauDai-WxrdieFlavaSati-16696464.mp3?st=JS6OQYVaOk8qCeJJ-BjBLg&e=1732105956&a=1&p=0&r=979da8de2cf7f3f213b54e42ce49390b"
    },
    {
      "title": "Mời Em",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Mcee Blue", "Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Mời Em do ca sĩ Mcee Blue, Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/MoiEm-WxrdieMceeBlue-16696465.mp3?st=X3UvOrFTBXiXBQozB6y4lQ&e=1732105936&a=1&p=0&r=587c7fed858bfaa76f8f00c149bc7ecc"
    },
    {
      "title": "Thíc Qé",
      "image_url":
          "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
      "artist": ["Wxrdie"],
      "lyric":
          "- Hiện chưa có lời bài hát nào cho Thíc Qé do ca sĩ Wxrdie trình bày. Bạn có thể click vào đây để đăng lời cho bài hát này.",
      "url_media":
          "https://stream.nct.vn/Unv_Audio539/ThicQe-Wxrdie-16696466.mp3?st=frtwl4NzXjikmfwIA9VxUg&e=1732107847&a=1&p=0&r=6939df3d4eb5249cfc412f1c69e6a134"
    }
  ];

  static List<Track> wrxdieSong =
      FakeData().parseSongs(FakeData().theWrxdiesSongJson);
  static List<Track> obitoSongs = [
    Track(
        title: "Shape Of You",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/vi/a/a3/Shape_of_You_cover.jpg",
        lyrics: "",
        urlMedia:
            "https://stream.nct.vn/Warner_Audio39/ShapeOfYou-EdSheeran-6448581.mp3?st=N5THxUw4o_I-mm_RKhIrWQ&e=1732110284&a=1&p=0&r=a3702adeee3a9be4090d41d0b323583c&t=1731510634985"),
    Track(
        title: "Đầu đường xó chợ",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:41",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Gọi thằng anh để tránh cái án\nTrong xóm tao hỏi mày đang đâu\nTiếng canh sòng ở bên đường đắp\nGấp gáp trả lời là đang xâu\nCó thằng anh thì chấp hành tốt\nRa sớm nói chuyện như Đen Vâu\nTrên bàn nhậu nó kể\nHồi đó chỉ vì vài ánh nhìn\nMà bem nhau\nCó thằng kiếm cơm bằng xe đai\nLang thang nơi biên giới dù đêm thâu\nCó thằng mất đi anh chị em\nCần bia và rượu để quên đau\nTao lớn lên từ đường hẻm\nNơi không dễ dàng để tin nhau\nTao biết hết ngõ ngách tầng lớp thấp\nNơi không ai muốn vào thêm sâu\nMấy thằng trẻ còn chưa đầy hai mươi\nNhưng số vết nó chém\nNhiều hơn số tuổi\nMục tiêu chạy vệt đỏ còn đang tươi\nNhưng cái tôi lớn kêu nó cố đuổi\nMắt nó trừng như thể trời gầm\nDù nhà thờ Đức Mẹ Quan Âm\nDùng bạo lực để tạo ra luật\nQuyền lực là thứ mà nó quan tâm\nĐời tẩy chay vì nó dính án\nĐối với tao tụi nó là bạn\nTao thấy được lí do nó làm\nĐằng sau câu truyện mà nó dính dáng\nXưa nó vẫn cùng tao đến trường\nThầy cô khen tương lai nó sáng\nNhưng tất cả mọi thứ thay đổi\nChỉ vì một lần nó đeo khăn tang\nThằng tốt tính nhưng ba mẹ mất sớm\nVì chất kích thích nên phải vào đời\nThằng thì anh em ngã xuống\nVì dao kiếm\nHận thù nên lao đầu vào cuộc chơi\nThằng bị ăn hiếp ám ảnh từ nhỏ\nNên thích vung đấm\nĐể không thành trò cười\nThằng thì đỏ đen, bán gia bại sản\nCha mẹ từ mặt nên thành bụi đời\nThằng thì tâm lý tan nát vì tội\nMỗi đêm dằn vặt đọc kinh xám hối\nThằng thì vẫn chưa nhìn thấy được ngày ra\nVì một phút bốc đồng\nĐể cảm xúc lên ngôi\nThằng thì vốn không còn lựa chọn nào\nĐành bước chân vào để được tồn tại\nThằng thì chỉ mong\nTìm lại được yên bình\nNhư những ngày bé để không chọn sai\nGọi thằng anh để tránh cái án\nTrong xóm tao hỏi mày đang đâu\nTiếng canh sòng ở bên đường đắp\nGấp gáp trả lời là đang xâu\nCó thằng anh thì chấp hành tốt\nRa sớm nói chuyện như Đen Vâu\nTrên bàn nhậu nó kể\nHồi đó chỉ vì vài ánh nhìn\nMà bem nhau\nCó thằng kiếm cơm bằng xe đai\nLang thang nơi biên giới dù đêm thâu\nCó thằng mất đi anh chị em\nCần bia và rượu để quên đau\nTao lớn lên từ đường hẻm\nNơi không dễ dàng để tin nhau\nTao biết hết ngõ ngách tầng lớp thấp\nNơi không ai muốn vào thêm sâu\nThằng thì đi tắm sông chung bầy\nSẩy chân té vào tay người âm\nThằng hưởng dương trong khuôn viên trường\nNên nó sống mãi tuổi 15\nThằng bước ra sau phiên phúc thẩm\nChỉ cười rồi nói là thua rồi\nThằng có tiền còn sống không thọ\nThì thằng thiếu thốn thường đua đòi\nĐất chật người ngông\nCha nó lấy bạo lực làm nôi\nNên nó không thích sống kiếp làm công\nHai chữ gia đình sẻ làm đôi\nNó bỏ nhà đi bụi đời\nRa đường làm con tốt\nHay ra đường để làm con tốt\nThí cặp mắt này mù vì\nDù gì sống đách cần nhìn trước sau\nNó chưa từng có ước ao\nNgoài việc thoát khỏi bản chất\nCủa một thằng ù lì\nĐiểm cuối cuộc đời hên xui\nNhư chơi oẳn tù xì\nCái bo cũng chỉ để gõ\nNếu ở đó nó được gọi là cô nhi\nNên lánh nhanh\nTrước khi đột ngột qua đời\nNó không định đánh anh đâu\nMà là tới cắt nhượng\nMóc ruột lột da\nAnh liều một pha\nCho má có vốn mở sạp bán bánh canh\nRồi ra đầu thú theo lệnh\nTheo lệnh triệu tập của 113",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/DauDuongXoCho-Obito-11836720.mp3?st=UZXn7SFNYKW6jLCrvHdH2w&e=1730940483&a=1&p=0&r=4a25d3ccf74387bf4ec1dd6aba4d0e1c"),
    Track(
        title: "Biên Giới Long Bình",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://cdnphoto.dantri.com.vn/dwOovse6dSoNOrSDXyRAmQt9LZ0=/thumb_w/1020/2024/07/31/obito-rapper-26-1722417901486.jpg",
        lyrics:
            "Xe đai đang lăn bánh\nHướng thẳng về phía biên giới Long Bình\nTay nó vặn hết số với tiếng nẹt bô\nQua nhiều công trình\nĐồ phạm pháp sau lưng xe\nNên đường lui nó quyết không nhìn\nTốc độ nó đang đi\nĐủ có thể đưa nó lên khung hình\nLỡ đụng ai chết nó cũng mặc kệ\nVì lời khuyên trong nghề toàn thế\nThà là không ai nhìn thấy nó\nCòn hơn là không còn thấy đường về\nĐặt mạng sống lên trên bàn cân\nVì chỉ mong cho nhà cửa không đói\nTâm cắn rứt thì cũng phải cam\nNó trách sao đời đối xử nó tệ\nNó sẵn sàng cho kẹo đồng bay\nKhi giao dịch bị sai chi tiết\nSẵn sàng xuống tay hạ thằng khác\nNếu đó là cách để nó đi tiếp\nNếu là cách để nhà nó no\nKéo một khói thật to khi siết\nVới người thân nó là người tốt\nCòn với mày là một sự uy hiếp\nChấp nhận để thân dính mùi tanh\nĐể nhà ngửi mùi trong lành\nKhí nó toát ra mặt lạnh tanh\nKhi cuộc đời nó không thành\nNó là thứ gia đình mày sợ\nKhi đồng hồ báo là đêm về khuya\nNó là đứa con ngoan của quỷ\nKhi bị đời cho ra rìa\nDon't let them run though\nĐừng để nó chạy\nLỡ lại khổ ai thành nạn nhân\nDon't let them run, don't let them run\nDon't let them run\nLại thêm một vụ\nThêm một vụ, thêm một vụ\nDon't let them run though\nĐừng để nó chạy\nLỡ lại khổ ai thành nạn nhân\nDon't let them run, don't let them run\nDon't let them run\nLại thêm một vụ, thêm một vụ\nThêm một vụ nó gây ra\nGiác quan nhạy trong màn đêm\nKĩ thuật như là game\nSố vết thương cộng thêm\nTâm lý nguyên màu đen\nNgửi được sự nguy hiểm\nHành tung như là phim\nCoi nó như thằng điên\nThằng bé chỉ muốn được yên\nNó không muốn\nNó được sinh ra trên cõi đời này\nĐể trở thành xấu\nNó hối hận vì sự lựa chọn\nĐể làm việc sai của nó lần đầu\nGiày xéo chính bản thân vì tội\nNó gây đau thương cho bao người khác\nNhưng quá trễ trở thành cụm từ\nMà nó nhớ mãi như một bài nhạc\nNó ước được chọn, ước được chọn\nƯớc được chọn lại\nKhác cuộc đời, khác hoàn cảnh\nKhác cả thực tại\nKhác suy nghĩ, khác hành động\nKhác những lần dại\nNhưng nó phải đền tội trong hôm nay\nVì cuộc sống không ưu ái một ai\nDon't let them run though\nĐừng để nó chạy\nLỡ lại khổ ai thành nạn nhân\nDon't let them run, don't let them run\nDon't let them run\nLại thêm một thằng, thêm một thằng\nDont let them run though\nĐừng để nó chạy\nLỡ lại khổ ai thành nạn nhân\nDon't let them run, don't let them run\nDon't let them run\nLại thêm một thằng, thêm một thằng\nThêm một thằng được sinh ra",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/BienGioiLongBinh-Obito-11836721.mp3?st=JU3Tz_zgIhP6j2XEIb2vZQ&e=1730872705&a=1&p=0&r=40bc0bbb44f75652e74b9f74d70ea85d"),
    Track(
        title: "16",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Bắt đầu 16\nTừ bỏ ý định làm người xấu\nTập tễnh viết lời vào tờ giấy\nĐem bao chuyện không hay\nMuốn kể cho mọi người thấu\nYoung boy with the passion\nLove to know he thinks back\nMặc kệ mọi thứ đang dang dở\nBut * it I still rap\nBắt đầu thêm những chuyện không vui\nNhưng lần này vấn đề\nNó không nằm ở ngoài đường\nThằng bé bắt đầu biết dùng âm nhạc\nĐể vẽ thêm màu sắc\nThêm hi vọng trong đời thường\nBa mẹ nó làm việc đến thâu đêm\nCũng không vui với cái cách nó chọn đường\nThằng bé lúc đó cũng không nghĩ\nÂm nhạc cùng với nó sau này\nTrở thành tình trường\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nLúc đầu toàn lời độc trong lời văn\nChửi thề dính ở mồm như thuốc phiện\nNhạc chửi thì ai mà muốn nghe\nCõi sâu của tâm hồn\nThì sau này nó mới tìm\nCảm xúc cứ như nén ở phần ngực\nCon người mới đôi khi khiến nó buồn bực\nMơ lớn và tính cách hiếu thắng\nNhưng tự tìm cách bước\nĐôi khi khiến nó ấm ức\nNhưng kiên quyết\nKhông muốn trở thành người xấu\nVẫn cố dù không biết đi từ đâu\nChân cứ bước đi trong vô thức\nCũng vô thức trưởng thành hơn ngày đầu\nSự vô thức làm tâm hồn nó nở hoa\nSự vô thức làm nó chìm trong cảm xúc\nSự vô thức tạo cho nó thế giới riêng\nVô tình khiến nó không biết\nChuyện gì đang diễn ra\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNgười thân trong nhà cắn xé nhau\nBiến cố ập ngay lúc nó bay bổng\nThêm một lần thằng bé đó đau lòng\nBắt đầu biết sao ba mẹ làm thâu đêm\nĐể ý khi mẹ trốn vào một góc\nBiết được những con số cần giải quyết\nNhững con số khi nhìn vào là bật khóc\nQuyết định đứng dậy và nó đi\nBỏ tâm sự vào âm nhạc điều nó nghĩ\nLao đầu vào cuộc đời mạng nó phi\nKhông ngại làm con tốt cho đời thí\nChuyến xe đưa nó đi xa thật xa\nTrách nhiệm không cho chân nó được ngã\nNuôi ý chí để dòng họ nó nhờ vả\nÔm giấc mộng thành công\nĐể tâm hồn được về nhà\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/16-Obito-11836722.mp3?st=hvwVuVSedw9_OSZBFgPUkA&e=1730941456&a=1&p=0&r=7e5eea6f1af4fb2c1c03367b79c6ce47"),
    Track(
        title: "Sài Gòn ơi",
        album: Album.defaultAlbum(),
        artist: Artist.defaultArtist(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Ouuuu Sài Gòn ơi ouuu Sài Gòn ơi\nSao em lại đối với anh như này\nOuuuu Sài Gòn ơi ouuu Sài Gòn ơi\nSao em lại đối với anh\nTim anh nóng lòng gặp nàng\nĐể cảm xúc lên từng nhịp\nNơi quá khứ anh không vui\nHạnh phúc mắt anh không nhìn kịp\nAnh pack hết đồ nhìn thật lâu\nBồi hồi trên chuyến xe trong đêm\nMắt sáng như sao\nVì được nghe thật nhiều điều vui\nKhi bên em\nTrò chơi em thích đánh đố\nPhố sáng khi em lên đồ\nVì tương lai nên anh cũng cố\nDù em khiến anh đôi khi hơi rồ\nVà giá như giá như giá như\nVà giá như giá như giá như\nGiá như anh hiểu được em\nOuuuu Sài Gòn ơi ouuu Sài Gòn ơi\nSao em lại đối với anh như này\nOuuuu Sài Gòn ơi ouuu Sài Gòn ơi\nSao em lại đối với anh như này\nTưởng chừng như dài lâu\nTưởng như yêu đậm sâu\nTưởng như ta hợp nhau\nGiờ còn chẳng nói với nhau một câu\nEm dắt anh đi gặp nhiều người\nDù họ không tốt với anh\nHọ khiến anh rơi giữa dòng đời\nMàn đêm đang kéo tới nhanh\nVà rồi em đâu\nTình mình thêm đau\nTại sao em nỡ vô tâm\nĐể vỡ trái tim người yêu em nhiều nhất\nOh oh baby à baby\nRồi người ta cũng sẽ bỏ em đi\nKhi mọi thứ đã đủ đầy\nChỉ mình em với những\nKhoảng không cô đơn\nỪ thì anh vẫn thương em\nNhưng làm sao để quay về\nNgày tình mình như hôm nào\nOh oh oh\nOh oh oh\nOh oh oh\nOh\nGiá như anh hiểu được em",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/SaiGonOi-Obito-11836723.mp3?st=y51o9x0jRFZce6uYriRd-Q&e=1730896233&a=1&p=0&r=209d155f38ece3be722e7eac81b938ac"),
    Track(
        title: "Trốn Chạy",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Đầu óc tao đang nặng trịch đi\nNếu mà ngay từ đầu\nNày chỉ muốn lợi dụng tao\nSao con ph* mày không nói m* vậy đi\nLàm ra vẻ ai cũng muốn làm hại mày\nCho tao hỏi mày làm vậy để chi\nNước mắt cá sấu để chi\nHay vì sợ cuộc đời mày dễ bí\nHay trên đời mày không còn ai để thí\nNội tao tim yếu rồi đêm đau\nSố mà tao kiếm được\nTao mong gửi về cho gia đình\nBao nhiêu thành phố nhiêu đêm thâu\nChạy show cho một đống\nĐể tâm lý rơi vào sự vô định\nLời mày nói đ** đúng với sự thật\nCơm mày ăn đ** phải là của mày\nVấn đề trong đời tao đủ chật\nVà tao nghĩ mặt mày cũng đủ dày\nTất cả thứ thuộc về tao\nĐáng ra có thể giúp\nCho ba mẹ tao bớt cực và bớt khóc\nTất cả thứ thuộc về tao\nĐáng ra có thể mua\nCho thằng em tao tuổi thơ không cực nhọc\nTất cả thứ thuộc về tao\nĐáng ra có thể làm\nCho gia đình tao thoát khỏi nơi chết chóc\nTất cả thứ thuộc về tao\nGiờ lại nằm trong túi mày\nTao phải nghĩ cách tồn tại đến nát óc\nCũng là giá tao phải trả cho hào quang\nGiá tao phải trả vì ngu dốt\nGiá tao phải trả\nVì những thứ tao không hiểu\nNhưng lại đi đặt niềm tin nơi không tốt\nTâm lý bị xé nát nơi quận 2\nSức khoẻ bị vắt kiệt đến hết sức\nKhoá miệng tao không tin một ai\nVà có cả suy nghĩ\nCần nhảy xuống để kết thúc\nChân cứ lê bước đi trong màn đêm\nCố tìm lại bản thân tao từng nên\nRượu gái chất cấm trong hộp đêm\nTrốn chạy những cảm xúc đang ập đến\nSự tự tin tao luôn có mất đi\nÁnh nắng trong nụ cười tao mất đi\nNgây thơ trong người tao mất đi\nCảm xúc cho âm nhạc cũng mất đi\nĐầu óc tao đang nặng trịch đi\nNếu mà ngay từ đầu\nMày chỉ muốn lợi dụng tao\nSao con ph* mày không nói m* vậy đi\nLàm ra vẻ ai cũng muốn làm hại mày\nCho tao hỏi mày làm vậy để chi\nNước mắt cá sấu để chi\nHay vì sợ cuộc đời mày dễ bí\nHay trên đời mày không còn ai để thí\nNội tao tim yếu rồi đêm đau\nSố mà tao kiếm được\nTao mong gửi về cho gia đình\nBao nhiêu thành phố nhiêu đêm thâu\nChạy show cho một đống\nĐể tâm lý rơi vào sự vô định\nLời mày nói đ** đúng với sự thật\nCơm mày ăn đ** phải là của mày\nVấn đề trong đời tao đủ chật\nVà tao nghĩ mặt mày cũng đủ dày\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nGiữ tất cả mọi thứ cho riêng tao\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nMong một giấc thật ngon trong chiêm bao\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nThêm thuốc vào cho quên đau\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nNỗi niềm này tao phải nuốt ngược vào\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy trốn chạy trốn chạy\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nTrốn chạy trốn chạy\nNên tao phải trốn\nNên tao phải trốn",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/TronChay-Obito-11836724.mp3?st=4iskjvq9LGjKzexQ8GeOcg&e=1730941467&a=1&p=0&r=4659e255b7dea9de38652b51fb63ab71"),
    Track(
        title: "Cất cánh (interlude)",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics: "Hẹn gấp chú ýChúng tôi xin báo báo chúng ta...",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/CatCanhInterlude-Obito-11836725.mp3?st=PyngbhDxU408JT7BQwYweA&e=1730941472&a=1&p=0&r=1f6f6862be768dd4c956d0208f162a7b"),
    Track(
        title: "Hà Nội",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Họ gọi thành phố này là\nNơi khó tồn tại\nNhưng đây là nhà\nChỉ một mình em hiểu được buốt giá\nYêu sự buốt giá\nVì lòng lạnh lẽo nhiều rồi\nKhông có điều gì\nEm không hiểu được\nChỉ một tình yêu một lòng\nEm đã lựa chọn không ai lấy được\nAi làm đau anh à\nKhông sao đâu baby\nBaby hãy hãy nắm lấy tay em\nAi lừa dối anh à\nKhông sao đâu baby\nBaby có thể tin em\nEm xua đi cơn mưa buồn\nEm nuôi anh trong tâm hồn\nEm không chơi\nEm không đùa em yêu thôi\nEm cho anh thế giới đẹp\nEm cho anh thấy hết rồi\nNếu có ngã em sẽ dìu anh đi thôi\nBaby anh đang lo gì\nBaby anh đang nghĩ gì\nNghĩ nhiều mệt thêm thôi\nRơi sâu vô xuống bóng tối những góc tối\nChỉ mình anh thấy\nNước mắt giá buốt vết xước\nNhững nhức nhối\nVờ rằng không thấy\nAnh chỉ đang cố nuốt hết vào trong\nChờ một ngày nắng lên\nNhư anh hằng mong\nChợt bỗng dưng thấy em đến bên\nHealing all off my scars\nĐuổi đám mây tối đen\nVẽ lên cánh chim đang vươn xa\nLàm anh hiểu ra làm anh hiểu ra\nLàm anh hiểu ra nhiều điều\nEm khiến anh nhìn sâu vào tâm hồn\nLà tiếng êm mặc kệ\nBên ngoài kia ồn\nDẫn anh đi trong đêm\nSoi sáng bước anh đến\nLung linh như ánh nến trước gió",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/HaNoi-Obito-11836726.mp3?st=ymr6zD6Z6RoSpFft5dAfYQ&e=1730935954&a=1&p=0&r=6e396336ce1420af4ae3678531138da5"),
    Track(
        title: "Vô Điều Kiện",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Khi mà ngây thơ không còn nguyên\nThì tìm đâu ra bình yên\nNốc thêm viên để xua cơn noi\nChân đi tìm sự vô điều kiện\nThấy được nhiều thứ cần kiêng\nCố gắng cho đến lúc nằm yên\nKhông mở lòng một cách tuỳ tiện\nKhông để thứ không đáng làm phiền\nNhớ lại những lúc mà còn nhỏ\nThế giới này thật đẹp\nViệc cho việc nhận\nVốn không cần phải ghi chép\nCho đi vì mình yêu\nNhận lại dù không đòi\nTrao ai cũng như vậy\nKhông biết thế nào xấu\nThế nào là cao đẹp\nĐơn giản là tình yêu thuần khiết\nHay tại tao lớn quá nhanh\nTâm hồn đang héo mòn dần\nĐã từ bao giờ khi con tim\nVà lý trí chia hai\nRồi không còn thân\nĐã từ bao giờ\nTao đa nghi với mọi thứ\nNiềm vui kia không còn cần\nĐã từ bao giờ\nTao lại trở nên\nKhô cằn đến như này\nNụ cười kia không còn phần\nHay là tại tao tại mày tại đời\nTao cũng không biết\nHay là tại tao tại mày tại đời\nSự vô điều kiện từng trong tao\nNay lại thành có điều kiện\nTao cần điều kiện\nĐể có thể gặp một người\nCó thể đặt niềm tin vào một người\nCó thể làm việc cùng một người\nCó thể chia sẻ cho một người\nVà có thể để đi cùng với một người\nHay là tại tao tại mày tại đời\nTao cũng không biết\nHay là tại tao tại mày tại đời\nTao cũng không biết\nKhi mà ngây thơ không còn nguyên\nThì tìm đâu ra bình yên\nNốc thêm viên để xua cơn noi\nChân đi tìm sự vô điều kiện\nThấy được nhiều thứ cần kiêng\nCố gắng cho đến lúc nằm yên\nKhông mở lòng một cách tuỳ tiện\nKhông để thứ không đáng làm phiền",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/VoDieuKien-Obito-11836727.mp3?st=qULnRM2rG4aIkk12btOxDQ&e=1730941483&a=1&p=0&r=21f8de9b7961594887ce91e17cce6bbb"),
    Track(
        title: "Đánh Đổi",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Tao đánh đổi màn đêm yên giấc\nViết những bài nhạc hay nhất cuộc đời\nDi sản là nguồn cảm hứng\nFan theo răm rắp nhạc tao thuộc lời\nTrên bàn tiệc của tiên và quỷ\nTao là thằng duy nhất được mời\nMọi thứ đổ dồn hết vào tao\nNhư kiểu tao là một ván cược hời\nTao là đứa con của mặt trăng\nMang năng lượng mặt trời\nCuộc đời xoay tao như trực thăng\nVẫn vượt lên như thể gặp thời\nTao không vứt đi bản chất tao\nNhư mấy thằng khác để ví được lời\nNếu mày cũng mặt nặng mài nhẹ\nVì không đồng ý thì thôi được rồi\nShout out cho anh Sea\nLời chúc phúc bay trên bầu trời\nEm mong anh hãy nói với mẹ\nCuộc sống con giờ đã đỡ cực rồi\nHai anh em đã đổ nước mắt\nNhiều câu chuyện về những người tồi\nSự đánh đổi này vẫn luôn đẹp\nNhư thể ngày xưa chơi cất nhà chòi\n**** it\nĐêm đông lạnh giữa trời Hà Nội\nFlow tao chảy cùng những niềm đau\nNhư thể đang châm thêm mực vào ngòi\nChuỗi hành trình cùng nhiều câu hỏi\nAi là cá còn ai là mồi\nMọi thứ đều luôn có mặt tối\nNhưng liệu mày có sẵn sàng đánh đổi\nNgắm nhìn cả thế giới từ xa\nDamn it's cold\nNếu mày hỏi tao ác hay thiện\nMan I don't know\nChắc đây vốn đã là\nCái giá cho bao lần đau\nSự đánh đổi này cho tao thấy\nMọi thứ đã không như ngày đầu\nNgắm nhìn cả thế giới từ xa\nDamn it's cold\nNếu mày hỏi tao ác hay thiện\nMan I don't know\nChắc đây vốn đã là\nCái giá cho bao lần đau\nSự đánh đổi này cho tao thấy\nMọi thứ đã không như ngày đầu\nIt's a fair trade\nTelling all the truth\nIt's a fair trade\nAin't none pussy in the way\nIt's a fair trade\n**** you if you fake it\nIt's a ****ing fair trade oh\n2020 và tao nổi như hiện tượng\nNhưng không chìm vào trong đấy\nĐể rồi chết như thằng ngu\nBa năm đánh đổi\nĐể tu thân trong hoạ đời\nRồi biết đâu là thật giả\nTâm tao nhàn như tiều phu\nĐảo mắt quan sát\nNhư diều hâu đang đi lượn\nIm lặng và cười nhếch\nVới drama và ruồi bu\n2023 lời tao bắn như cái máy\nMà còn *** trượt phát nào\nSự đánh đổi đó thằng ***\nTrò đời quăng tao vào địa ngục\nCho tao biết mặt trái của whole game\nCho tao bài hit, cho fame\nXong nó lấy đi tất cả sao bao đêm\nTao vẫn vươn từ dưới đáy đi lên\nBật và đòi lại bằng được no shame\nChiêm nghiệm và mài giũa thâu đêm\nGiờ tinh khiết và óng ánh như blue gem\nKhông tìm thấy tao\nTao bận đi tu luyện\nCâu chuyện của tao\nCó đủ để hay hơn tụi mày\nTu xong dù thành tiên\nHay là thành quỷ\nVẫn ẩn khỏi radar\nThân vẫn đóng lớp bụi dày\nRất nhiều thằng trẻ\nLà trường hợp giống như tao\nNhưng bị nghề này nó dập\nXong tâm lý ở dưới đáy\nTao thoát được tệ nạn\nThoát được cảnh vung dao\nTao đánh đổi tất cả\nĐể chân chạy đến được đây hoes\nTrên cao\nTao biết là tao\nVẫn đang chính là tao\nKhi mà chơi chán\nThì peace I’m out\nĐôi khi rất là cô đơn\nTao lấy hết sự cô đơn\nTao lấp vào trong bank account\nNhư là pacquiao manny\nPacquiao shadowbox trên nền vinahouse\nVẫn chưa thấy thằng nào nhanh hơn tao\nThác đổ thác đổ\nFlow tao dồn xuống như là K50\nỞ dưới toàn núi đồi núi đồi\nBỏ mẹ rồi úi dồi úi dồi\nCẩn thận không bị cuốn vào cuốn vào\nAnh là mỏ ối người muốn đào\nAnh về rồi cúi người xuống nào",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/DanhDoi-Obito-11836728.mp3?st=agDsY1Ru2fnZi9gaFQvNVQ&e=1730941408&a=1&p=0&r=be413a18a18a47a6aa1c2bfdc7831b8d"),
    Track(
        title: "Backstage Freestyle",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "This is a hard flow\nI go J Cole on it\nTao găm niềm đau vào từng câu\nSắp xếp đúng chỗ như là công việc\nYeah feeling like Drizzy\nNhạc tao vang khắp\nSân khấu và ngõ hẻm\nCũng có thể cho mày\nTăng thêm thân nhiệt\nLiệu thằng nào biết\nSau khi bước xuống sân khấu\nThằng đang đứng rap\nNó giấu gì ở đằng sau\nNăm học cấp hai\nGhế nhà trường nó dính máu\nNiềm vui về gia đình\nDần đang biến thành niềm đau\nMan I feel pain my heart feel shitty\nTao biến những khoảnh khắc\nTao sụp đổ cùng nước mắt kia thành vàng\nVỗ ngực tự hào đó là tao\nNhắm vào vấn đề\nLời tao nã như AK\nĐể diễn tả ra được hết\nNhững xúc mà tao đang\nTrải qua từng ngày\nVới thân xác tuổi 18\nHai năm trước lập thành tích\nCũng là xích mà tao mang\nMày khoe mấy tờ giấy\nMua mày nhiều vàng\nCòn tờ giấy tao lấy\nMua về sự an toàn\nĐằng sau ánh hào quang\nNơi góc tối tao cất giữ\nLà khu đất cấm biệt tích\nMấy thằng ngu còn làm càng\nSinh ra để làm sao man\nSáng đến cách mấy\nCũng phải trải qua cay đắng\nTao đếm từng bài học\nXem nó như sắp tài liệu\nNhỡ khi đụng chuyện\nCần thiết vào trong đầu tao ngay ngắn\nMày lấy được nhiều fame\nTiền bạc và ống kính\nNhưng sau ánh hào quang\nTim mày liệu có ngay thẳng\nTao nói ra điều này\nĐể chứng minh rằng\nThành công tao có được ngày hôm nay\nVốn không phải do may mắn\nKhông chơi bóng rổ\nNhưng tao ball like Lebron\nVua của bản thân homie\nÝ chí tao là hổ gầm lên\nXua những giọng nói\nXung quanh đầu tao đang cố\nKêu tao thua đi\nGửi đi lời thách thức\nCho những thằng muốn tao ngã\nTao vẫn đang xuất hiện như là oxy\nTao sẽ kéo gia đình tao\nĐi hết ra khỏi hood\nSống một cuộc đời thượng lưu\nYeah mày nói đi\nỪ thì tao là đàn ông\nĐàn ông cũng phải khóc\nEveryone know it\nỪ thì mày hay phán xét về cuộc sống\nBut you don't know *\nDù mày đưa tao tiền tỷ\nĐể đổi lấy linh hồn tao\nMan I said * it\nAi lấy đi mà xài\nTao vẫn chọn con tim\nVì tao kiếm nhiều hơn thế\nBitch I know it\nThis is a hard flow\nI go J Cole on it\nTao găm niềm đau vào từng câu\nSắp xếp đúng chỗ như là công việc\nYeah feeling like Drizzy\nNhạc tao vang khắp\nSân khấu và ngõ hẻm\nCũng có thể cho mày\nTăng thêm thân nhiệt\nWoah từ sân bay đến sảnh\nResort đến khách sạn\nTừ Roll Royce đến Mer baby\nĐặt chân đến thành phố\nKhông phải là quê nhà\nMang đến âm nhạc baby\nKhung cảnh lặp lại\nAgain and again\nNhưng cảm xúc vẫn vậy baby\nCảnh anh ngồi bên kính xe\nLàn gió bên cửa sổ\nNgẫm nghĩ về cuộc đời baby\nTao rap đến khan tiếng\nNước miếng bắn vào màn hình\nThay vì ngồi than khổ yeah\nTao nuốt hết buồn đau\nVẽ nó vào bên trong nhạc\nNgười ta nói tao năng nổ yeah\nTao cược cả cuộc đời\nVào canh bạc với quỷ dữ\nCó cả máu tao đang đổ yeah\nVóc dáng của thiên thần\nNhưng mà ruột gan tao có\nNó xám tro như đồ cổ yeah\nNên thứ tao cho đi\nChỉ nhạc là nhạc và nhạc\nNhưng thứ tao bỏ vào âm nhạc\nLà vàng kim cương\nLà vàng cho nhạc rap\nChỉ là vài tờ nháp\nNhưng là cả một câu chuyện ở đằng sau\nNên dù đứng trên sân khấu\nGương mặt của tao cười\nNhưng liệu đó có thật sự là tao\nThis is a hard flow\nI go J Cole on it\nTao găm niềm đau vào từng câu\nSắp xếp đúng chỗ như là công việc\nYeah feeling like Drizzy\nNhạc tao vang khắp\nSân khấu và ngõ hẻm\nCũng có thể cho mày\nTăng thêm thân nhiệt\nThis is a hard flow\nI go J Cole on it\nTao găm niềm đau vào từng câu\nSắp xếp đúng chỗ như là công việc\nYeah feeling like Drizzy\nNhạc tao vang khắp\nSân khấu và ngõ hẻm\nCũng có thể cho mày\nTăng thêm thân nhiệt",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/BackstageFreestyle-Obito-11836729.mp3?st=VvMYNWaJM1xhU4oxZpybXw&e=1730941493&a=1&p=0&r=89a51152ed1c04665f3a30b3348a75c3"),
    Track(
        title: "Tell the kids i love them",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Và liệu em có nghe\nTình yêu đang vụn vỡ\nVà mất bao lâu\nĐể quên đi tổn thương\nDù là nhiều năm đã qua\nTrái tim chẳng thay đổi\nVà chỉ mong được bình yên sau này\nYeah và từ lần đó\nAnh chẳng còn nhớ nhung đầy vơi\nChẳng thân quen chẳng còn đau\nNhư đã từng yeah\nLife is better if you want to\nNếu em nhìn thật sâu\nVào trong đôi mắt\nEm có thể thấy rằng anh đang khóc\nAnh cũng nhiều lần gây tội\nVà cũng tiếc nuối vì chuyện công cốc\nAnh chạy theo tiếng đường phố\nLặp sai và sai cứ thế lao dốc\nAnh từng nghĩ rằng anh khôn\nCho đến khi đời bảo rằng anh ngốc\nAnh vẽ ra nhiều viễn cảnh\nNhưng anh không làm dù nó khiến anh mê\nAnh ao ước khi cần chạy\nThì việc anh *** chân vẫn là thực tế\nAnh nghĩ rằng nếu hung dữ\nThì những người khác sẽ thấy anh ghê\nNhưng đến khi được yêu thương\nAnh lại thích thú như một thằng hề\nAnh từng thích dùng bạo lực\nVì không thích thằng nào không tôn trọng anh\nĐến khi anh hiểu được ra\nAi không thích mình thì chỉ việc tránh\nAnh từng nói dối rất nhiều\nDù mấy chuyện đó không vì lợi danh\nĐến khi anh hiểu được ra\nHậu quả để lại không phải điều lành\nYeah anh không cao siêu như em nghĩ\nAnh từng là em là mày\nTừng là thằng ngu làm liều khi bí\nQuan trọng là khi nhận ra\nHành động tiếp theo của em là gì\nVì đồng tiền vốn đang có hôm nay\nKhông thể nào mai trở thành tiền tỉ\nAnh chỉ đơn giản là người làm nhạc\nLà thằng chạy theo đam mê\nVì biết cố gắng là một lối thoát\nĐã từng đâm đầu việc sai\nĐể biết rút ra mới là việc đúng\nNếu muốn yên bình trong ngày mai\nThì nay phải sống như ngày cuối cùng\nTìm một nơi để yên giấc\nSau tháng năm mệt nhoài\nVà để tâm hồn\nĐược hòa vào lời hát\nCó thể em ao ước giống như anh\nKhông muốn màu sắc cuộc đời\nChỉ pha vỏn vẹn giữa đen và trắng\nKhông muốn nhìn vào trong gương\nVì không thích thứ mình trở thành\nNhưng tất cả những cơn giông đó\nGiúp em trân trọng hơn khi bầu trời xanh\nAnh cảm ơn nếu mắt em sáng\nCảm ơn từng stream bài nhạc\nKhán giả nghe khi anh còn làm\nTrái tim anh vẫn nơi đây\nKhông hề âm mưu hay sinh ra kế\nAnh chỉ là một bằng chứng sống\nChứng minh câu nói\nKhông gì là không thể\nEm không cần cố để được như anh\nMỗi cây mỗi lá mỗi cành\nMỗi người mỗi chuyện\nMỗi nhà mỗi cảnh\nEm chỉ cần là chính em\nChạy theo tương lai em muốn trở thành\nDù đường đời em trải nhiều màu\nThì cũng chỉ tô đẹp thêm\nCho một bức tranh\nHãy lắng nghe những gì em muốn\nĐể thời gian sửa những điều em sai\nVì cuộc đời không hề gắt gỏng\nVới những đứa con đang muốn làm lại\nHãy sống thật là hạnh phúc\nĐưa bản thân đến một nơi cao\nBài này vẫn sẽ mãi ở đây\nĐể luôn nhắc nhở\nEm là một ngôi sao",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/TellTheKidsILoveThem-ObitoShikii-11836730.mp3?st=_hIeAUEndIv_MXkukTPLyQ&e=1730872460&a=1&p=0&r=f0b8cfc55795fcecdf442d990cee5ad8"),
    Track(
        title: "Ước mơ của Mẹ (interlude)",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Nè anh AloNèMẹ con hỏi mẹ cái này cái được không?Nói điNếu mà bây giờ kiểu gia đình mình lo xong hết kiểu chuyệnLo xong hết mấy cái vấn đề của gia đình,những cái khó khăn của gia đìnhThì cái lúc đó mẹ rảnh nèMẹ không còn phải lo,phải nghĩ gì nữa hếtThì cái chuyện đầu tiên mà mẹ làm thì mẹ sẽ làm cái gì?Mẹ cũng không biết cái gì luôn nữaĐầu tiên mẹ làm á hả?Dạ Đầu tiên mẹ làm làGiống bây giờ mẹ đi lên trên conMẹ ở chừng 5,10 bữa, nửa thángÀMẹ đi chơi,mẹ về ở với con cho đãRồi hết rồi phải không?Rồi bắt đầu cáiỞ nhà đợi con của mẹ hả?Mẹ Nếu mà thì thì nếu mà giả sử đi giả sử mấy cái chuyệnkiểu con nói với mẹkiểu vấn đề này kiaxong hếtrồi khó khăn cũng xong hếtnói chung mẹ không cần phải lo phải nghĩ gì đóthì cái điều đầu tiên mà mẹ nói với conlà mẹ nói cái gì?Điều đầu tiên mẹ muốn nói với conlà con biết mẹ muốn nói gì không?Mẹ cảm ơn conđồng hành với mẹvới batrong lúc gia đình khó khăn,con còn nhỏ, con mới lớn lên,mới có lập nghiệp được mà con không lo cho bản thân của conmà con còn lo ngược lại cho mẹcon chợi mẹ buồn,con lo lắng cho mẹrồi những lúc mà cầm tiền,đồng tiền của congiống như cầm cái đồng tiền của con,nó nặng lắm, con biết khôngnhưng mà con cứ lo cho mẹCon lo cho mẹ,con...con...là...mẹ cảm ơn con là con lớn lên, con không cóphụ lòng ba mẹ mà con locho mẹ, lo cho gia đình trong lúchoàn cảnh như vầy nè,con không có chạy theo những hàm muốn riêng biệtcủa con, con biết không?Mà con lo cho mẹcon bỏ hết những hàm muốntuổi trẻ của con,màcon làm, con dành ***, con gửi tiền vềcho mẹ, lo cho gia đìnhlà cho dù ít nhiều gìCái đành tiền đó nó lớn lao lắm,con hiểu không?Trong khoảng thời gian này nó lớn lao đó với mẹ dữ lắmVà mẹ thấy được giống như mẹ nuôi con mẹ thành công rồi đó, con hiểu không?Dạ,rồi,biết rồiRồi thôi, đợi con trai đi làm nhạc xong rồi con trai kiếm tiền về,con trai dẫn mẹ đi du lịch",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/UocMoCuaMeInterlude-Obito-11836731.mp3?st=NjJ59vePZ2fwG0QyizSNmA&e=1730939939&a=1&p=0&r=d545f1552cd44ea822faed7f314c5eba"),
    Track(
        title: "Con kể Ba nghe",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Ba à, thằng con trai ba\nGiờ cằn cõi khô khốc\nQua nhiều khổ nan\nKhi đôi mắt con nhìn được thấy\nVà thân được nếm độc của hổ mang\nSống trong cái vòng tròn bé tí\nXung quanh nhiều quỷ còn hơn là bạn\nCon vẫn không hiểu tại sao\nNgày xưa khó vậy\nMà ba không thở than\nCon gặp được người phụ nữ\nSẵn sàng yêu con\nDù lắm tài nhiều tật\nVẫn giữ thói quen ba dạy\nNếu trên đời ngột ngạt\nThì tâm niệm phật\nCon chỉ mới 22 tuổi\nMà tuổi còn không nhiều\nNhư tâm sự con mang\nHay đây là cái giá phải trả\nVì con bước ra đời khi còn sớm chán\n18 tuổi con vang danh\nNhiều người bảo là con may mắn\nTrong khi vẫn còn đầy người như con\nNhưng họ không vượt qua được cay đắng\nCon ngẩng đầu được lúc này\nChắc là phước phần của gia đình tặng\nMặc dù thứ con đạt được\nBị người ta cướp hết\nRồi thành tay trắng\nCon giấu đâu cho ba biết\nVì con sợ ba biết ba lo\nDưới quê trăm công nghìn việc\nĐè trên vai ba mà toàn việc khó\nBa nào con nấy ba ơi\nKhông gồng được như ba nên con viết\nBiển đời này bắt con bơi\nĐể được như ba thì con cũng không tiếc\nSức trẻ nên con xa quê\nCô đơn nơi chốn hoa lệ\nNơi mà nếu không thành công\nThì dù tốt đến mấy cũng như thằng hề\nCon phải thoát ra khỏi hẻm\nNơi máu còn tanh bên lề\nNơi mà tụi nó không ngại\nViệc chém thằng khác từ lành đến phế\nCon hay đi ngủ lúc 5 giờ sáng\nDậy lúc 3 giờ chiều\nCó khi giữa đêm giật mình\nVì gặp ác mộng do nghĩ ngợi nhiều\nỐm do ăn không ngon\nChìm trong cảm xúc và phiêu\nNhưng tâm lý con không yếu\nChỉ là con mệt vì quá nhiều điều\nĐang diễn ra xoay xung quanh con\nVới nhiều mặt nạ\nThức tỉnh thêm nhiều con mắt\nĐể con nhìn cho rõ ai đang thật dạ\nCon ít nói đi dần dần đến mức\nNgười đời nghĩ tâm con ma\nCon cũng tách biệt hết mức\nĐể dò lũ ác để con triệt hạ\nNhưng ba ơi cũng nhiều thứ tốt\nMà con nhận ra\nCon có một người phụ nữ\nSẵn sàng ở bên khi con gục ngã\nCon băng qua nhiều cảnh đời\nCàng đi càng học từ mỗi lần qua\nCon bỏ được nhiều thói xấu\nCho dù đứng trước nhiều lời nhục mạ\nVà nhờ ơn gia đình nhà nội\nMà giờ con không vung dao\nChém người ta\nCon thoát khỏi được vòng lặp\nMà mấy thằng anh của con trượt ngã\nCon thoát khỏi kiếp lưu manh\nThoát khỏi cái cảnh gặp gì cũng phá\nThoát khỏi những việc tù tội\nThoát khỏi luôn cảnh không còn nhà\nVà con nghĩ con cũng đủ sức\nĐể giống như ba, để con ráng\nThằng con trai ba không sợ gì\nNếu mà không sai đâu, ba đừng lo\nChâu Long năm con vẫn không quên\nDòng họ Lý con đến từ đó\nChứng kiến được nhiều cảnh từ nhỏ\nChiêm nghiệm thêm và vẫn tiếp tục dò\nChân con vẫn đi mặc kệ sương gió",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/ConKeBaNghe-Obito-11836732.mp3?st=W5NWLS1Dey7U1fiI6zNTbA&e=1730914745&a=1&p=0&r=de5273be10d84991d1c6f083f08c4dde"),
    Track(
        title: "Champion",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            " Thay lớp da non tao lột xác\nThis is a new game\nCầm về túi tiền vài trăm triệu\nTao mua thêm new chain\nMiệng đời tụi mày độc ác\nMặc sức mà thêu lên\nTao đạp đổ hết mọi định kiến\nFeel like I'm Lil Wayne\nLittle homie I'm be outside\nKhi còn trẻ tao hay cãi mẹ\nDù biết là tao sai\nDùng bạo lực để đổi bài học\nSự thơ ngây mau phai\nKhi xung quanh tao toàn là quỷ\nNiềm tin không trao ai\nLàm sao mày có thể hiểu được\nGia phả tao giàu đến mức\nCó thể cho tương lai con mày rẽ ngược\nMỗi ngày đi tìm dây chun\nVào trong kho để buộc tiền tỉ\nNên đừng đem tiền đặt lên bàn\nVì linh hồn tao không thể tiêu huỷ được\nBiến cố ập năm tao 16\nIts *** hurt\nTâm hồn xanh\nCùng với thể xác tao như đã chết\nTiếng mã tấu nó chặt ngoài cửa\nGiờ còn cả vết\nNhững ngày mẹ tao ôm tao khóc\nVì nợ nó đến\nNhưng mà big dawg\nHomie *** it I'm a big dawg\nTao chúc phúc cho những thằng bạn\nĐã khiến tao ít lo\nNăm 18 tao lên Sài Gòn\nSimple love hit to\nNhưng bị quây bởi lũ linh cẩu\nTình thương cũng ít có\nTao đặt nỗi đau vào từng chữ\nNhững ngày nhìn nội già yếu\nThuốc và thuốc phải uống từng cử\nNhững ngày nhìn tóc ba bạc\nKhói thuốc buồn sau cơm từng bữa\nNhững ngày không lo không nghĩ\nCủa đứa trẻ con cũng không còn nữa\nNên tao gánh hết mọi áp lực trên lưng\nTao lướt\nMưa hay gió, đao hay kiếm\nKhông ngăn tao bước\nSẽ đạt hết tất cả những điều\nMà tao ao ước\nChỉ cần thấy gia đình tao cười\nLà coi như phước\nNên mày biết tao khi tiếp xúc\nChứ không nên đọc báo\nChuyện của tao không thằng nào vẽ\nVì nó sẽ hộc máu\nThứ tao trải không phải để khoe\nMà vốn dĩ chỉ để mày hiểu\nNơi tao lớn là ổ tệ nạn\nPhải tìm cách thoát mau\nWoah woah you *** get it\nTao mất đi cỡ vài tỉ\nĐể nhìn cho thấu được ai là tà\nTao mất đi hai năm trời\nĐể tìm con tim này quay về nhà\nVà tao mất đi hết\nTrải nghiệm đẹp của tuổi trẻ\nKhi tao về già\nYeah tao chính là thằng láu cá\nKhi dùng từ ngữ\nNhưng không phải do tao mất dạy\nHay do tao hư\nĐống chất xám này đáng tiền tỉ\nLà vì nó thật\nNếu đặt cược cả mạng mày vào\nMày có *** thử\nSo what, lời nhạc như mưa này\nLà nỗi buồn của tao\nTừng giọt máu, nước mắt\nGiai điệu trong lòng của tao\nKhi đối diện với dao và kiếm\nLiệu mày có thật sự can đảm\nNếu không thì đừng đem vào nhạc\nVì nó không thật với tao\nYoung boy\nMày đừng nói như là mày hiểu về tao\nNếu truyện nghe không do tao kể\nThì nó không đúng về tao\nTao sẽ sống cho đến lúc chết\nTụi mày phải kể về tao\nNhưng mọi vết thương đặt ở bài hát này\nSẽ chấm dứt về sau\nOh God please forgive me for my sins\nSống như là tội phạm\nTay nhúng chàm yeah that’s a thing\nLội ngược dòng nước chảy xiết\nBiến câu truyện này thành cổ tích\nThân xác chằng chịt những vết thương\nBiến đứa trẻ ngông thành nhà vô địch\nBước ra từ đường phố\nTao không cần bằng khen\nYeah I’m the champion\nNhảy số như nhà bank\nKhông làm vì fame\nCảnh giác như là đang đi tuần\nRide with the gang\nNé đi tiền án\nDù phải thêm là bao nhiêu lần\nGiọng thằng này vang\nNăm trôi theo ngày tháng\n*** I'm the champion\nLót vàng trên đường đi\nĐẹp trai trong từng scene\nYeah I’m the champ\nTrị liệu bằng âm nhạc\nThêm nhánh cho ngành y\nBoy I’m the champ\nĐời tao mỗi khác\nKhi nhạc tao release\nYou know I’m the champ\nNhận đau thương mất mát\nNhưng nếu thành tiền tỉ\nYeah you call me a champ\nYeah tao muốn con Rollie\nBốn bánh double R\nYoung ASAP thats what they call me\nBall like superstar\nTao bẻ xích đang mắc ở chân\nChỉ để lại bóng ở trên radar\nĐem cuộc đời tao vào trong nhạc\nNếu mày muốn check tao chấp thêm var\nMiệng tao rap ra lời\nTheo cả nghĩa bóng lẫn nghĩa đen\nMạch tao đập ở trên đất Việt\nNhưng nhạc tao rap là Mỹ Đen\nDouble money count it up\nLàm việc bằng miệng tao chỉ seen\nMichael Jackson khi hành động\nĐi lùi lên đầu moonwalking\nVô cực flow, choppa loaded\nSimple love năm 18\nĐưa tao bay khắp Việt Nam\nRock the motherfucking show\nBán linh hồn, lil homie, that's a no\nVẫn ở đâu đó, get lit with the mob\nLà ngọn lửa của đường phố\nAy you know the code is whut\nYeah CL5 in this *\nVững trên top này không cần gank\nOtđ fly with this kicks\nVali tiền này cho gia đình\nYeah I'm so high in this bitch\nChất thêm lên từng cọc từng cọc\nAin't gonna cap this * lit\n2020 tao chào ngành nhạc\nNhảy từ 0 lên 100\nTụi nó đồn tao mất linh hồn\nOne hit wonder, có gì căng\n2022 lòng đầy sẹo\nTrái tim nóng giờ như là băng\nTao nhìn đời bằng con mắt khác\nXong tiền tao phất lên như trực thăng\nStraight to the top, not gonna stop\nHad to get out the fame and *\nTao thích làm bất động sảng\nHơn là giang hồ trên nhạc\nVì tao biết nó không ra được việc\nThứ mà tao muốn\nTao lấy cho bằng được\nTao rap điều tao trải là thiệt\nTao đem đốt hết đau đớn\nVào trang nhạc mà tao viết xong\nKiếm thêm vài cục tiền legit\nBước ra từ đường phố\nTao không cần bằng khen\nYeah I'm the champion\nNhảy số như nhà bank\nKhông làm vì fame\nCảnh giác như là đang đi tuần\nRide with the gang, né đi tiền án\nDù phải thêm là bao nhiêu lần\nGiọng thằng này vang\nNăm trôi theo ngày tháng\n*** I'm the champion\nLót vàng trên đường đi\nĐẹp trai trong từng scene\nYeah I’m the champ\nTrị liệu bằng âm nhạc\nThêm nhánh cho ngành y\nBoy I'm the champ\nĐời tao mỗi khác\nKhi nhạc tao release\nYou know I'm the champ\nNhận đau thương mất mát\nBiến nó thành tiền tỉ\nYeah you call me a champ",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/Champion-Obito-11836733.mp3?st=ZFqS5Ol3ahQS2T72lX994Q&e=1730941515&a=1&p=0&r=fe6e91e6190d68e3f5cdb1902d30ea81"),
    Track(
        title: "Chưa Xong",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Cuối năm 22 này\nLại tròn thêm một năm\nNâng từ bốn lên thành năm\nKhoảng thời gian tao hành nghề\nQuá nhiều thằng nói\nCó quá nhiều thằng mồm\nTụi mày khua môi múa mép\nBiến từ rapper thành hề\nBiết là cho có\nNhưng có *** đâu mà cho\nThực tại là như thế\nKhi tiệc tan thì đành về\nTao chạy như sắp chết\nĐể lấy tiền lau mồ hôi\nVà thực lực tao phải đủ\nVới những thứ tao cần thề\nMày hỏi tao thoả mãn\nTao chỉ biết là chưa xong\nTao vẫn chưa thấy đích đến\nCủa cái thứ mà tao mê\nTao muốn ăn nhiều hơn\nĐể tài khoản tao được mập\nNhưng đồ thường hay đồ bẩn\nThì nói thẳng là tao chê\nCó thể như du côn\nHay trông như tri thức\nNhưng tất cả thứ tao kiếm\nThì không cần phải sao kê\nKhi nghe mày nói nhiều\nVề mấy thứ mày nói suốt\nMắt tao nhắm đầu tao gật\nNhư kiểu người tao đang phê\nTao chạm được cột mốc\nBa tháng kiếm được một tỉ\nTrộm vía lo được cho nhà\nNhưng mọi thứ vẫn chưa xong\nTao dạy hai thằng em hết mọi thứ\nMà tao biết\nMong hạt mầm tao gieo xuống\nNgày nào đó được đơm bông\nTao ép mình phải lớn\nGiữa rừng người muốn nhỏ lại\nDù cái giá là tâm lý\nTao cũng xem nhẹ nhưng không\nTao kéo cho bằng được\nCả gia đình tao vực dậy\nVà từng bước ra khỏi hood cầu cho chuyện\nNhư tao mong\nSẽ *** có thời gian\nNgồi phân sai hay phân đúng\nVì tao không thể nào\nÉp mấy thằng ngu được như tao\nThu nhỏ lại cái tôi\nTao hạ bản thân xuống\nLắng tai nghe tất cả\nĐể hành động không hư hao\nTao chìm vào suy nghĩ\nÉp não tao vượt lane\nMắt nhìn cho thật rõ\nMấy thằng phông bạt như nhau\nTừng là thằng đầu đường\nHay đi chơi với xã hội\nNay tao sáng\nKhi nhạc bật cảm giác như một ngôi sao\nTao là đứa con lai\nCủa văn hoá ba thành phố\nBa vùng miền\nMấy người giỏi ngồi lại nói cho tao nghe\nTao tự tin đến mức nhiều thằng nghĩ\nTao trượt tuyết\nVì nhìn mũi tao phát tài\nNhưng nói thật tao không care\nTao thấy nhiều cái tâm\nKhông có tâm, không có tầm\nVẫn thích đem sự ngu dốt\nBằng cái miệng phò ra khoe\nTao biết ơn với mọi thứ\nBóng dáng người phụ nữ\nVòng xoay những người tốt đến và đi\nĐiều nên nghe\nĐừng hỏi tao xong chưa\nMọi thứ vẫn chưa xong\nXong sao được\nKhi cuộc vui\nNó còn chưa được bắt đầu\nTao nhảy đến hết số, phi đến hết ga\nĐến lấy thêm nhiều cọc\nĐể chuyện sai còn đắp vào\nTao cho tụi mày đếm\nSố lần tao trượt chân\nNếu tụi mày vui\nThì là phước tao cho không\nCòn nếu tụi mày hỏi\nLà khi nào tao chết\nCâu trả lời vẫn vậy\nNói tóm gọn là chưa xong\nCách sống và thái độ\nTao cư xử như nhà vua\nVì tao biết khi sinh ra\nNgai vàng vốn dành cho tao\nNên nếu tao có chết\nThì cái chết do tao chọn\nTao chọn ngã trên chiến thắng\nVà yên nghỉ ở trên cao\nMua hết thứ tao thích\nĐổ tiền vào kim cương\nViệc nào đang còn chậm\nThì quăng thêm vào cho mau\nTao chọn một cuộc đời\nPhải làm vua của mọi thứ\nNên cái giá dù có chát\nThì là cũng dành cho tao\nĐóng thêm hơi khói\nKhông sợ nói trên đường đi\nLuôn luôn ghi nhớ\nTừng giọt trên hàng mi\nNói miết không ra gì\nVậy thì nói để làm chi\nNhiều tiền nhiều vấn đề\nThì đưa vấn đề thêm đi\nTao bị chá bởi ánh sáng của tương lai\nCộng thêm hiệu ứng kim cương quá nặng\nMà hai tai tao đang đeo\nTao cũng không đợi mưa\nĐể được nhìn thấy cầu vồng\nVì cầu vồng tao rực sáng\nVà lúc nào cũng mang theo\nTao quý trọng thời gian\nVà quyết định phải thay đổi\nVì nhìn thấy nhiều thằng anh\nChìm vào tội rồi mang neo\nTao cũng thấy đủ chuyện\nĐể bản thân tao đủ biết là\nCuộc đời này màu đục\nCòn nhiều hơn màu trong veo\n2012 tao vẫn lang thang trong xóm\nXác của tệ nạn chất thành đống vì do keo\n2022 tao moonwalk trên âm nhạc\nTrở thành thằng tỉ phú trẻ\nVới đống sẹo mà tao đeo\n2018 tao bắt đầu viết nhạc\nVẫn yêu thương cuộc đời\nDù đời này thích phạt\n2020 đưa lưng ra dính đạn\nCứng và vẫn vững\nChịu đựng để hốt bạc\nNếu mà đề xuất chuyện làm ăn\nMà biết mày phông bạt\nThì tao như bị câm\nGiữ tim tao lạnh như là băng\nTất cả những hơi ấm\nChỉ dành riêng cho người thân\nĐơn giản thì không phải làm căng\nKỹ năng và kinh tế\nVẫn tăng thêm phần trăm\nChất xám tao toả ra mùi tiền\nMặt lạnh như là đá\nNhưng là đá trong nhà băng\nTurn it up, *** it up, pick it up\nXong việc thì xách lên và đi\nThêm một show\nThêm một cọc thêm bọc\nLấy hết rồi nhét vào vali\nKhông khí nóng bừng như El Classico\nNhiều thằng nói tao không làm được\nNow I finished them\nChín con số một verse, thats a minimum\nMấy em muốn làm phiền\nMơ tiếp đi cưng\nCó mấy thằng anh\nXưa tao hết mực yêu thương\nSẵn sàng xuống tay\nMiễn là tụi nó có tiền\nHỏi thì thằng nào\nCũng sợ chết gặp Diêm Vương\nNhưng tay nó dính máu\nChỉ để đổi lại chút quyền\nMong cho tụi nó\nTìm cuộc đời ở trang khác\nHiểu được sự quan trọng\nCủa lúc giận và lúc hiền\nNâng tầm ảnh hưởng\nBằng những thứ tao đang rap\nShiki gửi beat trap\nTao check phát là xúc liền\nTóm lại là vẫn là chưa xong\nTất cả mọi thứ vẫn chưa xong\nTóm lại là vẫn là chưa xong\nTất cả mọi thứ vẫn chưa xong\nTóm lại là vẫn là chưa xong\nTất cả mọi thứ vẫn chưa xong\nTóm lại là vẫn là chưa xong\nTất cả mọi thứ vẫn chưa xong\n2018 tao bắt đầu viết nhạc\nVẫn yêu thương cuộc đời\nDù đời này thích phạt\nThương tích nếu có\nQuăng tao miếng gạc\nRap cho đến lúc\nPhổi tao không còn biết ngạt\nThis * aint easy\n2022 vẫn đang nhảy trên tiếng nhạc\nVẫn đang chạy tốt\nMỗi ngày đều hốt bạc\nVẫn đang dõng dạc đang rap\nVẫn đang dõng dạc đang rap\nVẫn đang dõng dạc đang rap\nVẫn đang dõng dạc đang rap",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/ChuaXong-Obito-11836734.mp3?st=m5Ly-YAX39vBPrV1LVkPUA&e=1730941521&a=1&p=0&r=c85d81fbda4e91f9bd177ddaec678af5"),
    Track(
        title: "Tự sự",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Tao đang đi sâu vào cõi tâm trí\nTự sự với bản thân tao\nXem dòng thời gian biến tao thành gì\nBiết nhiều điều nhưng tao không nói\nKhông để tà trong tâm nên thói\nĐặt bàn tay lên giữa lồng ngực\nSiết chặt nó vào để không quên lối\nCảm giác như linh hồn của tao\nĐang phải cầm cố cho nơi ánh sáng\nĐứng trước khán giả tao cười\nDù lệ đang đổ sau ánh hào quang\nDamn ***\nBầu trời tao giờ hiếm khi màu xanh\nSài Gòn chỉ có nắng và mưa\nTao ngồi trong nhà\nNhưng sao lòng vẫn lạnh\nHay là có một thế giới chỉ em và anh\nXung quanh rất nhiều cám dỗ\nNhưng tim này vẫn y nguyên lòng thành\nNếu gặp em ở đời sau\nAnh vẫn sẽ trao trái tim màu trắng\nGirl I love you to my end\nEm là vì sao mà anh được tặng\nTao cũng không rõ tao dữ hay lành\nChỉ là khu tao từng sống\nMuốn tồn tại thì cần phải lanh\nBên trong tao đau\nNhư ai đang cắt của tao đi từng thớ thịt\nBước đi lòng như mảnh lưới rách\nCùng những vết thương\nChưa được chữ lành\nĐêm giông tới khi mắt tao thấy\nTừng lần nội tao nằm viện\nCơ thể ngày một đi càng gầy\nTao thấy tóc ba mẹ tao bạc\nKhó khăn việc thì ngày một đầy\nTao không còn cách nào khác\nNgoài chọn đứng lên tiếp tục từng ngày\nTao cũng biết buồn biết đau như ai\nTao cũng có lúc mất đi\nSự tự tin đôi khi như ai\nTao cũng nhiều lần\nKhông tin vào con đường đang đi như ai\nVà cũng nhiều lần phải khóc\nNhưng không cho ai thấy tao đau như ai\nNhiều đứa vẫn nghĩ làm nghề này dễ\nMày múa fame bẩn trên mạng\nBiến tâm hồn mày thành trò hề\nMày thích là được là tâm điểm\nNhưng không chịu được những lời chê\nĐặt đống phân lên lời mày nói\nMà miệng bày đặt hay thốt và thề\nTrách nhiệm đưa nhà đi ra khỏi hẻm\nBản thân sẵn sàng đánh đổi\nNhững thứ hàng trăm người khát và thèm\nThoát khỏi nơi mũi kim đầy phố\nMáu và lệ xen kẽ đầy đồ\nThoát khỏi nơi mà những con ngõ\nLà chỗ để chạy khi hình sự ập vô\nĐôi khi tao ước được quay ngược lại\nKhông phải để được sửa lỗi\nQuá khứ cứ để đó những việc sai\nQuay lại để tao được sống\nTrong những cảm giác khi tao tự tại\nVì trên đời có những cảm xúc\nTao muốn được trải qua nó lần hai\nĐến đây tự sự chắc cũng phải kết\nTrở về lại với thực tại\nVẫn không cho phép bản thân biết mệt\nNgười duy nhất ngăn được tao\nChắc có lẽ chỉ mỗi thần chết\nWish myself with all the best\nAll the bless in this *** like",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/TuSu-Obito-11836735.mp3?st=EM8VbPPC3-lSPyY6XSMEBQ&e=1730936648&a=1&p=0&r=a8958b686d6b6a614146e859a819182e"),
    Track(
        title: "Outro",
        artist: Artist.defaultArtist(),
        album: Album.defaultAlbum(),
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics: "",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/Outro-Obito-11836736.mp3?st=EwkFVlqkJEjnEIF8Mg-Jsw&e=1730941531&a=1&p=0&r=2032318f2fc5f8b5e72b1a42dac3145f"),
  ];

  static List<String> chrismastPlaylistImg = [
    "https://assets.editorial.aetnd.com/uploads/2009/10/christmas-trees-gettyimages-1072744106.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFc9Sg5PxoxYxi-VIQfA6UU58Kr_T9Ekv0qg&s",
    "https://www.shutterstock.com/image-photo/beautiful-christmas-holiday-frame-tree-600nw-2381173013.jpg",
  ];

  static List<String> newYearPlaylistImg = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw6juTTwcRX498vxuvlxk6OtYndwdCjVwrzSJj5cEnzmEyfjjtsgi8wLAKdvFwHBR8Lr8&usqp=CAU",
    "https://img.freepik.com/free-vector/flat-new-year-s-eve-celebration-illustration_23-2149853861.jpg",
    "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/a8e59f47383181.5f80a5fa5dc72.jpg",
  ];

  static List<Genres> moodList = [
    Genres(name: "Happy", imgURL: "https://example.com/happy.jpg"),
    Genres(name: "Sad", imgURL: "https://example.com/sad.jpg"),
    Genres(name: "Angry", imgURL: "https://example.com/angry.jpg"),
    Genres(name: "Focus", imgURL: "https://example.com/focus.jpg"),
    Genres(name: "Chill", imgURL: "https://example.com/chill.jpg"),
    Genres(name: "Relax", imgURL: "https://example.com/relax.jpg"),
    Genres(name: "Workout", imgURL: "https://example.com/workout.jpg"),
    Genres(name: "Study", imgURL: "https://example.com/study.jpg"),
    Genres(name: "Party", imgURL: "https://example.com/party.jpg"),
    Genres(name: "Sleep", imgURL: "https://example.com/sleep.jpg"),
    Genres(name: "Work", imgURL: "https://example.com/work.jpg")
  ];

  static List<String> locationList = [
    "Global",
    "VietNam",
    "Canada",
    "Australia",
    "France",
    "Gremany",
    "Japan",
    "Korea",
    "China",
    "Russia",
    "Brazil",
    "India",
    "Italy",
    "Spain",
    "Mexico"
  ];
  static List<Map<String, String>> locationImages = [
    {
      "location": "New York",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmUhi0s72FfDSznKL39WrbN3VW6sr31F27zw&s"
    },
    {
      "location": "Can Tho",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIcLaH_ZFE8kG9VVDBdm3-r0CH2t8WvLgYpg&s"
    },
    {
      "location": "Los Angeles",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRW6srZopstrWRUc-pxrEZ_x7pSF7ydd2aAdg&s"
    },
    {
      "location": "Houston",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7uVn9qmYCa967nuUo6PUfARVECZanqazemw&s",
    },
    {
      "location": "Phoenix",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNqIE45c3XRwsEzpcswNwJy7yhZDseTCv5IA&s",
    },
    {
      "location": "London",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNLhqqEOOBzvZ44xKRuDR_bVEtpsMLWGh78Q&s",
    },
    {
      "location": "Birmingham",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRRUa9zhSNLH3ulQ7QJBpfjDbMfwYeSrxYdQ&s",
    },
    {
      "location": "Ha Noi",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMi91oQxfjS7xU5gHFszaqRmM4eyYNKpN8Sg&s",
    },
    {
      "location": "Ho Chi Minh",
      "imageURL":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdFxSCeRP_GVEn6nNG7uc09oSInbOK54aMng&s",
    },
  ];
  static List<RadioStation> radioList = [
    RadioStation(
        name: "Music 1",
        image:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUmoCjYlwBy4UahDRUDth5yAW0ibgspq4ddA&s",
        description: "Tommorow's hits today"),
    RadioStation(
        name: "Music Country",
        image:
            "https://www.apple.com/newsroom/images/product/apple-music/Apple_announces-apple-music-radio-country_08182020_inline.jpg.large.jpg",
        description: "Defining the country"),
    RadioStation(
        name: "Centery Hits",
        image:
            "https://www.apple.com/newsroom/images/product/apple-music/Apple_announces-apple-music-hits_08182020_inline.jpg.large.jpg",
        description: "Hits that change world"),
  ];
  static List<Artist> artists = [
    Artist(
        name: "Adele",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrH7labPAP-FcsZQFXpdeXF_BRrYluKuKd4w&s"),
    Artist(
        name: "Beyoncé",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRG-ZLHpsb5TY_hTBkj-kof4swZ-g9fUS_Psj8M_4Pgs-R3_Cp9"),
    Artist(
        name: "Drake",
        avatarURL:
            "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQaooHw3BvR2onHwzNNugmr5cw0R5PE2XsGauTbxW_pJS9U7AGL"),
    Artist(
        name: "Ed Sheeran",
        avatarURL:
            "https://yt3.googleusercontent.com/emA0C_i9tUyJgxrfVpJ31e0QCU2MlovjYvQkAC9mDuSJyhl6h8PkFj5-ozRzz2vFtpbnls8s1W4=s900-c-k-c0x00ffffff-no-rj"),
    Artist(
        name: "Taylor Swift",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Taylor_Swift_at_the_2023_MTV_Video_Music_Awards_4.png/1200px-Taylor_Swift_at_the_2023_MTV_Video_Music_Awards_4.png"),
    Artist(
        name: "Ariana Grande",
        avatarURL:
            "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSXEVN2qNzKweNSH_usXSeD4cU4k7DEtzLz7PVkLbNRPqiACcXS"),
    Artist(
        name: "Justin Bieber",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Billie Eilish",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQz8E9WhB8gnifg712l-GWMPD9r1nZ-x3I2zzL598TbwbGccdYgnOK4i9IuEaRCovPFYW8&usqp=CAU"),
  ];

  static List<Genres> genres = [
    Genres(
        name: "Pop",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Pop_music.svg/1200px-Pop_music.svg.png"),
    Genres(
        name: "Rock",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Electric_Guitar.png/1024px-Electric_Guitar.png"),
    Genres(
        name: "Hip Hop",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Hip-hop_turntables.jpg/1024px-Hip-hop_turntables.jpg"),
    Genres(
        name: "Jazz",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Jazz_musicians_in_New_York.jpg/1024px-Jazz_musicians_in_New_York.jpg"),
    Genres(
        name: "Classical",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Ludwig_van_Beethoven.jpg/800px-Ludwig_van_Beethoven.jpg"),
    Genres(
        name: "Country",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Country_music_legend.jpg/1024px-Country_music_legend.jpg"),
    Genres(
        name: "Electronic",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/Electronic_dance_music_festival.jpg/1024px-Electronic_dance_music_festival.jpg"),
    Genres(
        name: "Reggae",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Reggae_Artist_Performance.jpg/1024px-Reggae_Artist_Performance.jpg"),
    Genres(
        name: "Blues",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Blues_Singer.jpg/1024px-Blues_Singer.jpg"),
    Genres(
        name: "Metal",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Heavy_metal_performance.jpg/1024px-Heavy_metal_performance.jpg"),
    Genres(
        name: "Folk",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Folk_Music_Concert.jpg/1024px-Folk_Music_Concert.jpg"),
    Genres(
        name: "R&B",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/R%26B_Singer_2015.jpg/1024px-R%26B_Singer_2015.jpg"),
  ];

  List<String> paymentMethodImage = [
    "https://e7.pngegg.com/pngimages/530/165/png-clipart-logo-mastercard-pentagram-flat-design-brand-mastercard-text-trademark.png",
    "https://e7.pngegg.com/pngimages/618/512/png-clipart-visa-logo-mastercard-credit-card-payment-visa-blue-company.png",
    "https://cdn.prod.website-files.com/62b0e6308cc691625470b227/62dec0259f18b71442a15966_Apple-Logo.png"
  ];
  List<String> hiphopAlbumCover = [
    "https://images.prismic.io/rockthebells/524e2d10-3015-4098-b2a9-83de5cf70ee4_67ce3bba.jpg.webp?auto=compress,format",
    "https://townsquare.media/site/812/files/2023/03/attachment-astroworld.jpg?w=780&q=75",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSorV9huTZhlL6gztB4lF6o0WMu_STgaujjxg&s"
  ];

  List<String> popAlbumCover = [
    "https://www.billboard.com/wp-content/uploads/media/tyler-the-creator-igor-album-art-2019-billboard-embed.jpg?w=600",
    "https://www.bykerwin.com/wp-content/uploads/2022/09/Rolling-Stones-final-2022-BC.jpg",
    "https://i.cbc.ca/1.4678126.1527269930!/fileImage/httpImage/image.jpg_gen/derivatives/original_780/shawn-mendes.jpg"
  ];

  List<String> rbAlbumCover = [
    "https://www.revolt.tv/article/2024-02-18/351387/media_191666d5e27043a84a767bb6679f9d23e4f77cd98.jpeg?width=1200&format=pjpg&optimize=medium",
    "https://cdn.awsli.com.br/2197/2197610/produto/188239463/b356e4c654.jpg",
    "https://www.vibe.com/wp-content/uploads/2015/01/MCM3.jpg",
  ];

  List<String> rockAlbumCover = [
    "https://indieground.net/wp-content/uploads/2013/06/indieblog-best-album-covers-90s-11-1024x1024.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaELmha0Aaj78SsIUeNJOyCIPBdR5C1w_M9g&s",
    "https://www.billboard.com/wp-content/uploads/2022/03/35.-Metallica-%E2%80%98Master-of-Puppets-1986-album-art-billboard-1240.jpg?w=600"
  ];

  static List<Album> albums = [
    Album(
        title: "The Wrxdies",
        aritst: Artist.defaultArtist(),
        genre: genres[2],
        releaseDate: "2024",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2024/11/12/b/e/7/0/1731385118149_500.jpg",
        tracks: wrxdieSong),
    Album(
        title: "Đánh đổi",
        aritst: Artist.defaultArtist(),
        genre: genres[2],
        releaseDate: "2023",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        tracks: obitoSongs),
    Album(
        title: "Lemonade",
        aritst: Artist.defaultArtist(),
        genre: genres[2],
        releaseDate: "2016-04-23",
        imgURL:
            "https://aimm.edu/hubfs/Blog%20Images/Top%2010%20Album%20Covers%20of%202017/Tyler%20the%20Creator-%20Flower%20boy.jpg",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "Scorpion",
        aritst: Artist.defaultArtist(),
        genre: genres[2],
        releaseDate: "2018-06-29",
        imgURL:
            "https://images.theconversation.com/files/512871/original/file-20230301-26-ryosag.jpg?ixlib=rb-4.1.0&rect=97%2C79%2C5799%2C5817&q=45&auto=format&w=926&fit=clip",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "Divide",
        aritst: Artist.defaultArtist(),
        genre: genres[0],
        releaseDate: "2017-03-03",
        imgURL:
            "https://www.billboard.com/wp-content/uploads/2023/07/SZA-SOS-album-art-billboard-1240.jpg?w=800",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "1989",
        aritst: Artist.defaultArtist(),
        genre: genres[0],
        releaseDate: "2014-10-27",
        imgURL:
            "https://images.prismic.io/milanote/df7eeb83a07162b45ac2e882cac055de9411054a_cover.jpg?auto=compress,format",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "Thank U, Next",
        aritst: Artist.defaultArtist(),
        genre: genres[0],
        releaseDate: "2019-02-08",
        imgURL:
            "https://aimm.edu/hubfs/Blog%20Images/Top%2010%20Album%20Covers%20of%202017/Tyler%20the%20Creator-%20Flower%20boy.jpg",
        tracks: [] // Add songs specific to this album
        ),
    Album(
        title: "Purpose",
        aritst: Artist.defaultArtist(),
        genre: genres[0],
        releaseDate: "2015-11-13",
        imgURL:
            "https://aimm.edu/hubfs/Blog%20Images/Top%2010%20Album%20Covers%20of%202017/Tyler%20the%20Creator-%20Flower%20boy.jpg",
        tracks: [] // Add songs specific to this album
        ),
  ];
}
