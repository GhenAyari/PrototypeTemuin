import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 

import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const primaryPurple = Color(0xFF887BF4); 

    const backgroundPurple = Color(0xFFF9F7FF); 

    const inputPurpleFill = Color(0xFFF1EEFF); 

    const darkText = Color(0xFF2C2C2C);
    const grayText = Color(0xFF787878);

    return Scaffold(
      backgroundColor: backgroundPurple, 

      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Temuin',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryPurple,
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.black54),
                ],
              ),
            ),

            const SizedBox(
              height: 100,
            ), 

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Step back into your creative atelier and continue your journey.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: grayText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50), 

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    'Email Address',
                    style: TextStyle(color: grayText),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: inputPurpleFill,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'name@example.com',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: primaryPurple,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Password', style: TextStyle(color: grayText)),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          style: GoogleFonts.poppins(
                            color: primaryPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: inputPurpleFill,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '••••••••', 

                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: primaryPurple,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        elevation: 0, 

                      ),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  Row(
                    children: [
                      const Expanded(child: Divider(color: Colors.black12)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Or continue with',
                          style: GoogleFonts.poppins(
                            color: grayText,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider(color: Colors.black12)),
                    ],
                  ),

                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SocialSignButton(
                        logo: const Text(
                          "G",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red, 

                          ),
                        ),
                        label: 'Google',
                        fillColor: inputPurpleFill,
                      ),
                      _SocialSignButton(
                        logo: const Icon(
                          Icons.apple,
                          color: Colors.black,
                          size: 24,
                        ), 

                        label: 'Apple',
                        fillColor: inputPurpleFill,
                      ),
                    ],
                  ),

                  const SizedBox(height: 60), 

                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: grayText,
                        ),
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Create Account',
                            style: TextStyle(
                              color: primaryPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialSignButton extends StatelessWidget {
  final Widget logo;
  final String label;
  final Color fillColor;

  const _SocialSignButton({
    Key? key,
    required this.logo,
    required this.label,
    required this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          (MediaQuery.of(context).size.width - 64) / 2.3, 

      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(50.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logo,
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

