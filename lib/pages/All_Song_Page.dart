import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

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
        autoStart: false);

    setState(() {
      duration = assetsAudioPlayer.current.value?.audio.duration;
    });
  }

  @override
  void initState() {
    super.initState();
    audioOpen();
  }

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Song 🎶",
          style: TextStyle(fontSize: 29, color: Colors.grey.shade500),
        ),
        centerTitle: true,
        // elevation: 2,
        backgroundColor: Colors.deepPurple.withOpacity(0.4),
      ),
      backgroundColor: Colors.deepPurple.withOpacity(0.5),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 75),
            Text(
              "${Global.currentSong.songName}",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const Spacer(),
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
                        : BoxFit.cover),
              ),
            ),
            const SizedBox(height: 25),
            StreamBuilder(
                stream: assetsAudioPlayer.currentPosition,
                //Global.currentSong.player.currentPosition,
                builder: (context, AsyncSnapshot snapshot) {
                  Duration currentPosition = snapshot.data;
                  return Column(
                    children: [
                      Text(
                        "${"$currentPosition".split(".")[0]}/ ${"$duration}".split(".")[0]}",
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
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
            const Spacer(),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 38,
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'HomePage', (route) => false);
                    },
                    icon: const Icon(Icons.filter_list),
                  ),
                  IconButton(
                    iconSize: 38,
                    onPressed: () {
                      if (Global.index > 0) {
                        setState(() {
                          assetsAudioPlayer.pause();
                          Global.index--;
                          Global.currentSong = Global.songList![Global.index];
                        });
                        Navigator.of(context)
                            .pushReplacementNamed('AllSongPage');
                      }
                    },
                    icon: const Icon(Icons.skip_previous),
                  ),
                  IconButton(
                    iconSize: 38,
                    onPressed: () async {
                      setState(() {
                        isPlaying = (isPlaying) ? false : true;
                      });
                      (isPlaying)
                          ? await assetsAudioPlayer.play()
                          : await assetsAudioPlayer.pause();
                    },
                    icon: (isPlaying)
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                  ),
                  IconButton(
                    onPressed: () {
                      if (Global.index < Global.songList!.length - 1) {
                        setState(() {
                          assetsAudioPlayer.pause();
                          Global.index++;
                          Global.currentSong = Global.songList![Global.index];
                        });
                        Navigator.of(context)
                            .pushReplacementNamed('AllSongPage');
                      }
                    },
                    icon: const Icon(Icons.skip_next),
                    iconSize: 38,
                  ),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        isPlaying = false;
                      });
                      assetsAudioPlayer.stop();
                    },
                    icon: const Icon(Icons.stop),
                    iconSize: 38,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
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
