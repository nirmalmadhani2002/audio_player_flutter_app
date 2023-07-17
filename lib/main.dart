import 'package:flutter/material.dart';
import 'package:media_booster_rainbow_color/pages/bottomNavigationBar.dart';
import 'pages/All_Song_Page.dart';
import 'pages/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: false),
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: 'bgn',
      routes: {
        'bgn': (context) => const bgn(),
        'HomePage': (context) => const HomePage(),
        'AllSongPage': (context) => const AllSongPage(),
      },
    ),
  );
}
