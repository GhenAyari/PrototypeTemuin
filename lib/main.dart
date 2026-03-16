import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login_page.dart';

// PUSAT KONTROL TEMA (Taruh di luar class)
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const TemuinApp());
}

class TemuinApp extends StatelessWidget {
  const TemuinApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Temuin MVP',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode, // Mengikuti saklar global
          
          // --- KAMUS TEMA TERANG ---
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFFBFaff), // Ini bgPurple
            primaryColor: const Color(0xFF735BF2), // Ini primaryPurple
            cardColor: const Color(0xFFEDE8FF), // Ini lightPurple (untuk kotak/container)
            
            // Setting warna AppBar otomatis
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFFBFaff),
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFF1A1A1A)), // Icon jadi hitam
            ),
            
            // Setting warna Teks otomatis
            textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              bodyLarge: GoogleFonts.poppins(color: const Color(0xFF1A1A1A)), // textDark
              bodyMedium: GoogleFonts.poppins(color: const Color(0xFF8A8A8A)), // textGray
              titleLarge: GoogleFonts.poppins(color: const Color(0xFF1A1A1A)), // Teks Header
            ),
          ),

          // --- KAMUS TEMA GELAP ---
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212), // bgPurple Gelap
            primaryColor: const Color(0xFF887BF4), // primaryPurple Gelap
            cardColor: const Color(0xFF1E1E1E), // lightPurple Gelap (abu-abu elegan)
            
            // Setting warna AppBar otomatis
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF121212),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white), // Icon jadi putih
            ),
            
            // Setting warna Teks otomatis
            textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              bodyLarge: GoogleFonts.poppins(color: Colors.white), // textDark Gelap
              bodyMedium: GoogleFonts.poppins(color: Colors.grey.shade400), // textGray Gelap
              titleLarge: GoogleFonts.poppins(color: Colors.white), // Teks Header Gelap
            ),
          ),
          
          home: const LoginPage(),
        );
      },
    );
  }
}