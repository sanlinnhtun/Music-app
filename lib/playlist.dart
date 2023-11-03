import 'package:spotimus/song.dart';

class PlayList {
  final List<Song> _songList = [
    Song(
      Url:
          'https://docs.google.com/uc?export=download&id=17nEpMLaSUbN3iefZ91LvROy-kRoJowZA',
      title: 'စဉ်းစားပါ',
      singer: 'လင်းလင်း',
      img: 'images/ab67616d0000b2738c914d3f73a7c7662de103fa.jpg',
    ),
    Song(
      Url:
          'https://docs.google.com/uc?export=download&id=1zzAe5CGG8MnlhtrgfjVFMca_jlshmxNe',
      title: 'Snowman',
      singer: 'Sia',
      img: 'images/artworks-yZBBLIq69ckS-0-t500x500.jpg',
    ),
    Song(
        Url:
            'https://docs.google.com/uc?export=download&id=1YIom_Sy44ATR3JgW-xGTCWTZC-hfDukt',
        title: 'UP',
        singer: 'Sean Paul',
        img: 'images/download (2).jpg'),
    Song(
      Url:
          'https://docs.google.com/uc?export=download&id=1NlF3qev6FpDE269I8cbwJIQ56ojQ1e2k',
      title: 'Anyone',
      singer: 'Justin Bieber',
      img: 'images/artworks-MapOsRlRxYh3VL35-cKqPaQ-t500x500.jpg',
    ),
    Song(
      Url:
          'https://docs.google.com/uc?export=download&id=1NlF3qev6FpDE269I8cbwJIQ56ojQ1e2k',
      title: 'ခင်လေးစိမ်းတယ်',
      singer: 'ဝေလ',
      img: 'images/ab6761610000e5eb7376bba6fe463ea1c2812340.jpg',
    ),
  ];

  String getUrl(songNo) {
    return _songList[songNo].Url;
  }

  String getTitel(songNo) {
    return _songList[songNo].title;
  }

  String getSinger(songNo) {
    return _songList[songNo].singer;
  }

  String getImg(songNo) {
    return _songList[songNo].img;
  }
}
