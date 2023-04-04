import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../global.dart';
import '../model/Song_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  loadJsonData() async {
    String res = await rootBundle.loadString("json/jsonData.json");

    List decodedData = jsonDecode(res);

    setState(() {
      Global.songList = decodedData.map((e) => Song.fromJSON(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Player"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: Global.songList!.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              setState(() {
                Global.index = i;
                Global.currentSong = Global.songList![i];
              });
              Navigator.of(context).pushNamed('AllSongPage');
            },
            child: Container(
              width: width,
              height: 95,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: Colors.teal,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Colors.teal,
                    Colors.redAccent,
                    Colors.amber,
                    Colors.tealAccent,
                    Colors.grey
                  ],
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    height: 90,
                    width: 85,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Global.songList![i].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    Global.songList![i].songName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 21,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
