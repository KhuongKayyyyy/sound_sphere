import 'package:flutter/material.dart';
import 'package:sound_sphere/data/models/user.dart';
import 'package:sound_sphere/data/models/artist.dart';
import 'package:sound_sphere/data/models/genres.dart';
import 'package:sound_sphere/data/models/song.dart';
import 'package:sound_sphere/data/models/album.dart';

class FakeData {
  static User user = User(
    name: "Nguyen Dat Khuong",
    password: "1123",
    email: "zzkhngzz@gmail.com",
    avatarURL:
        "https://yt3.googleusercontent.com/oN0p3-PD3HUzn2KbMm4fVhvRrKtJhodGlwocI184BBSpybcQIphSeh3Z0i7WBgTq7e12yKxb=s900-c-k-c0x00ffffff-no-rj",
  );

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
        title: "Ghost",
        artistName: "Justin Bieber",
        duration: "3:48",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/0/08/Justin_Bieber_-_Justice.png",
        albumName: ''),
    Song(
        title: "Baby",
        artistName: "Justin Bieber",
        duration: "4:21",
        imgURL:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYqS_oTFyhJqDDyXXr3uadK_TRkFcWLD3tcQ&s",
        albumName: ''),
    Song(
        title: "Yummy",
        artistName: "Justin Bieber",
        duration: "3:19",
        imgURL:
            "https://www.udiscovermusic.com/wp-content/uploads/2022/03/Justin-Bieber-GettyImages-1230371382.jpg",
        albumName: ''),
    Song(
        title: "Shape of You",
        artistName: "Ed Sheeran",
        duration: "3:53",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Blank Space",
        artistName: "Taylor Swift",
        duration: "3:51",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Thank U, Next",
        artistName: "Ariana Grande",
        duration: "2:53",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Sorry",
        artistName: "Justin Bieber",
        duration: "3:20",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Bad Guy",
        artistName: "Billie Eilish",
        duration: "3:14",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Blinding Lights",
        artistName: "The Weeknd",
        duration: "3:20",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Circles",
        artistName: "Post Malone",
        duration: "3:35",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Poker Face",
        artistName: "Lady Gaga",
        duration: "3:57",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Firework",
        artistName: "Katy Perry",
        duration: "3:48",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Uptown Funk",
        artistName: "Bruno Mars",
        duration: "4:30",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Umbrella",
        artistName: "Rihanna",
        duration: "4:36",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Stitches",
        artistName: "Shawn Mendes",
        duration: "3:20",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Lose You to Love Me",
        artistName: "Selena Gomez",
        duration: "3:27",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Don't Start Now",
        artistName: "Dua Lipa",
        duration: "3:03",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Watermelon Sugar",
        artistName: "Harry Styles",
        duration: "2:54",
        imgURL:
            "https://media.pitchfork.com/photos/658d8c80f3c653a4dd7f73df/master/pass/Kendrick-Lamar-Mr-Morale-and-the-Big-Steppers.jpg",
        albumName: ''),
    Song(
        title: "Midnight Sky",
        artistName: "Miley Cyrus",
        duration: "3:43",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/5/56/Miley_Cyrus_-_Midnight_Sky.png/220px-Miley_Cyrus_-_Midnight_Sky.png",
        albumName: ''),
    Song(
        title: "How Do You Sleep?",
        artistName: "Sam Smith",
        duration: "3:23",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/d/d7/Sam_Smith_-_How_Do_You_Sleep.png/220px-Sam_Smith_-_How_Do_You_Sleep.png",
        albumName: ''),
    Song(
        title: "Truth Hurts",
        artistName: "Lizzo",
        duration: "2:54",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/3/31/Lizzo_Truth_Hurts.png/220px-Lizzo_Truth_Hurts.png",
        albumName: ''),
    Song(
        title: "HUMBLE.",
        artistName: "Kendrick Lamar",
        duration: "2:57",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/f/f7/Kendrick_Lamar_-_HUMBLE.png/220px-Kendrick_Lamar_-_HUMBLE.png",
        albumName: ''),
    Song(
        title: "I Like It",
        artistName: "Cardi B",
        duration: "4:13",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/7/76/Cardi_B_I_Like_It.png/220px-Cardi_B_I_Like_It.png",
        albumName: ''),
    Song(
        title: "Say So",
        artistName: "Doja Cat",
        duration: "3:58",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/3/3b/Doja_Cat_Say_So.png/220px-Doja_Cat_Say_So.png",
        albumName: ''),
    Song(
        title: "Old Town Road",
        artistName: "Lil Nas X",
        duration: "2:37",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/d/d2/Lil_Nas_X_-_Old_Town_Road.png/220px-Lil_Nas_X_-_Old_Town_Road.png",
        albumName: ''),
    Song(
        title: "Good 4 U",
        artistName: "Olivia Rodrigo",
        duration: "2:58",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/5/5f/Olivia_Rodrigo_-_Good_4_U.png/220px-Olivia_Rodrigo_-_Good_4_U.png",
        albumName: ''),
    Song(
        title: "SICKO MODE",
        artistName: "Travis Scott",
        duration: "5:12",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/a/a5/Travis_Scott_SICKO_MODE.png/220px-Travis_Scott_SICKO_MODE.png",
        albumName: ''),
    Song(
        title: "Mi Gente",
        artistName: "J Balvin",
        duration: "3:06",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/e/ef/J_Balvin_Mi_Gente.png/220px-J_Balvin_Mi_Gente.png",
        albumName: ''),
    Song(
        title: "Vete",
        artistName: "Bad Bunny",
        duration: "3:49",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/6/62/Bad_Bunny_Vete.png/220px-Bad_Bunny_Vete.png",
        albumName: ''),
    Song(
        title: "Envolver",
        artistName: "Anitta",
        duration: "2:54",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/a/a3/Anitta_Envolver.png/220px-Anitta_Envolver.png",
        albumName: ''),
    Song(
        title: "Chandelier",
        artistName: "Sia",
        duration: "3:36",
        imgURL:
            "https://upload.wikimedia.org/wikipedia/en/thumb/2/2a/Sia_-_Chandelier.png/220px-Sia_-_Chandelier.png",
        albumName: ''),
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
