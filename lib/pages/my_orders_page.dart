// lib/pages/my_orders_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart'; // Untuk navigasi bottom bar

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  // State untuk toggle tab (0 = Active, 1 = Past)
  int _selectedTab = 0;

  // Definisi Warna
  final Color bgPurple = const Color(0xFFFBFaff);
  final Color primaryPurple = const Color(0xFF533DEC);
  final Color lightPurple = const Color(0xFFEDE8FF);
  final Color textDark = const Color(0xFF2B2052);
  final Color textGray = const Color(0xFF8A8A8A);
  final Color successGreen = const Color(0xFF0F765E);
  final Color mintGreen = const Color(0xFF90F0D6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPurple,
      appBar: AppBar(
        backgroundColor: bgPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87), // Hamburger menu sesuai desain
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
            
            // Header Current Session
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Current Session', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: textDark)),
                Text('CONFIRMED', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: successGreen)),
              ],
            ),
            const SizedBox(height: 16),
            
            // Active Session Card
            _selectedTab == 0 ? _buildCurrentSessionCard() : _buildEmptyState('No active sessions right now.'),
            
            const SizedBox(height: 40),
            
            // Header Recent Sessions
            Text('Recent Sessions', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: textDark)),
            const SizedBox(height: 16),
            
            // Past Session Card
            _buildRecentSessionCard(),
            
            const SizedBox(height: 16),
            // Shimmer / Placeholder effect di paling bawah
            _buildPlaceholderCard(),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Fokus di tab Orders
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryPurple,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        onTap: (index) {
          if (index == 0) {
            // Jika klik Home, kembali ke halaman utama
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
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

  // --- WIDGET BUILDERS ---

  Widget _buildCustomTab() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: lightPurple.withOpacity(0.5), borderRadius: BorderRadius.circular(30)),
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
          color: isActive ? Colors.white : Colors.transparent,
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: primaryPurple.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, 15))],
      ),
      child: Column(
        children: [
          // Profil Header
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
                child: Text('LIVE', style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: successGreen)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Date & Time Pills
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFF6F4FF), borderRadius: BorderRadius.circular(20)),
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
                  decoration: BoxDecoration(color: const Color(0xFFF6F4FF), borderRadius: BorderRadius.circular(20)),
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
          
          // Join Session Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.videocam, color: Colors.white, size: 20),
              label: Text('Join Session', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRecentSessionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF6F4FF), borderRadius: BorderRadius.circular(28)),
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
                  backgroundColor: lightPurple,
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
      decoration: BoxDecoration(color: const Color(0xFFF6F4FF).withOpacity(0.5), borderRadius: BorderRadius.circular(28)),
      child: Row(
        children: [
          Container(width: 48, height: 48, decoration: BoxDecoration(color: lightPurple.withOpacity(0.5), shape: BoxShape.circle)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 120, height: 12, decoration: BoxDecoration(color: lightPurple.withOpacity(0.5), borderRadius: BorderRadius.circular(6))),
              const SizedBox(height: 8),
              Container(width: 80, height: 10, decoration: BoxDecoration(color: lightPurple.withOpacity(0.5), borderRadius: BorderRadius.circular(5))),
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
      decoration: BoxDecoration(color: lightPurple.withOpacity(0.3), borderRadius: BorderRadius.circular(24)),
      child: Center(
        child: Text(message, style: GoogleFonts.poppins(color: textGray, fontStyle: FontStyle.italic)),
      ),
    );
  }
}