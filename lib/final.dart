import 'package:quiz/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Parabens extends StatelessWidget {
  const Parabens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parábens você terminou o quiz!',
            style: GoogleFonts.roboto(
                fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          }, child: Text ('Página inicial'),
        ),
      ),
    );
  }
}