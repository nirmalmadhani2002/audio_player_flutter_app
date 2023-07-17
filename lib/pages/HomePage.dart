import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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
        backgroundColor: Colors.black,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: 400,
                  height: 200,
                  child: Image.network(
                    "https://media.istockphoto.com/id/1076840920/vector/music-background.jpg?s=612x612&w=0&k=20&c=bMG2SEUYaurIHAjtRbw7bmjLsXyT7iJUvAM5HjL3G3I=",
                    fit: BoxFit.cover,
                  ),
                ),
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: Text(
                "Music Player",
                style: GoogleFonts.allertaStencil(
                  textStyle: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                (Global.songList != null)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10, left: 18),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Episodes for you",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                width: 400,
                                height: 230,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Global.songList!.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Global.index = i;
                                          Global.currentSong =
                                              Global.songList![i];
                                        });
                                        Navigator.of(context)
                                            .pushNamed('AllSongPage');
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 100,
                                        margin: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              height: 155,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  Global.songList![i].image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                Global.songList![i].songName,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Episodes for you",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                width: 400,
                                height: 230,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Global.songList!.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Global.index = i;
                                          Global.currentSong =
                                              Global.songList![i];
                                        });
                                        Navigator.of(context)
                                            .pushNamed('AllSongPage');
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 100,
                                        margin: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              height: 155,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  Global.songList![i].image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                Global.songList![i].songName,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Episodes for you",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                              Container(
                                width: 400,
                                height: 230,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Global.songList!.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Global.index = i;
                                          Global.currentSong =
                                              Global.songList![i];
                                        });
                                        Navigator.of(context)
                                            .pushNamed('AllSongPage');
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 100,
                                        margin: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              height: 155,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  Global.songList![i].image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                Global.songList![i].songName,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Episodes for you",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                              SizedBox(
                                width: 400,
                                height: 230,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Global.songList!.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          Global.index = i;
                                          Global.currentSong =
                                              Global.songList![i];
                                        });
                                        Navigator.of(context)
                                            .pushNamed('AllSongPage');
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 100,
                                        margin: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              height: 155,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  Global.songList![i].image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                Global.songList![i].songName,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ]),
            )
          ],
        ));
  }
}
