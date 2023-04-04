import 'package:flutter/material.dart';

import 'pages/All_Song_Page.dart';
import 'pages/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'HomePage',
      routes: {
        'HomePage': (context) => const HomePage(),
        'AllSongPage': (context) => const AllSongPage(),
      },
    ),
  );
}
