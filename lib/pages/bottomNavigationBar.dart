import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'Person.dart';

class bgn extends StatefulWidget {
  const bgn({super.key});

  @override
  State<bgn> createState() => _bgnState();
}

class _bgnState extends State<bgn> {
  int currentIndex = 0;
  List<Widget> pages = [
    const HomePage(),
    const Person(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        height: 70,
        indicatorColor:Colors.white38,
        animationDuration: const Duration(seconds: 1),
        selectedIndex: currentIndex,
        onDestinationSelected: (int newIndex) => setState(() {
          currentIndex = newIndex;
        }),
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home'),
          NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile'),
        ],
      ),
    );
  }
}
