import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart'; 

import 'chat_page.dart';
import 'profile_page.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  int _selectedTab = 0;

  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  Color get bgPurple => Theme.of(context).scaffoldBackgroundColor;
  Color get primaryPurple => Theme.of(context).primaryColor;
  Color get lightPurple => Theme.of(context).cardColor;
  Color get textDark => Theme.of(context).textTheme.bodyLarge?.color ?? const Color(0xFF1A1A1A);
  Color get textGray => Theme.of(context).textTheme.bodyMedium?.color ?? const Color(0xFF8A8A8A);

  Color get sessionCardBg => isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF6F4FF);
  Color get mintGreen => isDark ? const Color(0xFF1A3D36) : const Color(0xFF90F0D6);
  Color get successGreen => isDark ? const Color(0xFF67F5D1) : const Color(0xFF0F765E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPurple, 

      appBar: AppBar(
        backgroundColor: bgPurple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: textDark), 

          onPressed: () {},
        ),
        title: Text('My Orders', style: GoogleFonts.poppins(color: textDark, fontWeight: FontWeight.bold, fontSize: 18)),
        actions: [
          IconButton(icon: Icon(Icons.notifications, color: primaryPurple), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomTab(),
            const SizedBox(height: 32),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Current Session', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: textDark)),
                Text('CONFIRMED', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: successGreen)),
              ],
            ),
            const SizedBox(height: 16),

            _selectedTab == 0 ? _buildCurrentSessionCard() : _buildEmptyState('No active sessions right now.'),

            const SizedBox(height: 40),

            Text('Recent Sessions', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: textDark)),
            const SizedBox(height: 16),

            _buildRecentSessionCard(),

            const SizedBox(height: 16),
            _buildPlaceholderCard(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, 
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgPurple, 
        selectedItemColor: primaryPurple,
        unselectedItemColor: textGray,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
          } else if (index == 3) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildCustomTab() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEDE8FF), borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Expanded(child: _buildTabButton(0, 'Active')),
          Expanded(child: _buildTabButton(1, 'Past')),
        ],
      ),
    );
  }

  Widget _buildTabButton(int index, String title) {
    bool isActive = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? (isDark ? const Color(0xFF333333) : Colors.white) : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
          boxShadow: isActive ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))] : [],
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              color: isActive ? primaryPurple : textGray,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentSessionCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: lightPurple, 

        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: primaryPurple.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, 15))],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=200'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Marcus Thorne', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: textDark)),
                    const SizedBox(height: 4),
                    Text('Senior Full Stack\nArchitect', style: GoogleFonts.poppins(fontSize: 13, color: textGray, height: 1.3)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: mintGreen, borderRadius: BorderRadius.circular(12)),
                child: Text('LIVE', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: isDark ? const Color(0xFF0F765E) : successGreen)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: sessionCardBg, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Date', style: GoogleFonts.poppins(fontSize: 11, color: textGray)),
                      const SizedBox(height: 4),
                      Text('Oct 24, 2024', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: textDark)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: sessionCardBg, borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Time', style: GoogleFonts.poppins(fontSize: 11, color: textGray)),
                      const SizedBox(height: 4),
                      Text('10:00 AM', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: textDark)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

Row(
  children: [
    Expanded(
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.videocam, color: Colors.white, size: 20),
        label: Text(
          'Join Session',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPurple,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
      ),
    ),
    const SizedBox(width: 12),

    Container(
      height: 56, 

      width: 56,
      decoration: BoxDecoration(
        border: Border.all(color: primaryPurple, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: IconButton(
        icon: Icon(Icons.chat_bubble_outline, color: primaryPurple),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatPage(providerName: "Marcus Thorne"),
            ),
          );
        },
      ),
    ),
  ],
)        ],
      ),

    );
  }

  Widget _buildRecentSessionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: sessionCardBg, borderRadius: BorderRadius.circular(28)),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&q=80&w=200'),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Elena Rodriguez', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: textDark)),
                    Text('UI/UX Designer', style: GoogleFonts.poppins(fontSize: 12, color: textGray)),
                  ],
                ),
              ),
              Text('Oct 15, 2024', style: GoogleFonts.poppins(fontSize: 11, color: textGray)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle, color: successGreen, size: 16),
                  const SizedBox(width: 6),
                  Text('Completed', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: successGreen)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEDE8FF),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text('Rate Now', style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: primaryPurple)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: sessionCardBg.withOpacity(0.5), borderRadius: BorderRadius.circular(28)),
      child: Row(
        children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: isDark ? const Color(0xFF333333) : const Color(0xFFEDE8FF), shape: BoxShape.circle)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 120, height: 12, decoration: BoxDecoration(color: isDark ? const Color(0xFF333333) : const Color(0xFFEDE8FF), borderRadius: BorderRadius.circular(6))),
              const SizedBox(height: 8),
              Container(width: 80, height: 10, decoration: BoxDecoration(color: isDark ? const Color(0xFF333333) : const Color(0xFFEDE8FF), borderRadius: BorderRadius.circular(5))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEDE8FF), borderRadius: BorderRadius.circular(24)),
      child: Center(
        child: Text(message, style: GoogleFonts.poppins(color: textGray, fontStyle: FontStyle.italic)),
      ),
    );
  }
}