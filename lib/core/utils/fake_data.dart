import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/app_user.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/genres.dart';
import 'package:sound_sphere/data/models/radio.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/data/models/album.dart';

class FakeData {
  static AppUser user = AppUser(
    name: "Nguyen Dat Khuong",
    password: "1123",
    email: "zzkhngzz@gmail.com",
    avatarURL:
        "https://yt3.googleusercontent.com/oN0p3-PD3HUzn2KbMm4fVhvRrKtJhodGlwocI184BBSpybcQIphSeh3Z0i7WBgTq7e12yKxb=s900-c-k-c0x00ffffff-no-rj",
  );

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
            "https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTEmdTlNfy_dGHXAFlym5Fq7fWfh7m0SpTtySCotHDpl12Aeh4j"),
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
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Billie_Eilish_2019_MTV_International_Press_Photo_by_Matty_Vogel.jpg/800px-Billie_Eilish_2019_MTV_International_Press_Photo_by_Matty_Vogel.jpg"),
    Artist(
        name: "The Weeknd",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/The_Weeknd_in_2018.png/800px-The_Weeknd_in_2018.png"),
    Artist(
        name: "Post Malone",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Post_Malone_Stavernfestivalen_2018_%28cropped%29.jpg/800px-Post_Malone_Stavernfestivalen_2018_%28cropped%29.jpg"),
    Artist(
        name: "Lady Gaga",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Lady_Gaga_interview_2016.jpg/800px-Lady_Gaga_interview_2016.jpg"),
    Artist(
        name: "Katy Perry",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Katy_Perry_in_2019.jpg/800px-Katy_Perry_in_2019.jpg"),
    Artist(
        name: "Bruno Mars",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Bruno_Mars_24K_Magic_World_Tour_%28cropped%29.jpg/800px-Bruno_Mars_24K_Magic_World_Tour_%28cropped%29.jpg"),
    Artist(
        name: "Rihanna",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Rihanna_Fenty_2018.png/800px-Rihanna_Fenty_2018.png"),
    Artist(
        name: "Shawn Mendes",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Shawn_Mendes_in_2019.jpg/800px-Shawn_Mendes_in_2019.jpg"),
    Artist(
        name: "Selena Gomez",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Selena_Gomez_in_2020.jpg/800px-Selena_Gomez_in_2020.jpg"),
    Artist(
        name: "Dua Lipa",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Dua_Lipa_in_2020.png/800px-Dua_Lipa_in_2020.png"),
    Artist(
        name: "Harry Styles",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Harry_Styles_in_2020.jpg/800px-Harry_Styles_in_2020.jpg"),
    Artist(
        name: "Miley Cyrus",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Miley_Cyrus_in_2019.jpg/800px-Miley_Cyrus_in_2019.jpg"),
    Artist(
        name: "Sam Smith",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Sam_Smith_Lollapalooza_2015.jpg/800px-Sam_Smith_Lollapalooza_2015.jpg"),
    Artist(
        name: "Lizzo",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Lizzo_SXSW_2017_%28cropped%29.jpg/800px-Lizzo_SXSW_2017_%28cropped%29.jpg"),
    Artist(
        name: "Kendrick Lamar",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Kendrick_Lamar_Wiki.jpg/800px-Kendrick_Lamar_Wiki.jpg"),
    Artist(
        name: "Cardi B",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Cardi_B_%40_The_Shrine_%2830283517807%29.jpg/800px-Cardi_B_%40_The_Shrine_%2830283517807%29.jpg"),
    Artist(
        name: "Doja Cat",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Doja_Cat_2.jpg/800px-Doja_Cat_2.jpg"),
    Artist(
        name: "Lil Nas X",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Lil_Nas_X_2019_by_Glenn_Francis.jpg/800px-Lil_Nas_X_2019_by_Glenn_Francis.jpg"),
    Artist(
        name: "Olivia Rodrigo",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Olivia_Rodrigo_performing_in_2021.jpg/800px-Olivia_Rodrigo_performing_in_2021.jpg"),
    Artist(
        name: "Travis Scott",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Travis_Scott_-_Openair_Frauenfeld_2019_11.jpg/800px-Travis_Scott_-_Openair_Frauenfeld_2019_11.jpg"),
    Artist(
        name: "J Balvin",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/J_Balvin_en_2019.jpg/800px-J_Balvin_en_2019.jpg"),
    Artist(
        name: "Bad Bunny",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Bad_Bunny_2019_by_Glenn_Francis.jpg/800px-Bad_Bunny_2019_by_Glenn_Francis.jpg"),
    Artist(
        name: "Anitta",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Anitta%2C_2018.jpg/800px-Anitta%2C_2018.jpg"),
    Artist(
        name: "Sia",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Sia_at_ACL_Music_Festival_2016.jpg/800px-Sia_at_ACL_Music_Festival_2016.jpg"),
    Artist(
        name: "The Chainsmokers",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/The_Chainsmokers_Vega_2016.jpg/800px-The_Chainsmokers_Vega_2016.jpg"),
    Artist(
        name: "Zayn Malik",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Zayn_Malik_Paris_Fashion_Week_Autumn_Winter_2020.jpg/800px-Zayn_Malik_Paris_Fashion_Week_Autumn_Winter_2020.jpg"),
    Artist(
        name: "Lana Del Rey",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Lana_Del_Rey_2017.png/800px-Lana_Del_Rey_2017.png"),
    Artist(
        name: "Halsey",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Halsey_performing_in_2019_%28cropped%29.jpg/800px-Halsey_performing_in_2019_%28cropped%29.jpg"),
    Artist(
        name: "Khalid",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Khalid_2017.jpg/800px-Khalid_2017.jpg"),
    Artist(
        name: "G-Eazy",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/G-Eazy_2015.JPG/800px-G-Eazy_2015.JPG"),
    Artist(
        name: "Normani",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Normani_performing_2017.jpg/800px-Normani_performing_2017.jpg"),
    Artist(
        name: "Camila Cabello",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Camila_Cabello_Jingle_Ball_2019.jpg/800px-Camila_Cabello_Jingle_Ball_2019.jpg"),
    Artist(
        name: "Charlie Puth",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Charlie_Puth_2017.jpg/800px-Charlie_Puth_2017.jpg"),
    Artist(
        name: "John Legend",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/John_Legend_2019_by_Glenn_Francis.jpg/800px-John_Legend_2019_by_Glenn_Francis.jpg"),
    Artist(
        name: "Lorde",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Lorde_Melodrama_World_Tour_in_Lucca_2018.jpg/800px-Lorde_Melodrama_World_Tour_in_Lucca_2018.jpg"),
    Artist(
        name: "BTS",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/BTS_at_the_2019_Billboard_Music_Awards_02.png/800px-BTS_at_the_2019_Billboard_Music_Awards_02.png"),
    Artist(
        name: "BLACKPINK",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/BLACKPINK_in_your_area_concert_in_Taiwan_%28cropped%29.jpg/800px-BLACKPINK_in_your_area_concert_in_Taiwan_%28cropped%29.jpg"),
    Artist(
        name: "Kanye West",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Kanye_West_at_the_Met_Gala_in_2019.jpg/800px-Kanye_West_at_the_Met_Gala_in_2019.jpg"),
    Artist(
        name: "Eminem",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Eminem_at_SeriesFest_%28cropped%29.jpg/800px-Eminem_at_SeriesFest_%28cropped%29.jpg"),
    Artist(
        name: "Rita Ora",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/Rita_Ora_performing_in_Los_Angeles_in_2018.jpg/800px-Rita_Ora_performing_in_Los_Angeles_in_2018.jpg"),
    Artist(
        name: "P!nk",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Pink_2019_by_Glenn_Francis.jpg/800px-Pink_2019_by_Glenn_Francis.jpg"),
    Artist(
        name: "Nicki Minaj",
        avatarURL:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Nicki_Minaj_2013.jpg/800px-Nicki_Minaj_2013.jpg"),
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
  static List<Song> songs = [
    Song(
        title: "Đầu đường xó chợ",
        artistName: "Obito, Lăng LD",
        albumName: "Đánh đổi",
        duration: "3:41",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Gọi thằng anh để tránh cái án\nTrong xóm tao hỏi mày đang đâu\nTiếng canh sòng ở bên đường đắp\nGấp gáp trả lời là đang xâu\nCó thằng anh thì chấp hành tốt\nRa sớm nói chuyện như Đen Vâu\nTrên bàn nhậu nó kể\nHồi đó chỉ vì vài ánh nhìn\nMà bem nhau\nCó thằng kiếm cơm bằng xe đai\nLang thang nơi biên giới dù đêm thâu\nCó thằng mất đi anh chị em\nCần bia và rượu để quên đau\nTao lớn lên từ đường hẻm\nNơi không dễ dàng để tin nhau\nTao biết hết ngõ ngách tầng lớp thấp\nNơi không ai muốn vào thêm sâu\nMấy thằng trẻ còn chưa đầy hai mươi\nNhưng số vết nó chém\nNhiều hơn số tuổi\nMục tiêu chạy vệt đỏ còn đang tươi\nNhưng cái tôi lớn kêu nó cố đuổi\nMắt nó trừng như thể trời gầm\nDù nhà thờ Đức Mẹ Quan Âm\nDùng bạo lực để tạo ra luật\nQuyền lực là thứ mà nó quan tâm\nĐời tẩy chay vì nó dính án\nĐối với tao tụi nó là bạn\nTao thấy được lí do nó làm\nĐằng sau câu truyện mà nó dính dáng\nXưa nó vẫn cùng tao đến trường\nThầy cô khen tương lai nó sáng\nNhưng tất cả mọi thứ thay đổi\nChỉ vì một lần nó đeo khăn tang\nThằng tốt tính nhưng ba mẹ mất sớm\nVì chất kích thích nên phải vào đời\nThằng thì anh em ngã xuống\nVì dao kiếm\nHận thù nên lao đầu vào cuộc chơi\nThằng bị ăn hiếp ám ảnh từ nhỏ\nNên thích vung đấm\nĐể không thành trò cười\nThằng thì đỏ đen, bán gia bại sản\nCha mẹ từ mặt nên thành bụi đời\nThằng thì tâm lý tan nát vì tội\nMỗi đêm dằn vặt đọc kinh xám hối\nThằng thì vẫn chưa nhìn thấy được ngày ra\nVì một phút bốc đồng\nĐể cảm xúc lên ngôi\nThằng thì vốn không còn lựa chọn nào\nĐành bước chân vào để được tồn tại\nThằng thì chỉ mong\nTìm lại được yên bình\nNhư những ngày bé để không chọn sai\nGọi thằng anh để tránh cái án\nTrong xóm tao hỏi mày đang đâu\nTiếng canh sòng ở bên đường đắp\nGấp gáp trả lời là đang xâu\nCó thằng anh thì chấp hành tốt\nRa sớm nói chuyện như Đen Vâu\nTrên bàn nhậu nó kể\nHồi đó chỉ vì vài ánh nhìn\nMà bem nhau\nCó thằng kiếm cơm bằng xe đai\nLang thang nơi biên giới dù đêm thâu\nCó thằng mất đi anh chị em\nCần bia và rượu để quên đau\nTao lớn lên từ đường hẻm\nNơi không dễ dàng để tin nhau\nTao biết hết ngõ ngách tầng lớp thấp\nNơi không ai muốn vào thêm sâu\nThằng thì đi tắm sông chung bầy\nSẩy chân té vào tay người âm\nThằng hưởng dương trong khuôn viên trường\nNên nó sống mãi tuổi 15\nThằng bước ra sau phiên phúc thẩm\nChỉ cười rồi nói là thua rồi\nThằng có tiền còn sống không thọ\nThì thằng thiếu thốn thường đua đòi\nĐất chật người ngông\nCha nó lấy bạo lực làm nôi\nNên nó không thích sống kiếp làm công\nHai chữ gia đình sẻ làm đôi\nNó bỏ nhà đi bụi đời\nRa đường làm con tốt\nHay ra đường để làm con tốt\nThí cặp mắt này mù vì\nDù gì sống đách cần nhìn trước sau\nNó chưa từng có ước ao\nNgoài việc thoát khỏi bản chất\nCủa một thằng ù lì\nĐiểm cuối cuộc đời hên xui\nNhư chơi oẳn tù xì\nCái bo cũng chỉ để gõ\nNếu ở đó nó được gọi là cô nhi\nNên lánh nhanh\nTrước khi đột ngột qua đời\nNó không định đánh anh đâu\nMà là tới cắt nhượng\nMóc ruột lột da\nAnh liều một pha\nCho má có vốn mở sạp bán bánh canh\nRồi ra đầu thú theo lệnh\nTheo lệnh triệu tập của 113",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/DauDuongXoCho-Obito-11836720.mp3?st=UZXn7SFNYKW6jLCrvHdH2w&e=1730940483&a=1&p=0&r=4a25d3ccf74387bf4ec1dd6aba4d0e1c"),
    Song(
        title: "Biên Giới Long Bình",
        artistName: "Obito",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Xe đai đang lăn bánh\nHướng thẳng về phía biên giới Long Bình\nTay nó vặn hết số với tiếng nẹt bô\nQua nhiều công trình\nĐồ phạm pháp sau lưng xe\nNên đường lui nó quyết không nhìn\nTốc độ nó đang đi\nĐủ có thể đưa nó lên khung hình\nLỡ đụng ai chết nó cũng mặc kệ\nVì lời khuyên trong nghề toàn thế\nThà là không ai nhìn thấy nó\nCòn hơn là không còn thấy đường về\nĐặt mạng sống lên trên bàn cân\nVì chỉ mong cho nhà cửa không đói\nTâm cắn rứt thì cũng phải cam\nNó trách sao đời đối xử nó tệ\nNó sẵn sàng cho kẹo đồng bay\nKhi giao dịch bị sai chi tiết\nSẵn sàng xuống tay hạ thằng khác\nNếu đó là cách để nó đi tiếp\nNếu là cách để nhà nó no\nKéo một khói thật to khi siết\nVới người thân nó là người tốt\nCòn với mày là một sự uy hiếp\nChấp nhận để thân dính mùi tanh\nĐể nhà ngửi mùi trong lành\nKhí nó toát ra mặt lạnh tanh\nKhi cuộc đời nó không thành\nNó là thứ gia đình mày sợ\nKhi đồng hồ báo là đêm về khuya\nNó là đứa con ngoan của quỷ\nKhi bị đời cho ra rìa\nDon't let them run though\nĐừng để nó chạy\nLỡ lại khổ ai thành nạn nhân\nDon't let them run, don't let them run\nDon't let them run\nLại thêm một vụ\nThêm một vụ, thêm một vụ\nDon't let them run though\nĐừng để nó chạy\nLỡ lại khổ ai thành nạn nhân\nDon't let them run, don't let them run\nDon't let them run\nLại thêm một vụ, thêm một vụ\nThêm một vụ nó gây ra\nGiác quan nhạy trong màn đêm\nKĩ thuật như là game\nSố vết thương cộng thêm\nTâm lý nguyên màu đen\nNgửi được sự nguy hiểm\nHành tung như là phim\nCoi nó như thằng điên\nThằng bé chỉ muốn được yên\nNó không muốn\nNó được sinh ra trên cõi đời này\nĐể trở thành xấu\nNó hối hận vì sự lựa chọn\nĐể làm việc sai của nó lần đầu\nGiày xéo chính bản thân vì tội\nNó gây đau thương cho bao người khác\nNhưng quá trễ trở thành cụm từ\nMà nó nhớ mãi như một bài nhạc\nNó ước được chọn, ước được chọn\nƯớc được chọn lại\nKhác cuộc đời, khác hoàn cảnh\nKhác cả thực tại\nKhác suy nghĩ, khác hành động\nKhác những lần dại\nNhưng nó phải đền tội trong hôm nay\nVì cuộc sống không ưu ái một ai\nDon't let them run though\nĐừng để nó chạy\nLỡ lại khổ ai thành nạn nhân\nDon't let them run, don't let them run\nDon't let them run\nLại thêm một thằng, thêm một thằng\nDont let them run though\nĐừng để nó chạy\nLỡ lại khổ ai thành nạn nhân\nDon't let them run, don't let them run\nDon't let them run\nLại thêm một thằng, thêm một thằng\nThêm một thằng được sinh ra",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/BienGioiLongBinh-Obito-11836721.mp3?st=JU3Tz_zgIhP6j2XEIb2vZQ&e=1730872705&a=1&p=0&r=40bc0bbb44f75652e74b9f74d70ea85d"),
    Song(
        title: "16",
        artistName: "Obito",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Bắt đầu 16\nTừ bỏ ý định làm người xấu\nTập tễnh viết lời vào tờ giấy\nĐem bao chuyện không hay\nMuốn kể cho mọi người thấu\nYoung boy with the passion\nLove to know he thinks back\nMặc kệ mọi thứ đang dang dở\nBut * it I still rap\nBắt đầu thêm những chuyện không vui\nNhưng lần này vấn đề\nNó không nằm ở ngoài đường\nThằng bé bắt đầu biết dùng âm nhạc\nĐể vẽ thêm màu sắc\nThêm hi vọng trong đời thường\nBa mẹ nó làm việc đến thâu đêm\nCũng không vui với cái cách nó chọn đường\nThằng bé lúc đó cũng không nghĩ\nÂm nhạc cùng với nó sau này\nTrở thành tình trường\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nLúc đầu toàn lời độc trong lời văn\nChửi thề dính ở mồm như thuốc phiện\nNhạc chửi thì ai mà muốn nghe\nCõi sâu của tâm hồn\nThì sau này nó mới tìm\nCảm xúc cứ như nén ở phần ngực\nCon người mới đôi khi khiến nó buồn bực\nMơ lớn và tính cách hiếu thắng\nNhưng tự tìm cách bước\nĐôi khi khiến nó ấm ức\nNhưng kiên quyết\nKhông muốn trở thành người xấu\nVẫn cố dù không biết đi từ đâu\nChân cứ bước đi trong vô thức\nCũng vô thức trưởng thành hơn ngày đầu\nSự vô thức làm tâm hồn nó nở hoa\nSự vô thức làm nó chìm trong cảm xúc\nSự vô thức tạo cho nó thế giới riêng\nVô tình khiến nó không biết\nChuyện gì đang diễn ra\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNgười thân trong nhà cắn xé nhau\nBiến cố ập ngay lúc nó bay bổng\nThêm một lần thằng bé đó đau lòng\nBắt đầu biết sao ba mẹ làm thâu đêm\nĐể ý khi mẹ trốn vào một góc\nBiết được những con số cần giải quyết\nNhững con số khi nhìn vào là bật khóc\nQuyết định đứng dậy và nó đi\nBỏ tâm sự vào âm nhạc điều nó nghĩ\nLao đầu vào cuộc đời mạng nó phi\nKhông ngại làm con tốt cho đời thí\nChuyến xe đưa nó đi xa thật xa\nTrách nhiệm không cho chân nó được ngã\nNuôi ý chí để dòng họ nó nhờ vả\nÔm giấc mộng thành công\nĐể tâm hồn được về nhà\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16\nNăm đó nó vừa tròn 16",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/16-Obito-11836722.mp3?st=hvwVuVSedw9_OSZBFgPUkA&e=1730941456&a=1&p=0&r=7e5eea6f1af4fb2c1c03367b79c6ce47"),
    Song(
        title: "Sài Gòn ơi",
        artistName: "Obito",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Ouuuu Sài Gòn ơi ouuu Sài Gòn ơi\nSao em lại đối với anh như này\nOuuuu Sài Gòn ơi ouuu Sài Gòn ơi\nSao em lại đối với anh\nTim anh nóng lòng gặp nàng\nĐể cảm xúc lên từng nhịp\nNơi quá khứ anh không vui\nHạnh phúc mắt anh không nhìn kịp\nAnh pack hết đồ nhìn thật lâu\nBồi hồi trên chuyến xe trong đêm\nMắt sáng như sao\nVì được nghe thật nhiều điều vui\nKhi bên em\nTrò chơi em thích đánh đố\nPhố sáng khi em lên đồ\nVì tương lai nên anh cũng cố\nDù em khiến anh đôi khi hơi rồ\nVà giá như giá như giá như\nVà giá như giá như giá như\nGiá như anh hiểu được em\nOuuuu Sài Gòn ơi ouuu Sài Gòn ơi\nSao em lại đối với anh như này\nOuuuu Sài Gòn ơi ouuu Sài Gòn ơi\nSao em lại đối với anh như này\nTưởng chừng như dài lâu\nTưởng như yêu đậm sâu\nTưởng như ta hợp nhau\nGiờ còn chẳng nói với nhau một câu\nEm dắt anh đi gặp nhiều người\nDù họ không tốt với anh\nHọ khiến anh rơi giữa dòng đời\nMàn đêm đang kéo tới nhanh\nVà rồi em đâu\nTình mình thêm đau\nTại sao em nỡ vô tâm\nĐể vỡ trái tim người yêu em nhiều nhất\nOh oh baby à baby\nRồi người ta cũng sẽ bỏ em đi\nKhi mọi thứ đã đủ đầy\nChỉ mình em với những\nKhoảng không cô đơn\nỪ thì anh vẫn thương em\nNhưng làm sao để quay về\nNgày tình mình như hôm nào\nOh oh oh\nOh oh oh\nOh oh oh\nOh\nGiá như anh hiểu được em",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/SaiGonOi-Obito-11836723.mp3?st=y51o9x0jRFZce6uYriRd-Q&e=1730896233&a=1&p=0&r=209d155f38ece3be722e7eac81b938ac"),
    Song(
        title: "Trốn Chạy",
        artistName: "Obito",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Đầu óc tao đang nặng trịch đi\nNếu mà ngay từ đầu\nNày chỉ muốn lợi dụng tao\nSao con ph* mày không nói m* vậy đi\nLàm ra vẻ ai cũng muốn làm hại mày\nCho tao hỏi mày làm vậy để chi\nNước mắt cá sấu để chi\nHay vì sợ cuộc đời mày dễ bí\nHay trên đời mày không còn ai để thí\nNội tao tim yếu rồi đêm đau\nSố mà tao kiếm được\nTao mong gửi về cho gia đình\nBao nhiêu thành phố nhiêu đêm thâu\nChạy show cho một đống\nĐể tâm lý rơi vào sự vô định\nLời mày nói đ** đúng với sự thật\nCơm mày ăn đ** phải là của mày\nVấn đề trong đời tao đủ chật\nVà tao nghĩ mặt mày cũng đủ dày\nTất cả thứ thuộc về tao\nĐáng ra có thể giúp\nCho ba mẹ tao bớt cực và bớt khóc\nTất cả thứ thuộc về tao\nĐáng ra có thể mua\nCho thằng em tao tuổi thơ không cực nhọc\nTất cả thứ thuộc về tao\nĐáng ra có thể làm\nCho gia đình tao thoát khỏi nơi chết chóc\nTất cả thứ thuộc về tao\nGiờ lại nằm trong túi mày\nTao phải nghĩ cách tồn tại đến nát óc\nCũng là giá tao phải trả cho hào quang\nGiá tao phải trả vì ngu dốt\nGiá tao phải trả\nVì những thứ tao không hiểu\nNhưng lại đi đặt niềm tin nơi không tốt\nTâm lý bị xé nát nơi quận 2\nSức khoẻ bị vắt kiệt đến hết sức\nKhoá miệng tao không tin một ai\nVà có cả suy nghĩ\nCần nhảy xuống để kết thúc\nChân cứ lê bước đi trong màn đêm\nCố tìm lại bản thân tao từng nên\nRượu gái chất cấm trong hộp đêm\nTrốn chạy những cảm xúc đang ập đến\nSự tự tin tao luôn có mất đi\nÁnh nắng trong nụ cười tao mất đi\nNgây thơ trong người tao mất đi\nCảm xúc cho âm nhạc cũng mất đi\nĐầu óc tao đang nặng trịch đi\nNếu mà ngay từ đầu\nMày chỉ muốn lợi dụng tao\nSao con ph* mày không nói m* vậy đi\nLàm ra vẻ ai cũng muốn làm hại mày\nCho tao hỏi mày làm vậy để chi\nNước mắt cá sấu để chi\nHay vì sợ cuộc đời mày dễ bí\nHay trên đời mày không còn ai để thí\nNội tao tim yếu rồi đêm đau\nSố mà tao kiếm được\nTao mong gửi về cho gia đình\nBao nhiêu thành phố nhiêu đêm thâu\nChạy show cho một đống\nĐể tâm lý rơi vào sự vô định\nLời mày nói đ** đúng với sự thật\nCơm mày ăn đ** phải là của mày\nVấn đề trong đời tao đủ chật\nVà tao nghĩ mặt mày cũng đủ dày\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nGiữ tất cả mọi thứ cho riêng tao\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nMong một giấc thật ngon trong chiêm bao\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nThêm thuốc vào cho quên đau\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nNỗi niềm này tao phải nuốt ngược vào\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy trốn chạy trốn chạy\nNên tao phải trốn chạy trốn chạy\nTrốn chạy trốn chạy\nTrốn chạy trốn chạy\nNên tao phải trốn\nNên tao phải trốn",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/TronChay-Obito-11836724.mp3?st=4iskjvq9LGjKzexQ8GeOcg&e=1730941467&a=1&p=0&r=4659e255b7dea9de38652b51fb63ab71"),
    Song(
        title: "Cất cánh (interlude)",
        artistName: "Obito",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics: "Hẹn gấp chú ýChúng tôi xin báo báo chúng ta...",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/CatCanhInterlude-Obito-11836725.mp3?st=PyngbhDxU408JT7BQwYweA&e=1730941472&a=1&p=0&r=1f6f6862be768dd4c956d0208f162a7b"),
    Song(
        title: "Hà Nội",
        artistName: "Obito VSTRA",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Họ gọi thành phố này là\nNơi khó tồn tại\nNhưng đây là nhà\nChỉ một mình em hiểu được buốt giá\nYêu sự buốt giá\nVì lòng lạnh lẽo nhiều rồi\nKhông có điều gì\nEm không hiểu được\nChỉ một tình yêu một lòng\nEm đã lựa chọn không ai lấy được\nAi làm đau anh à\nKhông sao đâu baby\nBaby hãy hãy nắm lấy tay em\nAi lừa dối anh à\nKhông sao đâu baby\nBaby có thể tin em\nEm xua đi cơn mưa buồn\nEm nuôi anh trong tâm hồn\nEm không chơi\nEm không đùa em yêu thôi\nEm cho anh thế giới đẹp\nEm cho anh thấy hết rồi\nNếu có ngã em sẽ dìu anh đi thôi\nBaby anh đang lo gì\nBaby anh đang nghĩ gì\nNghĩ nhiều mệt thêm thôi\nRơi sâu vô xuống bóng tối những góc tối\nChỉ mình anh thấy\nNước mắt giá buốt vết xước\nNhững nhức nhối\nVờ rằng không thấy\nAnh chỉ đang cố nuốt hết vào trong\nChờ một ngày nắng lên\nNhư anh hằng mong\nChợt bỗng dưng thấy em đến bên\nHealing all off my scars\nĐuổi đám mây tối đen\nVẽ lên cánh chim đang vươn xa\nLàm anh hiểu ra làm anh hiểu ra\nLàm anh hiểu ra nhiều điều\nEm khiến anh nhìn sâu vào tâm hồn\nLà tiếng êm mặc kệ\nBên ngoài kia ồn\nDẫn anh đi trong đêm\nSoi sáng bước anh đến\nLung linh như ánh nến trước gió",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/HaNoi-Obito-11836726.mp3?st=ymr6zD6Z6RoSpFft5dAfYQ&e=1730935954&a=1&p=0&r=6e396336ce1420af4ae3678531138da5"),
    Song(
        title: "Vô Điều Kiện",
        artistName: "Obito",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Khi mà ngây thơ không còn nguyên\nThì tìm đâu ra bình yên\nNốc thêm viên để xua cơn noi\nChân đi tìm sự vô điều kiện\nThấy được nhiều thứ cần kiêng\nCố gắng cho đến lúc nằm yên\nKhông mở lòng một cách tuỳ tiện\nKhông để thứ không đáng làm phiền\nNhớ lại những lúc mà còn nhỏ\nThế giới này thật đẹp\nViệc cho việc nhận\nVốn không cần phải ghi chép\nCho đi vì mình yêu\nNhận lại dù không đòi\nTrao ai cũng như vậy\nKhông biết thế nào xấu\nThế nào là cao đẹp\nĐơn giản là tình yêu thuần khiết\nHay tại tao lớn quá nhanh\nTâm hồn đang héo mòn dần\nĐã từ bao giờ khi con tim\nVà lý trí chia hai\nRồi không còn thân\nĐã từ bao giờ\nTao đa nghi với mọi thứ\nNiềm vui kia không còn cần\nĐã từ bao giờ\nTao lại trở nên\nKhô cằn đến như này\nNụ cười kia không còn phần\nHay là tại tao tại mày tại đời\nTao cũng không biết\nHay là tại tao tại mày tại đời\nSự vô điều kiện từng trong tao\nNay lại thành có điều kiện\nTao cần điều kiện\nĐể có thể gặp một người\nCó thể đặt niềm tin vào một người\nCó thể làm việc cùng một người\nCó thể chia sẻ cho một người\nVà có thể để đi cùng với một người\nHay là tại tao tại mày tại đời\nTao cũng không biết\nHay là tại tao tại mày tại đời\nTao cũng không biết\nKhi mà ngây thơ không còn nguyên\nThì tìm đâu ra bình yên\nNốc thêm viên để xua cơn noi\nChân đi tìm sự vô điều kiện\nThấy được nhiều thứ cần kiêng\nCố gắng cho đến lúc nằm yên\nKhông mở lòng một cách tuỳ tiện\nKhông để thứ không đáng làm phiền",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/VoDieuKien-Obito-11836727.mp3?st=qULnRM2rG4aIkk12btOxDQ&e=1730941483&a=1&p=0&r=21f8de9b7961594887ce91e17cce6bbb"),
    Song(
        title: "Đánh Đổi",
        artistName: "Obito, MCK",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Tao đánh đổi màn đêm yên giấc\nViết những bài nhạc hay nhất cuộc đời\nDi sản là nguồn cảm hứng\nFan theo răm rắp nhạc tao thuộc lời\nTrên bàn tiệc của tiên và quỷ\nTao là thằng duy nhất được mời\nMọi thứ đổ dồn hết vào tao\nNhư kiểu tao là một ván cược hời\nTao là đứa con của mặt trăng\nMang năng lượng mặt trời\nCuộc đời xoay tao như trực thăng\nVẫn vượt lên như thể gặp thời\nTao không vứt đi bản chất tao\nNhư mấy thằng khác để ví được lời\nNếu mày cũng mặt nặng mài nhẹ\nVì không đồng ý thì thôi được rồi\nShout out cho anh Sea\nLời chúc phúc bay trên bầu trời\nEm mong anh hãy nói với mẹ\nCuộc sống con giờ đã đỡ cực rồi\nHai anh em đã đổ nước mắt\nNhiều câu chuyện về những người tồi\nSự đánh đổi này vẫn luôn đẹp\nNhư thể ngày xưa chơi cất nhà chòi\n**** it\nĐêm đông lạnh giữa trời Hà Nội\nFlow tao chảy cùng những niềm đau\nNhư thể đang châm thêm mực vào ngòi\nChuỗi hành trình cùng nhiều câu hỏi\nAi là cá còn ai là mồi\nMọi thứ đều luôn có mặt tối\nNhưng liệu mày có sẵn sàng đánh đổi\nNgắm nhìn cả thế giới từ xa\nDamn it's cold\nNếu mày hỏi tao ác hay thiện\nMan I don't know\nChắc đây vốn đã là\nCái giá cho bao lần đau\nSự đánh đổi này cho tao thấy\nMọi thứ đã không như ngày đầu\nNgắm nhìn cả thế giới từ xa\nDamn it's cold\nNếu mày hỏi tao ác hay thiện\nMan I don't know\nChắc đây vốn đã là\nCái giá cho bao lần đau\nSự đánh đổi này cho tao thấy\nMọi thứ đã không như ngày đầu\nIt's a fair trade\nTelling all the truth\nIt's a fair trade\nAin't none pussy in the way\nIt's a fair trade\n**** you if you fake it\nIt's a ****ing fair trade oh\n2020 và tao nổi như hiện tượng\nNhưng không chìm vào trong đấy\nĐể rồi chết như thằng ngu\nBa năm đánh đổi\nĐể tu thân trong hoạ đời\nRồi biết đâu là thật giả\nTâm tao nhàn như tiều phu\nĐảo mắt quan sát\nNhư diều hâu đang đi lượn\nIm lặng và cười nhếch\nVới drama và ruồi bu\n2023 lời tao bắn như cái máy\nMà còn *** trượt phát nào\nSự đánh đổi đó thằng ***\nTrò đời quăng tao vào địa ngục\nCho tao biết mặt trái của whole game\nCho tao bài hit, cho fame\nXong nó lấy đi tất cả sao bao đêm\nTao vẫn vươn từ dưới đáy đi lên\nBật và đòi lại bằng được no shame\nChiêm nghiệm và mài giũa thâu đêm\nGiờ tinh khiết và óng ánh như blue gem\nKhông tìm thấy tao\nTao bận đi tu luyện\nCâu chuyện của tao\nCó đủ để hay hơn tụi mày\nTu xong dù thành tiên\nHay là thành quỷ\nVẫn ẩn khỏi radar\nThân vẫn đóng lớp bụi dày\nRất nhiều thằng trẻ\nLà trường hợp giống như tao\nNhưng bị nghề này nó dập\nXong tâm lý ở dưới đáy\nTao thoát được tệ nạn\nThoát được cảnh vung dao\nTao đánh đổi tất cả\nĐể chân chạy đến được đây hoes\nTrên cao\nTao biết là tao\nVẫn đang chính là tao\nKhi mà chơi chán\nThì peace I’m out\nĐôi khi rất là cô đơn\nTao lấy hết sự cô đơn\nTao lấp vào trong bank account\nNhư là pacquiao manny\nPacquiao shadowbox trên nền vinahouse\nVẫn chưa thấy thằng nào nhanh hơn tao\nThác đổ thác đổ\nFlow tao dồn xuống như là K50\nỞ dưới toàn núi đồi núi đồi\nBỏ mẹ rồi úi dồi úi dồi\nCẩn thận không bị cuốn vào cuốn vào\nAnh là mỏ ối người muốn đào\nAnh về rồi cúi người xuống nào",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/DanhDoi-Obito-11836728.mp3?st=agDsY1Ru2fnZi9gaFQvNVQ&e=1730941408&a=1&p=0&r=be413a18a18a47a6aa1c2bfdc7831b8d"),
    Song(
        title: "Backstage Freestyle",
        artistName: "Obito",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "This is a hard flow\nI go J Cole on it\nTao găm niềm đau vào từng câu\nSắp xếp đúng chỗ như là công việc\nYeah feeling like Drizzy\nNhạc tao vang khắp\nSân khấu và ngõ hẻm\nCũng có thể cho mày\nTăng thêm thân nhiệt\nLiệu thằng nào biết\nSau khi bước xuống sân khấu\nThằng đang đứng rap\nNó giấu gì ở đằng sau\nNăm học cấp hai\nGhế nhà trường nó dính máu\nNiềm vui về gia đình\nDần đang biến thành niềm đau\nMan I feel pain my heart feel shitty\nTao biến những khoảnh khắc\nTao sụp đổ cùng nước mắt kia thành vàng\nVỗ ngực tự hào đó là tao\nNhắm vào vấn đề\nLời tao nã như AK\nĐể diễn tả ra được hết\nNhững xúc mà tao đang\nTrải qua từng ngày\nVới thân xác tuổi 18\nHai năm trước lập thành tích\nCũng là xích mà tao mang\nMày khoe mấy tờ giấy\nMua mày nhiều vàng\nCòn tờ giấy tao lấy\nMua về sự an toàn\nĐằng sau ánh hào quang\nNơi góc tối tao cất giữ\nLà khu đất cấm biệt tích\nMấy thằng ngu còn làm càng\nSinh ra để làm sao man\nSáng đến cách mấy\nCũng phải trải qua cay đắng\nTao đếm từng bài học\nXem nó như sắp tài liệu\nNhỡ khi đụng chuyện\nCần thiết vào trong đầu tao ngay ngắn\nMày lấy được nhiều fame\nTiền bạc và ống kính\nNhưng sau ánh hào quang\nTim mày liệu có ngay thẳng\nTao nói ra điều này\nĐể chứng minh rằng\nThành công tao có được ngày hôm nay\nVốn không phải do may mắn\nKhông chơi bóng rổ\nNhưng tao ball like Lebron\nVua của bản thân homie\nÝ chí tao là hổ gầm lên\nXua những giọng nói\nXung quanh đầu tao đang cố\nKêu tao thua đi\nGửi đi lời thách thức\nCho những thằng muốn tao ngã\nTao vẫn đang xuất hiện như là oxy\nTao sẽ kéo gia đình tao\nĐi hết ra khỏi hood\nSống một cuộc đời thượng lưu\nYeah mày nói đi\nỪ thì tao là đàn ông\nĐàn ông cũng phải khóc\nEveryone know it\nỪ thì mày hay phán xét về cuộc sống\nBut you don't know *\nDù mày đưa tao tiền tỷ\nĐể đổi lấy linh hồn tao\nMan I said * it\nAi lấy đi mà xài\nTao vẫn chọn con tim\nVì tao kiếm nhiều hơn thế\nBitch I know it\nThis is a hard flow\nI go J Cole on it\nTao găm niềm đau vào từng câu\nSắp xếp đúng chỗ như là công việc\nYeah feeling like Drizzy\nNhạc tao vang khắp\nSân khấu và ngõ hẻm\nCũng có thể cho mày\nTăng thêm thân nhiệt\nWoah từ sân bay đến sảnh\nResort đến khách sạn\nTừ Roll Royce đến Mer baby\nĐặt chân đến thành phố\nKhông phải là quê nhà\nMang đến âm nhạc baby\nKhung cảnh lặp lại\nAgain and again\nNhưng cảm xúc vẫn vậy baby\nCảnh anh ngồi bên kính xe\nLàn gió bên cửa sổ\nNgẫm nghĩ về cuộc đời baby\nTao rap đến khan tiếng\nNước miếng bắn vào màn hình\nThay vì ngồi than khổ yeah\nTao nuốt hết buồn đau\nVẽ nó vào bên trong nhạc\nNgười ta nói tao năng nổ yeah\nTao cược cả cuộc đời\nVào canh bạc với quỷ dữ\nCó cả máu tao đang đổ yeah\nVóc dáng của thiên thần\nNhưng mà ruột gan tao có\nNó xám tro như đồ cổ yeah\nNên thứ tao cho đi\nChỉ nhạc là nhạc và nhạc\nNhưng thứ tao bỏ vào âm nhạc\nLà vàng kim cương\nLà vàng cho nhạc rap\nChỉ là vài tờ nháp\nNhưng là cả một câu chuyện ở đằng sau\nNên dù đứng trên sân khấu\nGương mặt của tao cười\nNhưng liệu đó có thật sự là tao\nThis is a hard flow\nI go J Cole on it\nTao găm niềm đau vào từng câu\nSắp xếp đúng chỗ như là công việc\nYeah feeling like Drizzy\nNhạc tao vang khắp\nSân khấu và ngõ hẻm\nCũng có thể cho mày\nTăng thêm thân nhiệt\nThis is a hard flow\nI go J Cole on it\nTao găm niềm đau vào từng câu\nSắp xếp đúng chỗ như là công việc\nYeah feeling like Drizzy\nNhạc tao vang khắp\nSân khấu và ngõ hẻm\nCũng có thể cho mày\nTăng thêm thân nhiệt",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/BackstageFreestyle-Obito-11836729.mp3?st=VvMYNWaJM1xhU4oxZpybXw&e=1730941493&a=1&p=0&r=89a51152ed1c04665f3a30b3348a75c3"),
    Song(
        title: "Tell the kids i love them",
        artistName: "Obito, Shiki",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Và liệu em có nghe\nTình yêu đang vụn vỡ\nVà mất bao lâu\nĐể quên đi tổn thương\nDù là nhiều năm đã qua\nTrái tim chẳng thay đổi\nVà chỉ mong được bình yên sau này\nYeah và từ lần đó\nAnh chẳng còn nhớ nhung đầy vơi\nChẳng thân quen chẳng còn đau\nNhư đã từng yeah\nLife is better if you want to\nNếu em nhìn thật sâu\nVào trong đôi mắt\nEm có thể thấy rằng anh đang khóc\nAnh cũng nhiều lần gây tội\nVà cũng tiếc nuối vì chuyện công cốc\nAnh chạy theo tiếng đường phố\nLặp sai và sai cứ thế lao dốc\nAnh từng nghĩ rằng anh khôn\nCho đến khi đời bảo rằng anh ngốc\nAnh vẽ ra nhiều viễn cảnh\nNhưng anh không làm dù nó khiến anh mê\nAnh ao ước khi cần chạy\nThì việc anh *** chân vẫn là thực tế\nAnh nghĩ rằng nếu hung dữ\nThì những người khác sẽ thấy anh ghê\nNhưng đến khi được yêu thương\nAnh lại thích thú như một thằng hề\nAnh từng thích dùng bạo lực\nVì không thích thằng nào không tôn trọng anh\nĐến khi anh hiểu được ra\nAi không thích mình thì chỉ việc tránh\nAnh từng nói dối rất nhiều\nDù mấy chuyện đó không vì lợi danh\nĐến khi anh hiểu được ra\nHậu quả để lại không phải điều lành\nYeah anh không cao siêu như em nghĩ\nAnh từng là em là mày\nTừng là thằng ngu làm liều khi bí\nQuan trọng là khi nhận ra\nHành động tiếp theo của em là gì\nVì đồng tiền vốn đang có hôm nay\nKhông thể nào mai trở thành tiền tỉ\nAnh chỉ đơn giản là người làm nhạc\nLà thằng chạy theo đam mê\nVì biết cố gắng là một lối thoát\nĐã từng đâm đầu việc sai\nĐể biết rút ra mới là việc đúng\nNếu muốn yên bình trong ngày mai\nThì nay phải sống như ngày cuối cùng\nTìm một nơi để yên giấc\nSau tháng năm mệt nhoài\nVà để tâm hồn\nĐược hòa vào lời hát\nCó thể em ao ước giống như anh\nKhông muốn màu sắc cuộc đời\nChỉ pha vỏn vẹn giữa đen và trắng\nKhông muốn nhìn vào trong gương\nVì không thích thứ mình trở thành\nNhưng tất cả những cơn giông đó\nGiúp em trân trọng hơn khi bầu trời xanh\nAnh cảm ơn nếu mắt em sáng\nCảm ơn từng stream bài nhạc\nKhán giả nghe khi anh còn làm\nTrái tim anh vẫn nơi đây\nKhông hề âm mưu hay sinh ra kế\nAnh chỉ là một bằng chứng sống\nChứng minh câu nói\nKhông gì là không thể\nEm không cần cố để được như anh\nMỗi cây mỗi lá mỗi cành\nMỗi người mỗi chuyện\nMỗi nhà mỗi cảnh\nEm chỉ cần là chính em\nChạy theo tương lai em muốn trở thành\nDù đường đời em trải nhiều màu\nThì cũng chỉ tô đẹp thêm\nCho một bức tranh\nHãy lắng nghe những gì em muốn\nĐể thời gian sửa những điều em sai\nVì cuộc đời không hề gắt gỏng\nVới những đứa con đang muốn làm lại\nHãy sống thật là hạnh phúc\nĐưa bản thân đến một nơi cao\nBài này vẫn sẽ mãi ở đây\nĐể luôn nhắc nhở\nEm là một ngôi sao",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/TellTheKidsILoveThem-ObitoShikii-11836730.mp3?st=_hIeAUEndIv_MXkukTPLyQ&e=1730872460&a=1&p=0&r=f0b8cfc55795fcecdf442d990cee5ad8"),
    Song(
        title: "Ước mơ của Mẹ (interlude)",
        artistName: "Obito",
        albumName: "Đánh đổi",
        duration: "3:30",
        imgURL:
            "https://avatar-ex-swe.nixcdn.com/song/2023/10/02/c/5/c/8/1696247047452_500.jpg",
        lyrics:
            "Nè anh AloNèMẹ con hỏi mẹ cái này cái được không?Nói điNếu mà bây giờ kiểu gia đình mình lo xong hết kiểu chuyệnLo xong hết mấy cái vấn đề của gia đình,những cái khó khăn của gia đìnhThì cái lúc đó mẹ rảnh nèMẹ không còn phải lo,phải nghĩ gì nữa hếtThì cái chuyện đầu tiên mà mẹ làm thì mẹ sẽ làm cái gì?Mẹ cũng không biết cái gì luôn nữaĐầu tiên mẹ làm á hả?Dạ Đầu tiên mẹ làm làGiống bây giờ mẹ đi lên trên conMẹ ở chừng 5,10 bữa, nửa thángÀMẹ đi chơi,mẹ về ở với con cho đãRồi hết rồi phải không?Rồi bắt đầu cáiỞ nhà đợi con của mẹ hả?Mẹ Nếu mà thì thì nếu mà giả sử đi giả sử mấy cái chuyệnkiểu con nói với mẹkiểu vấn đề này kiaxong hếtrồi khó khăn cũng xong hếtnói chung mẹ không cần phải lo phải nghĩ gì đóthì cái điều đầu tiên mà mẹ nói với conlà mẹ nói cái gì?Điều đầu tiên mẹ muốn nói với conlà con biết mẹ muốn nói gì không?Mẹ cảm ơn conđồng hành với mẹvới batrong lúc gia đình khó khăn,con còn nhỏ, con mới lớn lên,mới có lập nghiệp được mà con không lo cho bản thân của conmà con còn lo ngược lại cho mẹcon chợi mẹ buồn,con lo lắng cho mẹrồi những lúc mà cầm tiền,đồng tiền của congiống như cầm cái đồng tiền của con,nó nặng lắm, con biết khôngnhưng mà con cứ lo cho mẹCon lo cho mẹ,con...con...là...mẹ cảm ơn con là con lớn lên, con không cóphụ lòng ba mẹ mà con locho mẹ, lo cho gia đình trong lúchoàn cảnh như vầy nè,con không có chạy theo những hàm muốn riêng biệtcủa con, con biết không?Mà con lo cho mẹcon bỏ hết những hàm muốntuổi trẻ của con,màcon làm, con dành ***, con gửi tiền vềcho mẹ, lo cho gia đìnhlà cho dù ít nhiều gìCái đành tiền đó nó lớn lao lắm,con hiểu không?Trong khoảng thời gian này nó lớn lao đó với mẹ dữ lắmVà mẹ thấy được giống như mẹ nuôi con mẹ thành công rồi đó, con hiểu không?Dạ,rồi,biết rồiRồi thôi, đợi con trai đi làm nhạc xong rồi con trai kiếm tiền về,con trai dẫn mẹ đi du lịch",
        urlMedia:
            "https://stream.nct.vn/Believe_Audio345/UocMoCuaMeInterlude-Obito-11836731.mp3?st=NjJ59vePZ2fwG0QyizSNmA&e=1730939939&a=1&p=0&r=d545f1552cd44ea822faed7f314c5eba"),
    // Song(
    //     title: "",
    //     artistName: "Obito",
    //     albumName: "Đánh đổi",
    //     duration: "3:30",
    //     imgURL: "",
    //     lyrics: "",
    //     urlMedia: ""),
    // Song(
    //     title: "",
    //     artistName: "Obito",
    //     albumName: "Đánh đổi",
    //     duration: "3:30",
    //     imgURL: "",
    //     lyrics: "",
    //     urlMedia: ""),
    // Song(
    //     title: "",
    //     artistName: "Obito",
    //     albumName: "Đánh đổi",
    //     duration: "3:30",
    //     imgURL: "",
    //     lyrics: "",
    //     urlMedia: ""),
    Song(
        title: "Ghost",
        artistName: "Justin Bieber",
        duration: "3:48",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/0/08/Justin_Bieber_-_Justice.png",
        albumName: '',
        lyrics: '',
        urlMedia: ''),
    Song(
        title: "Baby",
        artistName: "Justin Bieber",
        duration: "4:21",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYqS_oTFyhJqDDyXXr3uadK_TRkFcWLD3tcQ&s",
        albumName: '',
        lyrics: '',
        urlMedia: ''),
    Song(
        title: "Yummy",
        artistName: "Justin Bieber",
        duration: "3:19",
        imgURL:
            "https://www.udiscovermusic.com/wp-content/uploads/2022/03/Justin-Bieber-GettyImages-1230371382.jpg",
        albumName: '',
        lyrics: '',
        urlMedia: ''),
  ];

  static List<Album> albums = [
    Album(
        title: "ASTROWORLD",
        artistName: "Travis Scott",
        genre: genres[2],
        releaseDate: "2019",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNm1furF44UIecVS2SQXeAMQV58-0cmPt5Fg&s",
        songs: songs.take(10).toList()),
    Album(
        title: "Lemonade",
        artistName: "Beyoncé",
        genre: genres[2],
        releaseDate: "2016-04-23",
        imgURL:
            "https://aimm.edu/hubfs/Blog%20Images/Top%2010%20Album%20Covers%20of%202017/Tyler%20the%20Creator-%20Flower%20boy.jpg",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Scorpion",
        artistName: "Drake",
        genre: genres[2],
        releaseDate: "2018-06-29",
        imgURL:
            "https://images.theconversation.com/files/512871/original/file-20230301-26-ryosag.jpg?ixlib=rb-4.1.0&rect=97%2C79%2C5799%2C5817&q=45&auto=format&w=926&fit=clip",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Divide",
        artistName: "Ed Sheeran",
        genre: genres[0],
        releaseDate: "2017-03-03",
        imgURL:
            "https://www.billboard.com/wp-content/uploads/2023/07/SZA-SOS-album-art-billboard-1240.jpg?w=800",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "1989",
        artistName: "Taylor Swift",
        genre: genres[0],
        releaseDate: "2014-10-27",
        imgURL:
            "https://images.prismic.io/milanote/df7eeb83a07162b45ac2e882cac055de9411054a_cover.jpg?auto=compress,format",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Thank U, Next",
        artistName: "Ariana Grande",
        genre: genres[0],
        releaseDate: "2019-02-08",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/6/66/Ariana_Grande_-_Thank_U%2C_Next.png/220px-Ariana_Grande_-_Thank_U%2C_Next.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Purpose",
        artistName: "Justin Bieber",
        genre: genres[0],
        releaseDate: "2015-11-13",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/7/7b/Justin_Bieber_-_Purpose.png/220px-Justin_Bieber_-_Purpose.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "When We All Fall Asleep, Where Do We Go?",
        artistName: "Billie Eilish",
        genre: genres[0],
        releaseDate: "2019-03-29",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/6/62/Billie_Eilish_-_When_We_All_Fall_Asleep%2C_Where_Do_We_Go%3F.png/220px-Billie_Eilish_-_When_We_All_Fall_Asleep%2C_Where_Do_We_Go%3F.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "After Hours",
        artistName: "The Weeknd",
        genre: genres[0],
        releaseDate: "2020-03-20",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/The_Weeknd_-_After_Hours.png/220px-The_Weeknd_-_After_Hours.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Hollywood's Bleeding",
        artistName: "Post Malone",
        genre: genres[0],
        releaseDate: "2019-09-06",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/8/89/Post_Malone_-_Hollywood%27s_Bleeding.png/220px-Post_Malone_-_Hollywood%27s_Bleeding.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "The Fame",
        artistName: "Lady Gaga",
        genre: genres[0],
        releaseDate: "2008-10-28",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/2/2f/Lady_Gaga_The_Fame.png/220px-Lady_Gaga_The_Fame.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Teenage Dream",
        artistName: "Katy Perry",
        genre: genres[0],
        releaseDate: "2010-08-24",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/0/01/Katy_Perry_Teenage_Dream.png/220px-Katy_Perry_Teenage_Dream.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Uptown Special",
        artistName: "Mark Ronson",
        genre: genres[0],
        releaseDate: "2015-01-13",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/6/6a/Mark_Ronson_Uptown_Special.png/220px-Mark_Ronson_Uptown_Special.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Good Girl Gone Bad",
        artistName: "Rihanna",
        genre: genres[0],
        releaseDate: "2007-05-29",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/a/a5/Rihanna_-_Good_Girl_Gone_Bad.png/220px-Rihanna_-_Good_Girl_Gone_Bad.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Handwritten",
        artistName: "Shawn Mendes",
        genre: genres[0],
        releaseDate: "2015-04-14",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/1/1e/Shawn_Mendes_Handwritten.png/220px-Shawn_Mendes_Handwritten.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Rare",
        artistName: "Selena Gomez",
        genre: genres[0],
        releaseDate: "2020-01-10",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/8/80/Selena_Gomez_-_Rare.png/220px-Selena_Gomez_-_Rare.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Future Nostalgia",
        artistName: "Dua Lipa",
        genre: genres[0],
        releaseDate: "2020-03-27",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/e/e6/Dua_Lipa_-_Future_Nostalgia.png/220px-Dua_Lipa_-_Future_Nostalgia.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Fine Line",
        artistName: "Harry Styles",
        genre: genres[0],
        releaseDate: "2019-12-13",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/4/49/Harry_Styles_Fine_Line.png/220px-Harry_Styles_Fine_Line.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Plastic Hearts",
        artistName: "Miley Cyrus",
        genre: genres[0],
        releaseDate: "2020-11-27",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/1/11/Miley_Cyrus_Plastic_Hearts.png/220px-Miley_Cyrus_Plastic_Hearts.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Love Goes",
        artistName: "Sam Smith",
        genre: genres[0],
        releaseDate: "2020-10-30",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/5/5a/Sam_Smith_-_Love_Goes.png/220px-Sam_Smith_-_Love_Goes.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Cuz I Love You",
        artistName: "Lizzo",
        genre: genres[0],
        releaseDate: "2019-04-19",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/f/f7/Lizzo_-_Cuz_I_Love_You.png/220px-Lizzo_-_Cuz_I_Love_You.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "DAMN.",
        artistName: "Kendrick Lamar",
        genre: genres[2],
        releaseDate: "2017-04-14",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Kendrick_Lamar_-_DAMN.png/220px-Kendrick_Lamar_-_DAMN.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Invasion of Privacy",
        artistName: "Cardi B",
        genre: genres[2],
        releaseDate: "2018-04-06",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/6/6b/Cardi_B_Invasion_of_Privacy.png/220px-Cardi_B_Invasion_of_Privacy.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Hot Pink",
        artistName: "Doja Cat",
        genre: genres[2],
        releaseDate: "2019-11-07",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/7/74/Doja_Cat_Hot_Pink.png/220px-Doja_Cat_Hot_Pink.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "7",
        artistName: "Lil Nas X",
        genre: genres[2],
        releaseDate: "2019-06-21",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/6/66/Lil_Nas_X_7.png/220px-Lil_Nas_X_7.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "SOUR",
        artistName: "Olivia Rodrigo",
        genre: genres[0],
        releaseDate: "2021-05-21",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/4/43/Olivia_Rodrigo_-_SOUR.png/220px-Olivia_Rodrigo_-_SOUR.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "ASTROWORLD",
        artistName: "Travis Scott",
        genre: genres[2],
        releaseDate: "2018-08-03",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/0/0e/ASTROWORLD.jpg/220px-ASTROWORLD.jpg",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Vivir Mi Vida",
        artistName: "Marc Anthony",
        genre: genres[6],
        releaseDate: "2013-07-23",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/e/e1/Marc_Anthony_-_Vivir_Mi_Vida.png/220px-Marc_Anthony_-_Vivir_Mi_Vida.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "K.O.",
        artistName: "J Balvin",
        genre: genres[6],
        releaseDate: "2019-08-30",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/3/32/J_Balvin_K.O.png/220px-J_Balvin_K.O.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "YHLQMDLG",
        artistName: "Bad Bunny",
        genre: genres[6],
        releaseDate: "2020-02-29",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/d/d7/Bad_Bunny_-_YHLQMDLG.png/220px-Bad_Bunny_-_YHLQMDLG.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "Versions of Me",
        artistName: "Anitta",
        genre: genres[6],
        releaseDate: "2022-04-22",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/0/0b/Anitta_Versions_of_Me.png/220px-Anitta_Versions_of_Me.png",
        songs: [] // Add songs specific to this album
        ),
    Album(
        title: "1000 Forms of Fear",
        artistName: "Sia",
        genre: genres[0],
        releaseDate: "2014-07-04",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/e/e1/Sia_1000_Forms_of_Fear.png/220px-Sia_1000_Forms_of_Fear.png",
        songs: [] // Add songs specific to this album
        ),
  ];
}
