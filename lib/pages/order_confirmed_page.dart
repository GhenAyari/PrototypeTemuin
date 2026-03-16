// lib/pages/order_confirmed_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service_provider.dart';
import 'home_page.dart';

class OrderConfirmedPage extends StatelessWidget {
  final ServiceProvider provider;
  final double totalAmount;

  const OrderConfirmedPage({
    Key? key,
    required this.provider,
    required this.totalAmount,
  }) : super(key: key);

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
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Temuin', style: GoogleFonts.poppins(color: textDark, fontWeight: FontWeight.w600, fontSize: 18)),
        actions: [
          IconButton(icon: Icon(Icons.notifications, color: primaryPurple), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Success Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(color: successGreen, shape: BoxShape.circle, boxShadow: [
                BoxShadow(color: successGreen.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))
              ]),
              child: const Icon(Icons.check, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 32),
            
            // Text Header
            Text('Booking Confirmed!', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: textDark)),
            const SizedBox(height: 12),
            Text(
              'Your professional session has been secured. Get ready for an exceptional experience.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: textGray, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 24),
            
            // Order ID Pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(color: lightPurple, borderRadius: BorderRadius.circular(20)),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(color: textGray, fontSize: 12),
                  children: [
                    const TextSpan(text: 'Order ID: '),
                    TextSpan(text: 'TMN-88294-X', style: TextStyle(color: primaryPurple, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            
            // Service Summary Card
            _buildServiceSummaryCard(),
            const SizedBox(height: 24),
            
            // Help & Calendar Cards
            _buildActionCard(Icons.help_outline, 'Need help?', 'Contact your provider or our 24/7 support atelier.'),
            const SizedBox(height: 16),
            _buildActionCard(Icons.calendar_today, 'Add to Calendar', 'Sync this booking with Google or Apple Calendar.'),
            const SizedBox(height: 40),
            
            // Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: Text('View My Orders', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Kembali ke halaman awal dengan menghapus semua history tumpukan screen
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: lightPurple,
                  foregroundColor: textDark,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: Text('Back to Home', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Posisi aktif di tab Orders
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryPurple,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
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

  Widget _buildServiceSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: primaryPurple.withOpacity(0.05), blurRadius: 24, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SERVICE SUMMARY', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: successGreen)),
          const SizedBox(height: 20),
          Row(
            children: [
              CircleAvatar(radius: 28, backgroundImage: NetworkImage(provider.avatarUrl)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Provider', style: GoogleFonts.poppins(fontSize: 12, color: textGray)),
                    Text(provider.name, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: textDark)),
                    Text(provider.skill, style: GoogleFonts.poppins(fontSize: 12, color: primaryPurple)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildInfoRow(Icons.calendar_month, 'Date', 'October 24, 2024'), // Dummy date
          const SizedBox(height: 16),
          _buildInfoRow(Icons.schedule, 'Time', '10:30 AM - 11:30 AM'), // Dummy time
          const SizedBox(height: 24),
          const Divider(height: 1, thickness: 1),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Payment', style: GoogleFonts.poppins(fontSize: 12, color: textGray)),
                  Text('\$${totalAmount.toStringAsFixed(2)}', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: textDark)),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: mintGreen, borderRadius: BorderRadius.circular(16)),
                    child: Text('PAID', style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: successGreen)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: lightPurple, borderRadius: BorderRadius.circular(16)),
                    child: Text('DIGITAL\nRECEIPT', textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 8, fontWeight: FontWeight.bold, color: primaryPurple)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: lightPurple, shape: BoxShape.circle),
          child: Icon(icon, size: 18, color: primaryPurple),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: GoogleFonts.poppins(fontSize: 12, color: textGray)),
            Text(value, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: textDark)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: lightPurple.withOpacity(0.5), borderRadius: BorderRadius.circular(24)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: primaryPurple, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: textDark)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: textGray, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}