// lib/main.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Impor untuk font
import 'pages/login_page.dart';

void main() {
  runApp(const TemuinApp());
}

class TemuinApp extends StatelessWidget {
  const TemuinApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temuin MVP',
      debugShowCheckedModeBanner: false, // Menghilangkan banner debug
      theme: ThemeData(
        // Perbarui untuk menggunakan Google Fonts Poppins sebagai default
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const LoginPage(), // Mulai dari Halaman Login
    );
  }
}