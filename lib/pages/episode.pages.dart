import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Episode extends StatefulWidget {
  const Episode({Key? key}) : super(key: key);

  @override
  _EpisodeState createState() => _EpisodeState();
}

class _EpisodeState extends State<Episode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Ini Episode', style: GoogleFonts.ubuntu()),
      ),
    );
  }
}
