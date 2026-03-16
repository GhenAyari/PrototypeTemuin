import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'my_orders_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  final Color bgPurple = const Color(0xFFFBFaff);
  final Color primaryPurple = const Color(0xFF533DEC);
  final Color textDark = const Color(0xFF2B2052);
  final Color textGray = const Color(0xFF8A8A8A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPurple,
      appBar: AppBar(
        backgroundColor: bgPurple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(color: textDark, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [

            _buildProfileHeader(),
            const SizedBox(height: 32),

            _buildStatsRow(),
            const SizedBox(height: 40),

            _buildSectionHeader('ACCOUNT SETTINGS'),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildSettingItem(Icons.person_outline, 'Edit Profile', Colors.blue.shade100),
              _buildSettingItem(Icons.notifications_none, 'Notification Settings', Colors.teal.shade100),
              _buildSettingItem(Icons.payment, 'Payment Methods', Colors.purple.shade100),
            ]),

            const SizedBox(height: 32),

            _buildSectionHeader('SUPPORT & LEGAL'),
            const SizedBox(height: 16),
            _buildSettingsCard([
              _buildSettingItem(Icons.help_outline, 'Help Center', Colors.indigo.shade100),
              _buildSettingItem(Icons.description_outlined, 'Terms of Service', Colors.deepPurple.shade100),
              _buildSettingItem(Icons.shield_outlined, 'Privacy Policy', Colors.blueGrey.shade100),
            ]),

            const SizedBox(height: 40),

            _buildLogoutButton(context),

            const SizedBox(height: 24),
            Text(
              'TEMUIN VERSION 2.4.0 (BUILD 108)',
              style: GoogleFonts.poppins(fontSize: 10, color: textGray, letterSpacing: 1),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4, 

        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryPurple,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
          if (index == 2) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyOrdersPage()));
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outline), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.blue, Colors.teal]),
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: primaryPurple, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
              child: const Icon(Icons.edit, color: Colors.white, size: 16),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('Andi Pratama', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: textDark)),
        Text('andi.pratama@email.com', style: GoogleFonts.poppins(fontSize: 14, color: textGray)),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('24', 'REVIEWS', false),
        _buildStatItem('128', 'BOOKINGS', true),
        _buildStatItem('42', 'SAVED', false),
      ],
    );
  }

  Widget _buildStatItem(String value, String label, bool isPrimary) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isPrimary ? primaryPurple : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Text(value, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: isPrimary ? Colors.white : primaryPurple)),
          Text(label, style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: isPrimary ? Colors.white.withOpacity(0.8) : textGray)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.bold, color: textGray, letterSpacing: 1),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20)],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, Color iconBg) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: primaryPurple, size: 20),
      ),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: textDark)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        },
        icon: const Icon(Icons.logout, color: Colors.red),
        label: Text('Logout', style: GoogleFonts.poppins(color: Colors.red, fontWeight: FontWeight.bold)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: Color(0xFFFFEBEE)),
          backgroundColor: const Color(0xFFFFEBEE).withOpacity(0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}