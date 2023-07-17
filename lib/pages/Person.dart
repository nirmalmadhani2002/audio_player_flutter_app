import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Profile",style: GoogleFonts.aclonica(
          textStyle: const TextStyle(
            fontSize: 25,
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),),
      ),
    );
  }
}
