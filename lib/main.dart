import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:spotimus/playlist.dart';

// import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Spotimus(),
    );
  }
}

class Spotimus extends StatefulWidget {
  const Spotimus({super.key});

  @override
  State<Spotimus> createState() => _SpotimusState();
}

class _SpotimusState extends State<Spotimus> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int currentIndex = 0;
  Duration _duration = const Duration();
  Duration _position = Duration.zero;

// https://drive.google.com/file/d/17nEpMLaSUbN3iefZ91LvROy-kRoJowZA/view?usp=sharing
// https://drive.google.com/file/d/1zzAe5CGG8MnlhtrgfjVFMca_jlshmxNe/view?usp=sharing
// https://drive.google.com/file/d/1YIom_Sy44ATR3JgW-xGTCWTZC-hfDukt/view?usp=sharing
// https://drive.google.com/file/d/1ufqFOCkdZq14dmpejmWPne-TjedjAdDQ/view?usp=sharing
// https://drive.google.com/file/d/1NlF3qev6FpDE269I8cbwJIQ56ojQ1e2k/view?usp=sharing
  // String Url =
  //     "https://docs.google.com/uc?export=download&id=1ufqFOCkdZq14dmpejmWPne-TjedjAdDQ";

  // var songList = [

  //   {
  //     'Url':
  //         'https://docs.google.com/uc?export=download&id=17nEpMLaSUbN3iefZ91LvROy-kRoJowZA',
  //     'title': 'စဉ်းစားပါ',
  //     'singer': 'လင်းလင်း',
  //     'img': 'images/ab67616d0000b2738c914d3f73a7c7662de103fa.jpg'
  //   },
  //   {
  //     'Url':
  //         'https://docs.google.com/uc?export=download&id=1zzAe5CGG8MnlhtrgfjVFMca_jlshmxNe',
  //     'title': 'Snowman',
  //     'singer': 'Sia',
  //     'img': 'images/artworks-yZBBLIq69ckS-0-t500x500.jpg'
  //   },
  //   {
  //     'Url':
  //         'https://docs.google.com/uc?export=download&id=1YIom_Sy44ATR3JgW-xGTCWTZC-hfDukt',
  //     'title': 'UP',
  //     'singer': 'Sean Paul',
  //     'img': 'images/download (2).jpg'
  //   },
  //   {
  //     'Url':
  //         'https://docs.google.com/uc?export=download&id=1NlF3qev6FpDE269I8cbwJIQ56ojQ1e2k',
  //     'title': 'Anyone',
  //     'singer': 'Justin Bieber',
  //     'img': 'images/artworks-MapOsRlRxYh3VL35-cKqPaQ-t500x500.jpg'
  //   },
  //   {
  //     'Url':
  //         'https://docs.google.com/uc?export=download&id=1NlF3qev6FpDE269I8cbwJIQ56ojQ1e2k',
  //     'title': 'ခင်လေးစိမ်းတယ်',
  //     'singer': 'ဝေလ',
  //     'img': 'images/ab6761610000e5eb7376bba6fe463ea1c2812340.jpg'
  //   },
  // ];

  PlayList myPlayList = PlayList();

  void togglePlayPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(UrlSource(myPlayList.getUrl(currentIndex)));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void playCurrentSong() async {
    await audioPlayer.stop();
    await audioPlayer.play(UrlSource(myPlayList.getUrl(currentIndex)));
    setState(() {
      isPlaying = true;
    });
  }

  void playNext() {
    if (currentIndex < myPlayList.getUrl(currentIndex).length - 1) {
      currentIndex++;
      playCurrentSong();
    }
  }

  void playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      playCurrentSong();
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerComplete.listen((event) {
      if (isPlaying) {
        playNext();
      } else {
        audioPlayer.pause();
      }
      setState(() {
        isPlaying = !isPlaying;
      });
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _duration = duration;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 205, 226),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Spotimus",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 12, 28, 23),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GlassContainer(
                height: 250,
                width: 250,
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.40),
                    Colors.white.withOpacity(0.10)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                color: Colors.red,
                borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.60),
                    Colors.white.withOpacity(0.10),
                    Colors.lightBlueAccent.withOpacity(0.05),
                    Colors.lightBlueAccent.withOpacity(0.6)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.39, 0.40, 1.0],
                ),
                child: Image.asset(
                  myPlayList.getImg(currentIndex),
                  width: 250,
                )),
            const SizedBox(
              height: 20,
            ),
            Text(
              myPlayList.getTitel(currentIndex),
              // wordPair.asString,
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              myPlayList.getSinger(currentIndex),
              style: const TextStyle(fontSize: 10),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ProgressBar(
                barHeight: 3,
                thumbRadius: 8,
                progress: _position,
                buffered: const Duration(milliseconds: 2000),
                total: _duration,
                onSeek: (duration) {
                  debugPrint('User selected a new time: $duration');
                  audioPlayer.seek(duration);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GlassContainer(
                  height: 50,
                  width: 50,
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 116, 213, 213)
                          .withOpacity(0.40),
                      const Color.fromARGB(255, 168, 239, 248).withOpacity(0.10)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.60),
                      Colors.white.withOpacity(0.10),
                      Colors.lightBlueAccent.withOpacity(0.05),
                      Colors.lightBlueAccent.withOpacity(0.6)
                    ],
                  ),
                  shadowColor: Colors.black.withOpacity(0.20),
                  alignment: Alignment.center,
                  frostedOpacity: 0.12,
                  child: IconButton(
                    onPressed: playPrevious,
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Color.fromARGB(255, 7, 143, 255),
                    ),
                    iconSize: 33,
                  ),
                ),
                GlassContainer(
                  height: 60,
                  width: 60,
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 116, 213, 213)
                          .withOpacity(0.40),
                      const Color.fromARGB(255, 168, 239, 248).withOpacity(0.10)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.60),
                      Colors.white.withOpacity(0.10),
                      Colors.lightBlueAccent.withOpacity(0.05),
                      Colors.lightBlueAccent.withOpacity(0.6)
                    ],
                  ),
                  shadowColor: Colors.black.withOpacity(0.20),
                  alignment: Alignment.center,
                  frostedOpacity: 0.12,
                  child: IconButton(
                    onPressed: togglePlayPause,
                    icon: isPlaying
                        ? const Icon(
                            Icons.pause,
                            color: Color.fromARGB(255, 7, 143, 255),
                          )
                        : const Icon(
                            Icons.play_arrow,
                            color: Color.fromARGB(255, 7, 143, 255),
                          ),
                    iconSize: 33,
                  ),
                ),
                GlassContainer(
                  height: 50,
                  width: 50,
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 116, 213, 213)
                          .withOpacity(0.40),
                      const Color.fromARGB(255, 168, 239, 248).withOpacity(0.10)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderGradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.60),
                      Colors.white.withOpacity(0.10),
                      Colors.lightBlueAccent.withOpacity(0.05),
                      Colors.lightBlueAccent.withOpacity(0.6)
                    ],
                  ),
                  shadowColor: Colors.black.withOpacity(0.20),
                  alignment: Alignment.center,
                  frostedOpacity: 0.12,
                  child: IconButton(
                    onPressed: playNext,
                    icon: const Icon(
                      Icons.skip_next,
                      color: Color.fromARGB(255, 7, 143, 255),
                    ),
                    iconSize: 33,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
