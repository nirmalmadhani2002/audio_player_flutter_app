import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../global.dart';

class AllSongPage extends StatefulWidget {
  const AllSongPage({Key? key}) : super(key: key);

  @override
  State<AllSongPage> createState() => _AllSongPageState();
}

class _AllSongPageState extends State<AllSongPage> {
  final AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  Duration? duration = Duration.zero;

  audioOpen() async {
    await assetsAudioPlayer.open(Audio(Global.currentSong.audio),
        autoStart: true);

    setState(() {
      duration = assetsAudioPlayer.current.value?.audio.duration;
    });
  }

  @override
  void initState() {
    super.initState();
    audioOpen();
  }

  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${Global.currentSong.songName}",
          style:GoogleFonts.teko(textStyle: TextStyle(
            fontSize: 29,
            color: Colors.white,
            letterSpacing: 5,
          ),)
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 200),
              Container(
                height: 230,
                width: 230,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(
                      "${Global.currentSong.image}",
                    ),
                    fit: (Global.currentSong.songName! == "L's Theme C")
                        ? BoxFit.fitHeight
                        : BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 150),
              StreamBuilder(
                  stream: assetsAudioPlayer.currentPosition,
                  builder: (context, AsyncSnapshot snapshot) {
                    Duration currentPosition = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: Text(
                            "${"$currentPosition".split(".")[0]}/ ${"$duration}".split(".")[0]}",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Slider(
                          min: 0,
                          max: duration!.inSeconds.toDouble(),
                          value: currentPosition.inSeconds.toDouble(),
                          onChanged: (val) async {
                            await assetsAudioPlayer
                                .seek(Duration(seconds: val.toInt()));
                          },
                        ),
                      ],
                    );
                  }),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width / 1,
        height: MediaQuery.of(context).size.height / 13,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('HomePage', (route) => false);
              },
              child: const Icon(
                Icons.filter_list,
                color: Colors.black,
                size: 38,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (Global.index > 0) {
                  setState(() {
                    assetsAudioPlayer.pause();
                    Global.index--;
                    Global.currentSong = Global.songList![Global.index];
                  });
                  Navigator.of(context).pushReplacementNamed(
                    'AllSongPage',
                  );
                }
              },
              child: const Icon(
                Icons.skip_previous,
                size: 38,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isPlaying = (isPlaying) ? false : true;
                });
                (isPlaying)
                    ? await assetsAudioPlayer.play()
                    : await assetsAudioPlayer.pause();
              },
              child: (isPlaying)
                  ? const Icon(
                      Icons.pause,
                      size: 38,
                color: Colors.black,
                    )
                  : const Icon(
                      Icons.play_arrow,
                color: Colors.black,
                      size: 38,
                    ),
            ),
            GestureDetector(
              onTap: () {
                if (Global.index < Global.songList!.length - 1) {
                  setState(() {
                    assetsAudioPlayer.pause();
                    Global.index++;
                    Global.currentSong = Global.songList![Global.index];
                  });
                  Navigator.of(context).pushReplacementNamed('AllSongPage');
                }
              },
              child: const Icon(
                Icons.skip_next,
                size: 38,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isPlaying = false;
                });
                assetsAudioPlayer.stop();
              },
              child: const Icon(
                Icons.stop,
                size: 38,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await assetsAudioPlayer.stop();
  }
}
