import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login_page.dart';

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
          themeMode: currentMode, 

          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFFBFaff), 

            primaryColor: const Color(0xFF735BF2), 

            cardColor: const Color(0xFFEDE8FF), 

            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFFFBFaff),
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFF1A1A1A)), 

            ),

            textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              bodyLarge: GoogleFonts.poppins(color: const Color(0xFF1A1A1A)), 

              bodyMedium: GoogleFonts.poppins(color: const Color(0xFF8A8A8A)), 

              titleLarge: GoogleFonts.poppins(color: const Color(0xFF1A1A1A)), 

            ),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212), 

            primaryColor: const Color(0xFF887BF4), 

            cardColor: const Color(0xFF1E1E1E), 

            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF121212),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white), 

            ),

            textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              bodyLarge: GoogleFonts.poppins(color: Colors.white), 

              bodyMedium: GoogleFonts.poppins(color: Colors.grey.shade400), 

              titleLarge: GoogleFonts.poppins(color: Colors.white), 

            ),
          ),

          home: const LoginPage(),
        );
      },
    );
  }
}